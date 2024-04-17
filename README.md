# SteamDeck_InfiniteFusion_Installer 

Not officially affiliated or approved by the Pokemon Infinite Fusion team, though the files should be genuine. I got the github link I use in the installer FROM the official lightweight installer/updater.bat script. If you are looking for the offical resources look for the Discord or check r/PokemonInfiniteFusion

Summary:
A learning project to try and programmatically add entries to Steam for applications. In short, if you want to install a game or application that utilizes an installer on a Linux system via Proton you'd need to add the installer manually, set the Proton version manually, run the installer, find the compatdata folder, and then update the existing shortcut to use the new path and exe. If the game or application ALSO has a seperate exe to run updates you need to update the shortcut to point to the updater, run it, and then change it back, which is cumbersome.

EDIT: Due to the nature of how Pokemon Infinite Fusion is deployed, all of the compatdata pieces unnecessary.

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

As of v1.0, this is the install process.
1) Download v1.0
2) Extract InfiniteFusion.sh and SteamShortcutMaker.py (they must be in the same folder as each other)
3) Right-click on InfiniteFusion.sh and select "Run in Konsole"
4) Once the window says "If no errors occured, the shortcut has been added to Steam. Steam may need to be restarted to take effect" the script has finished.
5) If the script was successful, close Steam entirely (right-click on it in the taskbar and hit close)
6) Re-open Steam
7) Pokemon Infinite Fusion should now be in your game list
8) Right-click on Pokemon Infinite Fusion and select "Properties"
9) Go to the Compatibility tab and force the use of a specific tool
10) Set it to Proton GE or Experimental
11) Run the game! If you've not played it before be sure to check the options to set "text entry" to "cursor" so you don't need to pull up the keyboard to enter names.

To update the game, right-click on InfiniteFusionUpdater.sh and select "Run In Konsole". This file can be anywhere and assumes your game path is /{logged in user}/home/Games/PokemonInfiniteFusion (the install path for the install script).
