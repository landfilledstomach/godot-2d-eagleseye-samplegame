extends Node2D

####################### START Grenade Variables

var grenade_grenademagazine = 3 # Because of how array indexing works, 3 represents the 4th element
onready var grenade_gren1 = $Grenade1
onready var grenade_gren2 = $Grenade2
onready var grenade_gren3 = $Grenade3
onready var grenade_gren4 = $Grenade4
onready var grenade_grenadecycle = [grenade_gren1,grenade_gren2,grenade_gren3,grenade_gren4]
var grenade_currentgrenade = null

####################### END Grenade Variables

####################### START Other Variables

#None as of now

####################### END Other Variables

####################### START Player Variables


# The player itself
onready var player = $Player
onready var player_camera= $MainCamera

# 1 = Primary weapon
# 2 = Secondary Weapon
var player_weapon = 1 
var player_weapon_primary = 1 # See the `shootprimary()` function to see the ID's for primary weapons
var player_weapon_secondary = 1 # See the `shootsecondary()` function to see the ID's for secondary weapons



####################### END Player Variables

func _ready():
	
	pass # Replace with function body.

####################### START Grenade Functions

# Shoots a grenade
func grenade_shoot():
	if grenade_grenademagazine == -1: #this will be changed to suit reloading
		grenade_grenademagazine = 3
	else:
		grenade_currentgrenade = grenade_grenadecycle[grenade_grenademagazine]
		grenade_currentgrenade.set_position(player.get_position())
		grenade_currentgrenade.shoot()
		grenade_currentgrenade.fusetimer.start(1)
		grenade_grenademagazine -= 1

# Activates when the fuse time on a grenade is over, extends from the `grenade_fusecheck()` function
func grenade_explode(grenade_obj):
	var explode_position = grenade_obj.get_position()
	
# Each grenade object gets its own node, if they explode they will send an `explode()` signal
func _on_Grenade1_explode():
	grenade_explode(grenade_gren1)
	pass # Replace with function body.

func _on_Grenade4_explode():
	grenade_explode(grenade_gren2)
	pass # Replace with function body.

func _on_Grenade3_explode():
	grenade_explode(grenade_gren3)
	pass # Replace with function body.

func _on_Grenade2_explode():
	grenade_explode(grenade_gren4)
	pass # Replace with function body.
####################### END Grenade Functions

####################### START Player Functions

# Depending on the value of `player_weapon` it will shoot a weapon accordingly
func player_shoot():
	if player_weapon == 1:
		player_shootprimary()
	elif player_weapon == 2:
		player_shootsecondary()

#Primary Weapon ID's
# 1 = Grenade Launcher
#More to be added
func player_shootprimary(): 
	if player_weapon_primary == 1: # Grenade Launcher ID
		grenade_shoot()

#Secondary Weapon ID's
# None as of now
func player_shootsecondary(): # You can ignore this function, as a secondary weapon feature does not exist yet in this version
	print("No secondary items")

####################### END Player Functions

####################### START Global Process Functions

func global_input(): # The primary input function
	if Input.is_action_just_pressed("mouse1"):
		print("Mouse 1 was pressed")
		player_shootprimary()

####################### END Global Process Functions
func _process(_delta):
	player_camera.set_position(player.get_position())
	global_input()
