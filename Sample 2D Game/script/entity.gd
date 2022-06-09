# entity.gd is a class that provides the barebones standards of an entity that can move and attack
# how to use:
# extend "res://script/entity.gd"
# #change variables by manipulating them in the _ready() function
# _ready():
#       speed = 500
#       health_max = 450
#       health = health_max
# # moving this entity
extends KinematicBody2D

signal weapon_attack1_primary(entity_rotation, entity_position)

# Sends a signal to this entity's primary weapon to reload
signal weapon_reload_primary()

# Reloads weapon metadata for this entity
signal file_weapon_reload(selfreference,weapon,team)

var team = 1 # The team that this entity is on, 1 for player team and 2 for enemy team
var movement_dir = [false,false,false,false] # Each index from 0-3 corresponds to [right, left, down, up]
var speed = 350 # The speed limit for how much this entity can accelerate before normalizing, `speed/10` is how much this entity will accelerate each time `movement()` gets called
var velocity = Vector2() # Velocity moves this entity when it has values in its x and y values.

var weapon_current = 1 # The current weapon this entity is holding, corresponds to weapons in `weapon_metadata`
var weapon_current_clip = 0 # The clip size of the current weapon.
var weapon_current_ammo = 0 # Planned to be added.
var weapon_metadata = {
	"1":{}, # Primary Weapon
	"2":{}, # Secondary Weapon
	"3":{}  # Melee Weapon
}

var health_max = 100 # The maximum health of this entity, this value is not meant to be changed in ANY circuimstance other than initializing an entity deriving from entity.gd
var health = health_max # Current health of this entity, meant to be changed in any time this entity receives damage

func _ready():
    pass

# Manipulate the values in the `movement_dir` list
# movement_dir[0] = right
# movement_dir[1] = left
# movement_dir[2] = down
# movement_dir[3] = up
func movement(): 
	if movement_dir[0] == true:
		velocity.x += speed/10
	if movement_dir[1] == true:
		velocity.x -= speed/10
	if movement_dir[2] == true:
		velocity.y += speed/10
	if movement_dir[3] == true:
		velocity.y -= speed/10

	if velocity.x > speed: # Caps moving up through the X according to the speed variable
		velocity.x = speed
	if velocity.x < speed - speed * 2: # Caps moving down through the X according to the speed variable
		velocity.x = speed - speed * 2
	if velocity.y > speed: # Caps moving up through the Y according to the speed variable
		velocity.y = speed
	if velocity.y < speed - speed * 2: # Caps moving down through the Y according to the speed variable
		velocity.y = speed - speed * 2
	
	# If the entity is not moving in a certain direction, their velocity will be reduced in that direction.
	if velocity.x > 0 and movement_dir[0] == false:
		velocity.x -= speed/10
	if velocity.x < 0 and movement_dir[1] == false:
		velocity.x += speed/10
	if velocity.y > 0 and movement_dir[2] == false:
		velocity.y -= speed/10
	if velocity.y < 0 and movement_dir[3] == false:
		velocity.y += speed/10

	if velocity.x > 0 and velocity.x < speed/10:
		velocity.x = 0
	if velocity.x < 0 and velocity.x > speed/10 - (speed/10 * 2):
		velocity.x = 0
	if velocity.y > 0 and velocity.y < speed/10:
		velocity.y = 0
	if velocity.y < 0 and velocity.y > speed/10 - (speed/10 * 2):
		velocity.y = 0
	velocity = move_and_slide(velocity)

func file_load(data):
	if data[0] == 1: #Loads weapon metadata
		file_load_weapon(data)
func file_load_weapon(data):
	if data[1] == 1: #Loads primary weapon
		file_load_weapon_primary(data[2])
func file_load_weapon_primary(id):
	var string_id = str(id) # Stringifies the ID
	var file = File.new()
	file.open("res://json/weapon_metadata.json", file.READ) # Opens the json file with the weapon metadata.
	var textjson = JSON.parse(file.get_as_text()) # Parses the JSON file content
	var primarycatalog = textjson.result["primary"] # Gets the key that contains all primary weapon metadata keys
	var weapon = primarycatalog[string_id] # Inside of the primary weapon catalog, gets the key that matches the id
	weapon_metadata["1"] = weapon # Loads the primary weapon metadata into weapon_metadata for loading the weapon
	# These next lines are simply for initializing clip size
	var temp1 = weapon_metadata["1"]
	var temp2 = temp1["clip_size"]
	weapon_current_clip = temp2
	
	file_reload_weapon(string_id)
func file_reload_weapon(type):
	var temp = weapon_metadata[type]
	emit_signal("file_weapon_reload",self,temp,team)

func attack1():
	if weapon_current == 1:
		emit_signal("weapon_attack1_primary",self.rotation_degrees,self.get_position())

func reload():
	if weapon_current == 1:
		emit_signal("weapon_reload_primary")
														

func hurt(damage:int):
	health -= damage

func _on_weapon_clip_size(clipsize):
	weapon_current_clip = clipsize

			

