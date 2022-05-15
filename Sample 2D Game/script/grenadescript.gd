extends KinematicBody2D

signal detonate(currentpos)
#`velocity` and `speed` for the grenade to move
var velocity = Vector2()
var speed = 600

#The position of the player, emitted by the `Main` node every frame
var current_playerpos = Vector2()

# Will get the Timer node in this grenade node for creating a fuse timer
onready var fusetimer = get_node("fusetime")

# 2 sprite nodes, one is a grenade sprite and the other is an explosion sprite
onready var sprite_grenadepill = get_node("GrenadeCollision/GrenadePill")
onready var sprite_explosion = get_node("GrenadeCollision/Explosion") # No explosion sprite as for now,

# grenade sounds
onready var sounds_grenadeshoot = get_node("grenadeshoot")
onready var sounds_explode = get_node("explode")

# If `active = true`, this grenade node will be able to interact with the enviroment
var active = false

# Will have no real effect on the world
onready var grencollsion =  get_node("GrenadeCollision")

func _ready():
	self.visible = false
	grencollsion.disabled = true
	fusetimer.connect("timeout", self, "explode")

func shoot(): # shoots a grenade
	sounds_grenadeshoot.play()
	sprite_explosion.visible = false
	sprite_grenadepill.visible = true
	self.visible = true # makes grenade node visible
	active = true # makes the grenade node active
	look_at(get_global_mouse_position()) # makes the grenade look at wherever the mouse is
	velocity = Vector2(speed, 0).rotated(rotation) # makes the grenade shoot towards the mouse position
	print("A Grenade has been shot")

func explode(): # when detonation time is out, this function is called
	active = false
	emit_signal("detonate", self.get_position())
	sprite_grenadepill.visible = false
	sprite_explosion.visible = true 
	yield(get_tree().create_timer(0.1),"timeout")
	self.visible = false

func _process(_delta):
	if active == true:
		velocity = move_and_slide(velocity)
