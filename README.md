# Non-Steam-Shortcut-Adder
Summary:
A learning project to try and programmatically add entries to Steam for applications. In short, if you want to install a game or application that utilizes an installer on a Linux system via Proton you'd need to add the installer manually, set the Proton version manually, run the installer, find the compatdata folder, and then update the existing shortcut to use the new path and exe. If the game or application ALSO has a seperate exe to run updates you need to update the shortcut to point to the updater, run it, and then change it back, which is cumbersome.

Statement of Problem:
Adding non-Steam games with installers is more complicated than non-technical Steam Deck users would want to engage in.

Limitations of Methodology:
Because my end goal is specifcally to have a game or application's shortcut to be directly added to Steam, I need to know exactly what and where that final .exe is. This means it would need to be implemented per game/application.

Method:
As this is a learning project, I'm not coming in with the knowledge of how to do this. To be able to effectively start chipping away at this, I will utliize the open-source information from https://github.com/moraroy/NonSteamLaunchers-On-Steam-Deck as a reference, as it largely does what I want to do but specifically for a handful of launchers.

Goals (in priority order):
1. Add a non-Steam game as a shortcut programatically
2. Have the above shortcut be linked to the compatdata folder, finding the right appID itself
3. Set the Proton version automatically (probably to Experimental)
4. Make the folder name for the installed applciation unique instead of a randomly generated AppID (would simplify any user done maintenance, and I may not even need to pull the AppID out of the process) 
5. If appropriate, make the script download the application itself
6. Make the script able to complete the installation process of the application itself

First Target:
As I need to pick a specific application to start with that I'm familiar with, I pick Pokemon Infinite Fusion (https://github.com/infinitefusion/infinitefusion-e18). The reasoning being that it easily offers a place for the script to expand, as it is a game that requires a seperate process be run to update it. The update script itself is quite simple, so if I'm able to point to the folder directly by scraping the compatdata folder I can eliminate the need to swapping around the paths the shortcut needs to use, as it's just a set of git commands so Proton isn't needed, and the additional steps set in the script to use mintgit aren't needed as this script will be SteamOS focused so git will be present. It also offers plenty of other spaces to expand if desired, such as a save data back-up tool. 

Bonus points if I can make the script then launch the game via Steam so you'd be able to strictly use the update script always.
  Update- I'd need this to be a second script OR be smarter and make it check for an existing entry in the VDF
