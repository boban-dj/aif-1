#!/bin/bash

##
# Based from script found at: https://drupal.org/node/244924
# https://www.drupal.org/node/244924#comment-8654183
# See README or code below for usage
##

# Is this really necessary?
if [ $(id -u) != 0 ]; then
printf "This script must be run as root.\n"
exit 1
fi

# Script arguments
drupal_path=${1%/}
drupal_user=${2}
httpd_group="${3:-http}"

# Help menu
print_help() {
cat <<-HELP

This script is used to fix permissions of a Drupal installation
you need to provide the following arguments:

1) Path to your Drupal installation.
2) Username of the user that you want to give files/directories ownership.
3) HTTPD group name (defaults to www-data for Apache).

Usage: (sudo) bash drupal_perms.sh --drupal_path=PATH --drupal_user=USER --httpd_group=GROUP

Example: (sudo) bash drupal_perms.sh --drupal_path=/srv/http/drupal_site --drupal_user=boban --httpd_group=http

HELP
exit 0
}

# Parse Command Line Arguments
while [ $# -gt 0 ]; do
case "$1" in
--drupal_path=*)
  drupal_path="${1#*=}"
  ;;
--drupal_user=*)
  drupal_user="${1#*=}"
  ;;
--httpd_group=*)
  httpd_group="${1#*=}"
  ;;
--help) print_help;;
*)
  printf "Invalid argument, run --help for valid arguments.\n";
  exit 1
esac
shift
done

# Basic check to see if this is a valid Drupal install
if [ -z "${drupal_path}" ] || [ ! -d "${drupal_path}/sites" ] || [ ! -f "${drupal_path}/modules/system/system.module" ]; then
printf "Please provide a valid Drupal path.\n"
print_help
exit 1
fi

# Basic check to see if valiud user
if [ -z "${drupal_user}" ] || [ $(id -un ${drupal_user} 2> /dev/null) != "${drupal_user}" ]; then
printf "Please provide a valid user.\n"
print_help
exit 1
fi

# Start changing permissions
cd $drupal_path
printf "Changing ownership of all contents of \"${drupal_path}\":\n user => \"${drupal_user}\" \t group => \"${httpd_group}\"\n"
chown -R ${drupal_user}:${httpd_group} .

printf "Changing permissions of all directories inside \"${drupal_path}\" to \"rwxr-x---\"...\n"
#find . -type d -exec chmod u=rwx,g=rx,o= '{}' \+
find . -type d -not -path "./sites/*/files" -not -path "./sites/*/files/*" -not -name ".git" -exec chmod u=rwx,g=rx,o= '{}' \+

printf "Changing permissions of all files inside \"${drupal_path}\" to \"rw-r-----\"...\n"
#find . -type f -exec chmod u=rw,g=r,o= '{}' \+
find . -type f -not -path "./sites/*/settings.php" -not -path "./sites/*/default.settings.php" -not -path "./sites/*/files/*" -not -name ".gitignore" -exec chmod u=rw,g=r,o= '{}' \+

printf "Changing permissions of \"files\" directories in \"${drupal_path}/sites\" to \"rwxrwx---\"...\n"
cd ${drupal_path}/sites
find . -type d -name files -exec chmod ug=rwx,o= '{}' \+

printf "Changing permissions of settings.php and default.settings.php files inside all directories in \"${drupal_path}/sites\" to \"r--r-----\"...\n"
for x in ./*/settings.php; do
printf "Changing permissions ${x} ...\n"
find ${x} -type f -exec chmod ug=r,o= '{}' \+
done
for x in ./*/default.settings.php; do
printf "Changing permissions ${x} ...\n"
find ${x} -type f -exec chmod ug=r,o= '{}' \+
done

printf "Changing permissions of all files inside all \"files\" directories in \"${drupal_path}/sites\" to \"rw-rw----\"...\n"
printf "Changing permissions of all directories inside all \"files\" directories in \"${drupal_path}/sites\" to \"rwxrwx---\"...\n"
for x in ./*/files; do
printf "Changing permissions ${x} ...\n"
find ${x} -type d -not -name ".git" -exec chmod ug=rwx,o= '{}' \+
find ${x} -type f -not -path "./*/files/.htaccess" -exec chmod ug=rw,o= '{}' \+
done

printf "Changing permissions of .htaccess files inside all \"files\" directories in \"${drupal_path}/sites\" to \"rw-r----\"...\n"
for x in ./*/files/.htaccess; do
printf "Changing permissions ${x} ...\n"
find ${x} -type f -exec chmod u=rw,g=r,o= '{}' \+
done

printf "Changing permissions of \".git\" directories and files in \"${drupal_path}\" to \"rwx------\"...\n"
cd ${drupal_path}
chmod -R u=rwx,go= .git
chmod u=rwx,go= .gitignore

printf "Changing permissions of various Drupal text files in \"${drupal_path}\" to \"rwx------\"...\n"
cd ${drupal_path}
chmod u=rwx,go= CHANGELOG.txt COPYRIGHT.txt INSTALL.mysql.txt INSTALL.pgsql.txt INSTALL.txt LICENSE.txt MAINTAINERS.txt UPGRADE.txt

echo "Done setting proper permissions on files and directories"
