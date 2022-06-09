v1.3 Initial Release
This version now has enemies for you to kill, but they are simply dummies meant to demonstrate
such a thing unfortunately, will be adding AI to them soon.
Comments and stuff made by developer while developing this version:
    OK so hello Im the developer, landfilledstomach, but you can call me Amir, this is the first
    time I have ever made this kind of changelog, Im going to be making notes and comments and things as im developing this update.
    My first task is to create an enemy entity that has 200 hp, and connect that entity to a global.gd signal.

    12:18 PM 15/5/2022
    OK so I decided to rename the CollisionShape2D node inside of the Player node to PlayerCollision, not much reason behind it tbh.
    I also created "enemy.tscn" for the purposes of instancing it into the main scene.
    I also also updated the "controlmenu_menu.svg" file to include 2 new lines of text "Mouse1: Shoot" and "F2: Spawn Enemy"
    
    12:30 PM 15/5/2022
    I modified the BLU Demoman Sprite to create a RED Demoman sprite, basically thats what the enemy is going to be.
    Its located within the textures/tf folder, same as the BLU Demoman.

    12:33 PM 15/5/2022
    I changed the players speed to 500 and changed the grenade speed to 1000, you can still change your speed using Q and E.
    Also Im going to put a plan on how the enemy is going to detect damage here, dont mind me.
    So first we want the grenade explosion radius to have a hitbox, im planning on have 2 different hitboxes for
    one single explosion, one is the inner explosion and the other is the outer explosion, the inner explosion deals more damage than the outer explosion and takes priority over the outer explosion in damaging whatever entity they are supposed to damage, the position of the explosion hitboxes are then transmitted to global.gd in a signal, (I have decided  to stop typing my plans, sorry)

    1:54 PM 15/5/2022
    I created some Area2D nodes for the creation innerexplosion and outerexplosion hitboxes.
    
    9:27 PM 17/5/2022
    I am going to try and see if the innerexplosion and outerexplosion nodes can detect an enemy going into the hitbox
    Okay actually I just remembered that I was implementing a reload feature so brb

    7:44 PM 28/5/2022
    I took 2 weeks of this project wtf is this spaghetti code and nodes.
    Ok so I had a brainwave, what if I had a layer that was specifically for things that can damage the player and enemies,
    that will make it much simpler.

    7:55 PM 28/5/2022
    The first 2 physics layers are "player_damage" for things that can damage the player and "player_projectiles" for things fired by the player, same goes with the 3rd and 4th layers "enemies_damage" and "enemies_projectiles".

    8:30 PM 28/5/2022
    I just took a further look at the code here, what the hell.

    10:03 PM 28/5/2022
    renamed "Scene.tscn" to "main.tscn" for no particular reason.
    also I am implementing a way to easily integrate new weapons.

    12:22 PM 29/5/2022
    I realised that I did not specify what thing im implementing, basically I created a JSON file called "weapon_metadata.json"
    it contains details about certain weapons like the firerate, what scene should be instanced to use the weapon, and magazine size.
    
    8:14 PM 31/5/2022
    I have deleted most of the scenes, scripts and functions relating to the enemy and weapons because I plan to start from scratch for them, the player, camera and devgrid remain unchanged.

    10:06 PM 2/6/2022
    I have made some changes to how the player moves, now the player over time gets faster until they reach a speed limit defined by the player's speed variable, and when they are not moving in a specific direction, the player will stop moving in that direction over time until their velocity in that direction is 0.
    Its pretty complicated to explain in words, so just take a look at the code instead. (player.gd: Line 9, Line 22-62, Line 106-114 )

    10:03 AM 3/6/2022
    A while ago I actually removed the whole thing in weapon_metadata.json with firerate and reloading after realizing that I can just send a signal to a instanced scene that defines a weapon to shoot and reload and stuff like that.
    
    11:43 AM 3/6/2022
    stuff like reloading, firerate and damage are going be dealt within the weapon instances themselves, the signals to shoot and reload and damage are given by the player and enemies.
    also "cam.gd" is unused for now.
    
    2:39 PM 3/6/2022
    I just want anyone reading this to know that it does not really take 2 days long to complete some of these tasks, its just that i do this project out of mood and motivation, so if I am not interested in doing this, I wont.

    8:19 4/6/2022
    Ok so embarrasing story, I was trying to fix this bug where the grenade_launcher Node would not interact with its projectile_grenade Child nodes, and I figured it out, its because I did not put onready beforehand, which meant that when the child nodes were not ready, the engine tried to find them anyway, and because they were not ready the engine returned a null instance for each child node not found.
    But hey atleast I noticed.

    9:04 AM 4/6/2022
    I have successfully created a way for the player and possibly other entities to shoot projectiles. I am now going to implement reloading.

    9:34 AM 4/6/2022
    I have successfully created a way for the player and possibly other entities to reload now.
    I basically have the bare minimum combat standards, now I just need a way for the player to damage enemies and vice versa.

    11:06 AM 4/6/2022
    I am currently making a way for weapon scripts to easily branch off of grenadelauncher.gd, Im planning on making 
    grenadelauncher.gd to be the absolute parent of all weapon scripts.
    I say the same with grenadelauncher_projectile.gd

    5:10 PM 5/6/2022
    After an hour of pain trying to figure out why the weapons kept firing when they werent supposed to, I have the way for the player and enemies to be combative, now I just need them to actually deal damage to eachother, but first, the players hud.

    11:06 AM 6/6/2022
    I added a crosshair for the player, cam.gd is being used now and the clip size of the weapon the player is using will update the text on top of the crosshair to tell you the clip size of the weapon.
    I also readded F1 For Controls and the Control Menu textures that I removed earlier.
    I also also added a font resource for textual stuff (https://www.1001freefonts.com/collegiate.font).

    9:56 AM 7/6/2022
    I added an assault rifle sound effect earlier but I dont exactly have a plan on actually implementing a new weapon right now, so perhaps later.
    Anyways I cant really figure out how to dynamically create a new enemy entity so Im just gonna ignore that and move on.
    What I AM adding is the ability to damage things so yeah.

    12:24 PM 8/6/2022
    I am attempting to create an "entity.gd" script that will be extended from for player.gd and enemy.gd because features will be much easier to implement if I just need to modify 1 script to modify all others connected to it.

    2:41 PM 8/6/2022
    I decided to add a "clip_size" key to the Grenade Launcher weapon in weapon_metadata.json, this will only be used for when loading the weapon in.

    4:49 PM 8/6/2022
    entity.gd is so god damn buggy I could not make the enemies shoot thier weapons in any way no matter what I did they just did not attack in any way i am seriously going insane right wtf I just want you to attack thats it whyyyyy.
    I just decided to make enemy.gd its own script.

    9:50 PM 8/6/2022
    I think enemy.gd is not working properly because I did not connect the damn enemy entities file_weapon_reload signals to global.gd, lets hope this works.

    9:58 PM 8/6/2022
    I took a little more than just connecting a signal, but just a few tweaks and now this works, how nice.

    
