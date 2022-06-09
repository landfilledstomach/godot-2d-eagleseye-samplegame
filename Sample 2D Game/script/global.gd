extends Node2D

onready var camera= $Camera
onready var player = $Player
func _ready():
	print("Sample 2D Game")

func _process(_delta):
	camera.set_position(player.get_position())

			

func _on_weapon_reload_file(selfreference, weapon, team):
	var instancenode = load(weapon["instance"]).instance() # loads the instance found in the weapons metadata
	var temp = $Weapon # Node2D node used for storing all weapons
	temp.add_child(instancenode) # Instance stored in the Weapon node
	if weapon["type"] == 1: # Type is found in the weapons metadata, used to identify if it should be a primary, secondary or melee weapon
		selfreference.connect("weapon_attack1_primary",instancenode,"_on_attack1") 
		selfreference.connect("weapon_reload_primary",instancenode,"_on_reload")
		instancenode.connect("weapon_clip_size",selfreference,"_on_weapon_clip_size")
		instancenode.set_team(team)

