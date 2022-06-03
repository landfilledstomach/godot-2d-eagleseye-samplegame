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
    
    
