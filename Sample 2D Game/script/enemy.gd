# In order for the enemy entity to work, you must connect the signal "file_weapon_reload" to global.gd
# in the method "_on_weapon_reload_file"

extends "res://script/entity.gd"

onready var action = $Action
var action_attack1 = false

# Called when the node enters the scene tree for the first time.
func _ready():
	health_max = 200
	health = 200
	team = 2
	action.connect("timeout",self,"_action")
	file_load([1,1,1])
	action.start(1)

func death():
	action.stop()
	self.set_position(Vector2(0,0))

func _action():
	if weapon_current_clip == -1:
		reload()
	elif weapon_current_clip <= 3:
		attack1()

func _process(_delta):
	if health <= 0:
		death()
