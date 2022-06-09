# In order for this entity to work, you must connect the signal "file_weapon_reload" to global.gd
# in the method "_on_weapon_reload_file"

extends "res://script/entity.gd"

signal player_hud_crosshair_clipsize(clipsize)

# HUD instance
onready var player_hud = get_node("../Camera")

func _ready():
	health_max = 300
	health = health_max
	team = 1
	speed = 500
	print("player.gd: Player is ready for action")
	self.connect("player_hud_crosshair_clipsize",player_hud,"_on_crosshair_clipsize")
	file_load([1,1,1])

# Detects player input
func input():
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("mouse1"):
		attack1()
	if Input.is_action_just_pressed("reload"):
		reload()

	# Sets the value in movement_dir[0]
	if Input.is_action_just_pressed("right"): 
		movement_dir[0] = true
	elif Input.is_action_just_released("right"):
		movement_dir[0] = false

	# Sets the value in movement_dir[1]
	if Input.is_action_just_pressed("left"):
		movement_dir[1] = true
	elif Input.is_action_just_released("left"):
		movement_dir[1] = false

	# Sets the value in movement_dir[2]
	if Input.is_action_just_pressed("down"):
		movement_dir[2] = true
	elif Input.is_action_just_released("down"):
		movement_dir[2] = false

	# Sets the value in movement_dir[3]
	if Input.is_action_just_pressed("up"):
		movement_dir[3] = true
	elif Input.is_action_just_released("up"):
		movement_dir[3] = false

func _process(_delta):
	if health > 0:
		input()
		movement()
		emit_signal("player_hud_crosshair_clipsize",weapon_current_clip)
	else:
		self.set_position(Vector2(0,0))
	
