v1.2.1 File System Rework | github tag: v1.2.1-SourceCode-FileSysRework
A Rework has been done on the File System of this project, no longer are the resources all over the place like a child's play area after they had their fun.
Folders have been made to seperate all the project resources into neatly organized packets.
Folders:
music: A Folder for music lasting for atleast 1 minute
|-content: tf_music_upgrade_machine.wav

script: A folder for GDScript files
|-content: cam.gd, global.gd, grenadescript.gd, player.gd.

sfx: A folder for sound effects that last around 10 secs or under
|-content: explosion.wav, grenade_launcher_shoot.wav

textures: A folder for textures, contains several sub-folders
sub-folders:
├camera: contains textures that are directly displayed on the camera.
│  └content: controlmenu_f1forcontrol.png, controlmenu_menu.png
│
├dev: textures meant for development and testing purposes.
│  └content: devgrid.svg
│
├tf: textures related to TF2, Valve please don't sue me.
│ └content: texture_tf_demoman_blu.svg, texture_tf_projectile_grenadepill.svg
│
├vfx: textures used for visual effects.
   └content: texture_gn_vfx_explosion.svg

More folders and sub-folders to be added soon

v1.2 Initial Release | github tag: v1.2-SourceCode-init
Added new feature: Projectile Launching
The player is now able to launch grenades that go boom after 1 second after launching them, this is currently only projectile-based
and not hitscan-based, also since there are no enemies to even kill, there is no use for these projectiles.

New files
texture_tf_projectile_grenadepill.svg: this is a sprite meant to demonstrate projectile firing.
texture_gn_vfx_explosion.svg: since there are grenades, there should be explosions too.

grenade_launcher_shoot.wav: ripped straight off of the TF2 sound files, meant to demonstrate playing sound.
https://user-images.githubusercontent.com/83492216/168414813-b937372d-823d-456c-874e-e9290f198670.mp4

explosion.wav : also ripped straight off of TF2, currently unused since I cant figure out how to not make the sound loop the first 4 seconds over and over.
https://user-images.githubusercontent.com/83492216/168414886-fe6c1cb5-0f97-4a88-82ee-495a7eed52b9.mp4

grenade.tscn: the scene instance that contains all parts to make a grenade, from sprites to detonation time.
grenadescript.gd: a script for moving a grenade and timing all of the procedures, will make the grenade emit the signal detonate() when the fuse time runs out.

Version 1.1.1 Renaming | github tag:v1.1.1-SourceCode-renaming
Cam.gd --> cam.gd
Player.gd --> player.gd
So yeah just made some stuff lowercase instead

Version 1.1 Initial Release | github tag: 1.1-SourceCode
Added new feature: Control Menu
Pressing F1 will now show a bunch of controls for the character

New Files
Cam.gd: This script contains the code for the new feature, but not really for anything else at the moment.
controlmenu_f1forcontrol.png: Will be hidden when F1 is pressed
controlmenu_menu.png:Will be shown when F1 is pressed

v1.0 The Initial Version (FULL) | github tag:v1.0-SourceCode-Full
The previous release but I removed some unused nodes from the Scene.tscn file

v1.0 The Initial Version | github tag:v1.0-SourceCode
This is the initial version of the sample game, the floor that holds the foundation above it if you will.

Intialized Files
Scene.tscn: The scene that contains the initial sample game
texture_tf_demoman_blu.svg: Yes im a TF2 fan, this model is to demonstrate the basic movement and looking around features
devgrid.svg: a bunch of grey and orange squares arranged in a checker pattern, this is to demonstrate moving around
global.gd: a script file that governs the whole scene
Player.gd: a script file that gives the player movement and looking around