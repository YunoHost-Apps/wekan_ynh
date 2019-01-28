

log() {
  echo "${1}"
}

info() {
  log "[INFO] ${1}"
}

warn() {
  log "[WARN] ${1}"
}

err() {
  log "[ERR] ${1}"
}
to_logs() {

  # When yunohost --verbose or bash -x
  if $_ISVERBOSE; then
    cat
  else
    cat > /dev/null
  fi
}

read_json () {
    sudo python3 -c "import sys, json;print(json.load(open('$1'))['$2'])"
}

read_manifest () {
    if [ -f '../manifest.json' ] ; then
        read_json '../manifest.json' "$1"
    else
        read_json '../settings/manifest.json' "$1"
    fi
}
abort_if_up_to_date () {
    version=$(read_json "/etc/yunohost/apps/$YNH_APP_INSTANCE_NAME/manifest.json" 'version' 2> /dev/null || echo '20160501-7')
    last_version=$(read_manifest 'version')
    if [ "${version}" = "${last_version}" ]; then
        info "Up-to-date, nothing to do"
        ynh_die "" 0
    fi
}



#=================================================
# NODEJS
#=================================================

# INFOS
# n (Node version management) utilise la variable PATH pour stocker le path de la version de node à utiliser.
# C'est ainsi qu'il change de version
# ynh_install_nodejs installe la version de nodejs demandée en argument, avec n
# ynh_use_nodejs active une version de nodejs dans le script courant
# 3 variables sont mises à disposition, et 2 sont stockées dans la config de l'app
# - nodejs_path: Le chemin absolu de cette version de node
# Utilisé pour des appels directs à node.
# - nodejs_version: Simplement le numéro de version de nodejs pour cette application
# - nodejs_use_version: Un alias pour charger une version de node dans le shell courant.
# Utilisé pour démarrer un service ou un script qui utilise node ou npm
# Dans ce cas, c'est $PATH qui contient le chemin de la version de node. Il doit être propagé sur les autres shell si nécessaire.

n_install_dir="/opt/node_n"
node_version_path="/opt/node_n/n/versions/node"
# N_PREFIX est le dossier de n, il doit être chargé dans les variables d'environnement pour n.
export N_PREFIX="$n_install_dir"

ynh_use_nodejs () {
    nodejs_version=$(ynh_app_setting_get $app nodejs_version)

    load_n_path="[[ :$PATH: == *\":$n_install_dir/bin:\"* ]] || PATH=\"$n_install_dir/bin:$PATH\"; N_PREFIX="$n_install_dir""

    nodejs_use_version="$n_install_dir/bin/n -q $nodejs_version"

    # "Load" a version of node
    eval $load_n_path; $nodejs_use_version

    # Get the absolute path of this version of node
    nodejs_path="$(n bin $nodejs_version)"

    # Make an alias for node use
    ynh_node_exec="eval $load_n_path; n use $nodejs_version"
}

ynh_install_nodejs () {
    # Use n, https://github.com/tj/n to manage the nodejs versions
    nodejs_version="$1"
    local n_install_script="https://git.io/n-install"

    # Create $n_install_dir
    mkdir -p "$n_install_dir"

    # Load n path in PATH
    CLEAR_PATH="$n_install_dir/bin:$PATH"
    # Remove /usr/local/bin in PATH in case of node has already setup.
    PATH=$(echo $CLEAR_PATH | sed 's@/usr/local/bin:@@')

    # Move an existing node binary, to avoid to block n.
    test -x /usr/bin/node && mv /usr/bin/node /usr/bin/node_n
    test -x /usr/bin/npm && mv /usr/bin/npm /usr/bin/npm_n

    # If n is not previously setup, install it
    n --version > /dev/null 2>&1 || \
    (curl -sL $n_install_script | N_PREFIX=$N_PREFIX bash -s -- -y - 2>&1 )

    # Modify the default N_PREFIX in n script
    ynh_replace_string "^N_PREFIX=\${N_PREFIX-.*}$" "N_PREFIX=\${N_PREFIX-$N_PREFIX}" "$n_install_dir/bin/n"

    # Restore /usr/local/bin in PATH
    PATH=$CLEAR_PATH

    # And replace the old node binary.
    test -x /usr/bin/node_n && mv /usr/bin/node_n /usr/bin/node
    test -x /usr/bin/npm_n && mv /usr/bin/npm_n /usr/bin/npm

    # Install the requested version of nodejs
    n $nodejs_version

    # Find the last "real" version for this major version of node.
    real_nodejs_version=$(find $node_version_path/$nodejs_version* -maxdepth 0 | sort --version-sort | tail --lines=1)
    real_nodejs_version=$(basename $real_nodejs_version)

    # Create a symbolic link for this major version. If the file doesn't already exist
    if [ ! -e "$node_version_path/$nodejs_version" ]
    then
        ln --symbolic --force --no-target-directory $node_version_path/$real_nodejs_version $node_version_path/$nodejs_version
    fi

    # Store the ID of this app and the version of node requested for it
    echo "$YNH_APP_ID:$nodejs_version" | tee --append "$n_install_dir/ynh_app_version"

    # Store nodejs_version into the config of this app
    ynh_app_setting_set $app nodejs_version $nodejs_version

    # Build the update script and set the cronjob
    ynh_cron_upgrade_node

    ynh_use_nodejs
}

ynh_remove_nodejs () {
    ynh_use_nodejs

    # Remove the line for this app
    sed --in-place "/$YNH_APP_ID:$nodejs_version/d" "$n_install_dir/ynh_app_version"

    # If none another app uses this version of nodejs, remove it.
    if ! grep --quiet "$nodejs_version" "$n_install_dir/ynh_app_version"
    then
        n rm $nodejs_version
    fi

    # If none another app uses n, remove n
    if [ ! -s "$n_install_dir/ynh_app_version" ]
    then
        ynh_secure_remove "$n_install_dir"
        ynh_secure_remove "/usr/local/n"
        sed --in-place "/N_PREFIX/d" /root/.bashrc
	rm -f /etc/cron.daily/node_update
    fi
}

ynh_cron_upgrade_node () {
    # Build the update script
    cat > "$n_install_dir/node_update.sh" << EOF
#!/bin/bash

version_path="$node_version_path"
n_install_dir="$n_install_dir"

# Log the date
date

# List all real installed version of node
all_real_version="\$(find \$version_path/* -maxdepth 0 -type d | sed "s@\$version_path/@@g")"

# Keep only the major version number of each line
all_real_version=\$(echo "\$all_real_version" | sed 's/\..*\$//')

# Remove double entries
all_real_version=\$(echo "\$all_real_version" | sort --unique)

# Read each major version
while read version
do
    echo "Update of the version \$version"
    sudo \$n_install_dir/bin/n \$version

    # Find the last "real" version for this major version of node.
    real_nodejs_version=\$(find \$version_path/\$version* -maxdepth 0 | sort --version-sort | tail --lines=1)
    real_nodejs_version=\$(basename \$real_nodejs_version)

    # Update the symbolic link for this version
    sudo ln --symbolic --force --no-target-directory \$version_path/\$real_nodejs_version \$version_path/\$version
done <<< "\$(echo "\$all_real_version")"
EOF

    chmod +x "$n_install_dir/node_update.sh"

    # Build the cronjob
    cat > "/etc/cron.daily/node_update" << EOF
#!/bin/bash

$n_install_dir/node_update.sh >> $n_install_dir/node_update.log
EOF

    chmod +x "/etc/cron.daily/node_update"
}

ynh_version_gt ()
{
    dpkg --compare-versions "$1" gt "$2"
}
