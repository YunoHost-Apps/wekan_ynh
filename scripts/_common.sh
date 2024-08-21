#!/bin/bash

#=================================================
# COMMON VARIABLES
#=================================================

nodejs_version="14"
mongo_version="7.0"

#=================================================
# PERSONAL HELPERS
#=================================================

ynh_sync_admin_user_to_wekan() {
    local tmp=$(mktemp -d)

    ynh_setup_source --dest_dir="$tmp"  --source_id="ldap"
    ynh_add_config --template="add_admin_user.py" --destination="$tmp/add_admin_user.py"

    python3 -m venv $tmp
    $tmp/bin/pip install pymongo python-ldap environs python3-dev
    
    source "$install_dir/.env"

    $tmp/bin/python $tmp/add_admin_user.py

    ynh_secure_remove --file="$tmp"
}

#=================================================
# EXPERIMENTAL HELPERS
#=================================================

#=================================================
# FUTURE OFFICIAL HELPERS
#=================================================
