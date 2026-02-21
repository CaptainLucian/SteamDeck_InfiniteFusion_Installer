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
#if [ -f "${installer_dir}/path.txt" ]
#then
#    echo -e "Install Path Found at gamepath"
#    GamePath=$(cat ${installer_dir}/path.txt)
#else
#    echo -e "No existing path file found, please select the installed folder"
#    sleep 5
#    GamePath=$(zenity --file-selection --directory)
#    echo "$GamePath" >> "$installer_dir"/path.txt
#fi
cd "${logged_in_home}/.steam/steam/steamapps/compatdata/"
GameID=$(ls -Art | tail -n 1)
echo "$GameID" >> "$installer_dir"/gameid.txt
echo "Last created CompatID saved to file"
exit
