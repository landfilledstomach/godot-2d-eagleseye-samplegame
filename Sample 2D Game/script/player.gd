extends KinematicBody2D

# `weapon`: Should have the value of `player_weapon`
signal player_weapon_attack1_primary(entity_rotation, entity_position)

# Reloads weapon metadata for the player
signal player_weapon_reload_file(selfreference,weapon)

var movement = [false,false,false,false] # Each index from 0-3 corresponds to [right, left, down, up]
var speed = 350
onready var velocity = Vector2()
func _ready():
	print("player.gd: Player is ready for action")
# Player weapons
var player_weapon = 1 #If set to `1` player is holding primary, if set to `2` player is holding secondary, if set to `3` player is holding melee
var player_weapon_metadata = {# Contains data about players weapons, seperated by `primary`, `secondary`, and `melee`, or `1`, `2` and `3` in this dictionary.
	"1": {}, # Primary Weapon
	"2": {}, # Secondary Weapon
	"3": {}, # Melee Weapon
}
# This function gets input from the WASD keys and makes the player look at wherever the mouse is.
func moving():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("right"):
		velocity.x += speed/10
	if Input.is_action_pressed("left"):
		velocity.x -= speed/10
	if Input.is_action_pressed("down"):
		velocity.y += speed/10
	if Input.is_action_pressed("up"):
		velocity.y -= speed/10
	if velocity.x > speed: # Caps moving up through the X according to the speed variable
		velocity.x = speed
	if velocity.x < speed - speed * 2: # Caps moving down through the X according to the speed variable
		velocity.x = speed - speed * 2
	if velocity.y > speed: # Caps moving down through the Y according to the speed variable
		velocity.y = speed
	if velocity.y < speed - speed * 2: # Caps moving down through the Y according to the speed variable
		velocity.y = speed - speed * 2
	
	# checks for player movement
	if Input.is_action_just_pressed("right"):
		movement[0] = true
	elif Input.is_action_just_released("right"):
		movement[0] = false
	if Input.is_action_just_pressed("left"):
		movement[1] = true
	elif Input.is_action_just_released("left"):
		movement[1] = false
	if Input.is_action_just_pressed("down"):
		movement[2] = true
	elif Input.is_action_just_released("down"):
		movement[2] = false
	if Input.is_action_just_pressed("up"):
		movement[3] = true
	elif Input.is_action_just_released("up"):
		movement[3] = false

	# If the player is not moving in a certain direction, their velocity will be reduced in that direction.
	if velocity.x > 0 and movement[0] == false:
		velocity.x -= speed/10
	if velocity.x < 0 and movement[1] == false:
		velocity.x += speed/10
	if velocity.y > 0 and movement[2] == false:
		velocity.y -= speed/10
	if velocity.y < 0 and movement[3] == false:
		velocity.y += speed/10
func changespeed():
	if Input.is_action_just_pressed("speed+"):
		speed += 25
		print("player.gd: Player speed increased to: " + str(speed))
	elif Input.is_action_just_pressed("speed-"):
		speed -= 25
		print("player.gd: Player speed decreased to: " + str(speed))

# Index `0` in `data` should about the data type to load for the player.
func file_load_player(data):
	if data[0] == 1: # Loads weapon metadata, see more on the function `file_load_player_weapon()`
		file_load_player_weapon(data)

# Loads weapons from `weapon_metadata.json` for the player.
# Index `1` in `data` is the id for the type of weapon, `1` = primary, `2` = secondary, and `3` = melee.
# Index `2` in `data` is the id for the weapon inside the category of `1`.
func file_load_player_weapon(data):
	if data[1] == 1: # Loads a primary weapon
		file_load_player_weapon_primary(data[2])
	elif data[1] == 2:
		print("player.gd: Secondary weapons are planned, but do not exist for now.")
	elif data[1] == 3:
		print("player.gd: Melees are planned, but do not exist for now.")

# Used in the `file_load_player_weapon()` function to load primary weapon metadata for the player.
# `id` is used to get a weapon, `id` will be stringified to get the key that has the weapon properties.
func file_load_player_weapon_primary(id:int):
	var string_id = str(id) # Stringifies the ID
	var file = File.new()
	file.open("res://json/weapon_metadata.json", file.READ) # Opens the json file with the weapon metadata.
	var textjson = JSON.parse(file.get_as_text())
	var primarycatalog = textjson.result["primary"]
	var weapon = primarycatalog[string_id]
	player_weapon_metadata["1"] = weapon
	print("player.gd: Weapon: Primary weapon is now:" )
	print(player_weapon_metadata["1"])

func file_reload_player_weapon():
	var temp1 = player_weapon_metadata["1"]
	var temp2 = temp1["instance"]

	emit_signal("player_weapon_reload_file",self,temp2)

# If mouse1 or mouse2 is pressed, this will detect it
func attack_input():
	if Input.is_action_pressed("mouse1"):
		attack1()

func attack1():
	if player_weapon == 1:
		emit_signal("player_weapon_attack1_primary", self.rotation_degrees, self.get_position)

func _process(_delta):
	attack_input()
	moving()
	changespeed()
	velocity = move_and_slide(velocity)
	
