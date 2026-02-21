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
Game="Pokemon Infinite Fusion"
#Old static install path method
#GamePath="${logged_in_home}/Games/PokemonInfiniteFusion"
echo "Please provide the complete path for the existing installation. Files will be dropped into the selected folder directly"
sleep 5
GamePath=$(zenity --file-selection --directory)

#Check from static install method
echo -e "${BLUE}Updating ${Game} at:${NC} ${GamePath}/"
#if [ -d ${GamePath} ]
#then
#    echo "Folder exists, continuing..."
#else
#    echo "${RED}Existing PokemonInfiniteFusion Install not found in the expected lcoation, please run InfiniteFusion.sh first${NC}"
#    exit
#fi
cd "${GamePath}"
echo -e "${BLUE}Thanks to Hungry Pickle for making the offical Pokemon Infinite Fusion updater .bat script I used here${NC}"
git init .
git remote add origin "https://github.com/infinitefusion/infinitefusion-e18.git"
git fetch origin releases
git reset --hard origin/releases
echo -e "${BLUE}Update complete!"
