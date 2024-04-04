#!/bin/bash
#set -x              # activate debugging (execution shown)
set -o pipefail     # capture error from pipes

# ENVIRONMENT VARIABLES
# $USER
[[ -n $(logname >/dev/null 2>&1) ]] && logged_in_user=$(logname) || logged_in_user=$(whoami)

echo "Downloading Pokemon Infinite Fusion 6.1.3 to home/user/Games/Testing Ground"
if [ -d ~/Games/"Testing Ground" ]
then
    echo "Folder exists, moving on"
else
    mkdir -p ~/Games/"Testing Ground"
fi
cd ~/Games/"Testing Ground"
#if [ -f ~/Games/"Testing Ground"/6.1.3.zip ]
#then
#    echo "6.1.3.zip already found, moving to install"
#else
#    echo "Downloading"
#    wget "https://github.com/infinitefusion/infinitefusion-e18/archive/refs/tags/6.1.3.zip"
#   sleep 120
#    echo "wakey wakey, sleep is done"
#fi
#if [ -f ~/Games/"Testing Ground"/Game.exe ]
#then
#    echo "Files found, moving on to updates.."
#else
#    unzip \*.zip
#fi
#echo "Checking for Updates...."
git init .
git remote add origin "https://github.com/infinitefusion/infinitefusion-e18.git"
git fetch origin releases
git reset --hard origin/releases
echo "Install complete, adding to Steam.."
