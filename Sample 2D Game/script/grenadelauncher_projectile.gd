extends KinematicBody2D

var fusetimer = Timer.new()
var speed = 600
var velocity = Vector2()
onready var hitbox = $hitbox
onready var pill_sprite = $Pill
onready var explosion_sprite = $Explosion

func movement(): # Moves according to this projectiles rotation
	velocity = Vector2()
	velocity = Vector2(speed, 0).rotated(self.rotation)

func _ready():
	pill_sprite.visible = false
	explosion_sprite.visible = false
	self.disabled = true
	fusetimer.connect("timeout",self,"on_fusetimer") # When grenade runs out of fuse, this will call `on_fusetimer`

func shoot(entity_rotation, entity_position):
	self.set_position(entity_position) # Sets the position of this projectile to the position of the entity shooting it, see `grenadelauncher.gd`
	self.rotation_degrees = entity_rotation # sets the rotation of this projectile to the rotation of the entity shooting it
	self.disabled = false # Makes this projectile active, allowing movement and collision
	pill_sprite.visible = true # Make
	fusetimer.start(1.2)  # See `on_fusetimer` for what happens when this time runs out

func _process(_delta):
	if self.disabled == false:
		movement()
		velocity = move_and_slide(velocity)

func on_fusetimer():
	pill_sprite.visible = false
	explosion_sprite.visible =true
	# The explosion is only visual for now
	yield(get_tree().create_timer(0.1),"timeout")
	explosion_sprite.visible = false

	