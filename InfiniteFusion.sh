#!/bin/bash
#set -x              # activate debugging (execution shown)
set -o pipefail     # capture error from pipes

# ENVIRONMENT VARIABLES
# $USER
[[ -n $(logname >/dev/null 2>&1) ]] && logged_in_user=$(logname) || logged_in_user=$(whoami)

logged_in_home=$(eval echo "~${logged_in_user}")
# Set the default Steam directory
steam_dir="${logged_in_home}/.local/share/Steam"
# We are going to need to know where this file is to call it later so I'm making a copy with an absolute path so we can use it after changing directories.
cp SteamShortcutMaker.py ${logged_in_home}/Desktop

echo "Downloading/Updating Pokemon Infinite Fusion at ${logged_in_home}/Games/PokemonInfiniteFusion"
if [ -d ${logged_in_home}/Games/"PokemonInfiniteFusion" ]
then
    echo "Folder exists, moving on"
else
    mkdir -p ${logged_in_home}/Games/"PokemonInfiniteFusion"
fi
cd ${logged_in_home}/Games/"PokemonInfiniteFusion"
echo "Thanks to Hungry Pickle for making the offical Pokemon Infinite Fusion updater .bat script I used here"
git init .
git remote add origin "https://github.com/infinitefusion/infinitefusion-e18.git"
git fetch origin releases
git reset --hard origin/releases
echo "Install complete, adding to Steam.. Thank you NonSteamLaunchers team for making something to reference"

###Massive NonSteamLaunchers copy start

# Check if the loginusers.vdf file exists
if [[ -f "${logged_in_home}/.steam/root/config/loginusers.vdf" ]]; then
    # Extract the block of text for the most recent user
    most_recent_user=$(sed -n '/"users"/,/"MostRecent" "1"/p' "${logged_in_home}/.steam/root/config/loginusers.vdf")

    # Initialize variables
    max_timestamp=0
    current_user=""
    current_steamid=""

    # Process each user block
	# Set IFS to only look for Commas to avoid issues with Whitespace in older account names.
    while IFS="," read steamid account timestamp; do
        if (( timestamp > max_timestamp )); then
            max_timestamp=$timestamp
            current_user=$account
            current_steamid=$steamid
        fi
	# Output our discovered values as comma seperated string to be read into the IDs.
    done < <(echo "$most_recent_user" | awk -v RS='}\n' -F'\n' '
    {
        for(i=1;i<=NF;i++){
            if($i ~ /[0-9]{17}/){
                split($i,a, "\""); steamid=a[2];
            }
            if($i ~ /"AccountName"/){
                split($i,b, "\""); account=b[4];
            }
            if($i ~ /"Timestamp"/){
                split($i,c, "\""); timestamp=c[4];
            }
        }
        print steamid "," account "," timestamp
    }')

    # Print the currently logged in user
    if [[ -n $current_user ]]; then
        echo "Currently logged in user: $current_user"
        echo "SteamID: $current_steamid"
    else
        echo "No users found."
    fi

    # Convert steamid to steamid3
    steamid3=$((current_steamid - 76561197960265728))

    # Directly map steamid3 to userdata folder
    userdata_folder="${logged_in_home}/.steam/root/userdata/${steamid3}"

    # Check if userdata_folder exists
    if [[ -d "$userdata_folder" ]]; then
        echo "Found userdata folder for user with SteamID $current_steamid: $userdata_folder"
    else
        echo "Could not find userdata folder for user with SteamID $current_steamid"
    fi
else
    echo "Could not find loginusers.vdf file"
fi
# Check if userdata folder was found
if [[ -n "$userdata_folder" ]]; then
    # Userdata folder was found
    echo "Current user's userdata folder found at: $userdata_folder"

    # Find shortcuts.vdf file for current user
    shortcuts_vdf_path=$(find "$userdata_folder" -type f -name shortcuts.vdf)

    # Check if shortcuts_vdf_path is not empty
    if [[ -n "$shortcuts_vdf_path" ]]; then
        # Create backup of shortcuts.vdf file
        cp "$shortcuts_vdf_path" "$shortcuts_vdf_path.bak"
    else
        # Find config directory for current user
        config_dir=$(find "$userdata_folder" -maxdepth 1 -type d -name config)

        # Check if config_dir is not empty
        if [[ -n "$config_dir" ]]; then
            # Create new shortcuts.vdf file at expected location for current user
            touch "$config_dir/shortcuts.vdf"
            shortcuts_vdf_path="$config_dir/shortcuts.vdf"
        else
            # Create new config directory and new shortcuts.vdf file at expected location for current user
            mkdir "$userdata_folder/config/"
            touch "$userdata_folder/config/shortcuts.vdf"
            config_dir="$userdata_folder/config/"
            shortcuts_vdf_path="$config_dir/shortcuts.vdf"
        fi
    fi
else
    # Userdata folder was not found
    echo "Current user's userdata folder not found"
fi
# Check if userdata folder was found
if [[ -n "$userdata_folder" ]]; then
    # Userdata folder was found
    echo "Current user's userdata folder found at: $userdata_folder"

    # Find shortcuts.vdf file for current user
    shortcuts_vdf_path=$(find "$userdata_folder" -type f -name shortcuts.vdf)

    # Check if shortcuts_vdf_path is not empty
    if [[ -n "$shortcuts_vdf_path" ]]; then
        # Create backup of shortcuts.vdf file
        cp "$shortcuts_vdf_path" "$shortcuts_vdf_path.bak"
    else
        # Find config directory for current user
        config_dir=$(find "$userdata_folder" -maxdepth 1 -type d -name config)

        # Check if config_dir is not empty
        if [[ -n "$config_dir" ]]; then
            # Create new shortcuts.vdf file at expected location for current user
            touch "$config_dir/shortcuts.vdf"
            shortcuts_vdf_path="$config_dir/shortcuts.vdf"
        else
            # Create new config directory and new shortcuts.vdf file at expected location for current user
            mkdir "$userdata_folder/config/"os.environ.ge
            touch "$userdata_folder/config/shortcuts.vdf"
            config_dir="$userdata_folder/config/"
            shortcuts_vdf_path="$config_dir/shortcuts.vdf"
        fi
    fi
else
    # Userdata folder was not found
    echo "Current user's userdata folder not found"
fi

# Pre check for updating the config file

# Set the default Steam directory
steam_dir_root="${logged_in_home}/.steam/root"

# Set the path to the config.vdf file
config_vdf_path="${steam_dir_root}/config/config.vdf"

# Check if the config.vdf file exists
if [ -f "$config_vdf_path" ]; then
    # Create a backup of the config.vdf file
    backup_path="${steam_dir_root}/config/config.vdf.bak"
    cp "$config_vdf_path" "$backup_path"

    # Set the name of the compatibility tool to use
    compat_tool_name=$(ls "${logged_in_home}/.steam/root/compatibilitytools.d" | grep "GE-Proton" | sort -V | tail -n1)
else
    echo "Could not find config.vdf file"
fi
echo "export logged_in_home=$logged_in_home" >> ${logged_in_home}/.config/systemd/user/env_vars
echo "export steamid3=$steamid3" >> ${logged_in_home}/.config/systemd/user/env_vars
### Massive NonSteamLaunchers copy end

echo "installing python script dependency"
python3 -m pip install vdf

#curl "home/deck/Desktop/SteamShortcutMaker.py" "https://github.com/CaptainLucian/SteamDeck_InfiniteFusion_Installer/blob/main/SteamShortcutMaker.py"

echo "starting python script"
python3 ${logged_in_home}/Desktop/SteamShortcutMaker.py

rm ${logged_in_home}/Desktop/SteamShortcutMaker.py

echo "If no errors occured, the shortcut has been added to Steam.Steam may need to be restarted to take effect"
