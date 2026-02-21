#!/bin/bash
#set -x              # activate debugging (execution shown)
set -o pipefail     # capture error from pipes
RED='\033[0;31m'
NC='\033[0m' # No Color
BLUE='\033[0;34m'

# ENVIRONMENT VARIABLES
# $USER
[[ -n $(logname >/dev/null 2>&1) ]] && logged_in_user=$(logname) || logged_in_user=$(whoami)
logged_in_home=$(eval echo "~${logged_in_user}")
installer_dir=$(echo $PWD)
gameid=$(cat "${installer_dir}/gameid.txt")
cd "${logged_in_home}/.steam/steam/steamapps/compatdata/${gameid}/pfx/drive_c/users/steamuser/AppData/Roaming/"
cp -r ./infinitefusion ${installer_dir}/SaveBackup
echo "Your saves have been backed up to ${installer_dir}/SaveBackup"
exit
