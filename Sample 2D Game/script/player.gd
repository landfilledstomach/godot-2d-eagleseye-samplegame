extends KinematicBody2D

onready var speed = 100
onready var velocity = Vector2()
func _ready():
	pass # Replace with function body.

# This function gets input from the WASD keys and makes the player look at wherever the mouse is.
func input_WASD():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func changespeed():
	if Input.is_action_just_pressed("speed+"):
		speed += 25
	elif Input.is_action_just_pressed("speed-"):
		speed -= 25
		
func _process(_delta):
	input_WASD()
	changespeed()
	velocity = move_and_slide(velocity)
