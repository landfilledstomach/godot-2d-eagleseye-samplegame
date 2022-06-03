extends Node2D

# `arraydata` is supposed to have data relating to what you may be trying to use with files for the player
signal file_player(arraydata)
####################### START Other Variables

onready var camera= $Camera

####################### END Other Variables

####################### START Player Variables

# The player itself
onready var player = $Player

####################### END Player Variables

func _ready():
	file_load(1,[1,1,1])

####################### START File Functions

# `data` is supposed to be an `array` with data relating to whatever its supposed to reference.
func file_load(type:int, data):
	if type == 1: # Loads data relating to the player
		emit_signal("file_player",data)

####################### END File Functions

####################### START Other Functions



####################### END Other Functions

####################### START Global Process Functions

func global_input(): 
	if Input.is_action_just_pressed("test"):
		file_load(1,[1,1,1])
####################### END Global Process Functions
func _process(_delta):
	camera.set_position(player.get_position())
	global_input()

func on_player_weapon_reload_file(selfreference,primary,_secondary,_melee):
	print("global.gd: Reloading weapon instances for " + str(selfreference))
	var instancenode = load(primary).instance()
	var temp = $Weapon
	temp.remove_child(instancenode)
	temp.add_child(instancenode)
	selfreference.connect("player_weapon_attack1_primary",instancenode,"on_attack1")
	
