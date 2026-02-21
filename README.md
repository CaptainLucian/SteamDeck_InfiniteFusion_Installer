# SteamDeck_InfiniteFusion_Installer 

Not officially affiliated or approved by the Pokemon Infinite Fusion team, though the files should be genuine. I utilize the github link from official installer/updater.bat script. If you are looking for the offical resources look for the Discord or check r/PokemonInfiniteFusion

Summary:
A learning project to try and programmatically add entries to Steam for applications. In short, if you want to install a game or application that utilizes an installer on a Linux system via Proton you'd need to add the installer manually, set the Proton version manually, run the installer, and update the Steam shortcut to use the game's exe. If the game or application ALSO has a seperate exe to run updates you need to update the shortcut to point to the updater, run it, and then change it back, which is cumbersome.

Statement of Problem:
Adding non-Steam games with installers can be more complicated than non-technical Steam Deck users would want to engage in, and clunky even for more technical users.

Limitations of Methodology:
Because my end goal is specifcally to have a game or application's shortcut to be directly added to Steam, I need to know exactly what and where that final .exe is. This means it would need to be implemented per game/application.

Method:
As this is a learning project, I'm not coming in with the knowledge of how to do this. To be able to effectively start chipping away at this, I will utliize the open-source information from https://github.com/moraroy/NonSteamLaunchers-On-Steam-Deck as a reference, as it largely does what I want to do but specifically for a handful of launchers.

First Target:
As I need to pick a specific application to start with that I'm familiar with, I pick Pokemon Infinite Fusion (https://github.com/infinitefusion/infinitefusion-e18). The reasoning being that it easily offers a place for the script to expand, as it is a game that requires a seperate process be run to update it. The update script itself is quite simple, so if I'm able to point to the folder directly by scraping the compatdata folder I can eliminate the need to swapping around the paths the shortcut needs to use, as it's just a set of git commands so Proton isn't needed, and the additional steps set in the script to use mintgit aren't needed as this script will be SteamOS focused so git will be present. It also offers plenty of other spaces to expand if desired, such as a save data back-up tool. 

Addendum: This isn't as immediately expandable as I'd hoped, as there isn't a consistent place I can use as a hardcoded URL to get the new sprite packs as they release.

# How To Use
This installer is meant for SteamDeck installs, if you are looking to install it via Windows use the official methods outlined on r/PokemonInfiniteFusion. There is no promise of support, this is just a learning project.

As of v1.5, this is the process.
1) Download v1.5
2) Extract the SteamDeck_InfiniteFusion_Installer folder
3) Right-click on InfiniteFusion.sh and select "Run in Konsole"
4) It will prompt you to select an install location. It will treat this as the final folder and install all files directly to it! So please select your final InfiniteFusion folder in this window.
5) Once the terminal says "If no errors occured, the shortcut has been added to Steam. Steam may need to be restarted to take effect" the script has finished.
6) If the script was successful, close Steam entirely (right-click on it in the taskbar and hit close)
7) Re-open Steam
8) Pokemon Infinite Fusion should now be in your game list
9) Right-click on Pokemon Infinite Fusion and select "Properties"
10) Go to the Compatibility tab and force the use of a specific tool
11) Set it to Proton GE or Experimental
12) Run the game! If you've not played it before be sure to check the options to set "text entry" to "cursor" so you don't need to pull up the keyboard to enter names.

To use the Save Backup tool
1) As soon as you have created save data, close the game.
2) Open the folder you extracted the scripts into
3) Right-click on "RunThisImmediatelyAfterFirstSave.sh" and select "Run in Konsole"
4) This should create gameid.txt in this directory
5) Now that gameid.txt exists, anytime you want to backup your saves, Right-click on "SaveBackup.sh" and select "Run in Konsole"

To use the updater
1) Right-click on "InfiniteFusionUpdater.sh" and select "Run in Konsole"
2) If you installed via the script, the "path.txt" folder should exist telling it where to update, and it will automatically run in that directory
3) If it cannot find "path.txt", it will pull up a window for you to select the install folder for it to update
