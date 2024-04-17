#!/bin/bash
#set -x              # activate debugging (execution shown)
set -o pipefail     # capture error from pipes

# ENVIRONMENT VARIABLES
# $USER
[[ -n $(logname >/dev/null 2>&1) ]] && logged_in_user=$(logname) || logged_in_user=$(whoami)

echo "Downloading/Updating Pokemon Infinite Fusion at home/user/Games/PokemonInfiniteFusion"
if [ -d ~/Games/"PokemonInfiniteFusion" ]
then
    echo "Folder exists, moving on"
else
    echo "Existing PokemonInfiniteFusion Install not found in the expected lcoation, please run InfiniteFusion.sh first"
    end
fi
cd ~/Games/"PokemonInfiniteFusion"
echo "Thanks to Hungry Pickle for making the offical Pokemon Infinite Fusion updater .bat script I used here"
git init .
git remote add origin "https://github.com/infinitefusion/infinitefusion-e18.git"
git fetch origin releases
git reset --hard origin/releases
echo "Update complete"
