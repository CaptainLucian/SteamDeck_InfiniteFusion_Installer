#We need to import the library made to work with Valve's vdf format
import vdf
from sys import exit
#importing libraries need to pull in variables
import os, re

# This code block is copied from NonSteamLaunchers-On-Steam-Deck to pull in the variables left by the Bash script
# Path to the env_vars file
env_vars_path = f"{os.environ['HOME']}/.config/systemd/user/env_vars"

# Check if the env_vars file exists
if not os.path.exists(env_vars_path):
    print(f"Error: {env_vars_path} does not exist.")
    sys.exit(1)

# Read variables from the file
with open(env_vars_path, 'r') as f:
    lines = f.readlines()

for line in lines:
    if line.startswith('export '):
        line = line[7:]  # Remove 'export '
    name, value = line.strip().split('=', 1)
    os.environ[name] = value

# Variables from NonSteamLaunchers.sh
logged_in_home = os.environ['logged_in_home']
steamid3 = os.environ['steamid3']
gamepath = os.environ['gamepath']
filepath = logged_in_home +'/.steam/steam/userdata/'+steamid3+'/config/shortcuts.vdf'
#Binary Read in of the contents and stored as the variable "shortcuts"
with open(filepath,'rb') as file:
    shortcuts = vdf.binary_loads(file.read())

#To easily inject the entry I'm adding it to a variable
#A great place to improve this would be making the AppID auto generate to a unique value but that was quickly getting over my head
#Another place to improve would be pulling in the home location variables for this to work for non-default users    
startdir = '"'+gamepath+'"'
exe = '"'+gamepath+'/Game.exe'+'"'
PIF = {
    'appid': "-207231401",
    'appname': "Pokemon Infinite Fusion",
    'Exe': exe,
    'StartDir' : startdir,
    'icon' : "",
    'ShortcutPath' : "",
    'LaunchOptions' : "",
    'IsHidden': "0",
    'AllowDesktopConfig': "1",
    'AllowOverlay' : "1",
    'OpenVR' : "0",
    'Devkit' : "0",
    'DevkitGameID' : "",
    'DevkitOverideAppID' : "",
    'LastPlayTime' : "",
    'FlatpakAppID' : "",
    'tags' : ""
}
#One of the complications I had was figuring out how to set the next entry number
#The way this data comes in is flat and the only tier I can pull out is a whole entry, so I can't manipulate the number easily
#I'm working around that by counting the number of entries in the dict and using that
#Since the dict starts at 0, it works out perfect that the number of current entries will be the next number used

NextID = (len(shortcuts))
NextID = str(NextID)
#Adding the entry to the dict using the entry number we made and defining that entry as the variable we set
shortcuts['shortcuts'][NextID] = PIF
#Finally we are writing the list we just made to the file
with open(filepath,'wb') as file:
    file.write(vdf.binary_dumps(shortcuts))
#Dumps results to a text file so you can review the output. Uncomment it out if you are seeing issues.
#vdf.dump(shortcuts, open('file2.txt','w'), pretty=True)
