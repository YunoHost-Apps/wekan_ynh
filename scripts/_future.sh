ynh_version_gt ()
{
    dpkg --compare-versions "$1" gt "$2"
}
