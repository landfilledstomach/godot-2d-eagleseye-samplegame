extends Node2D

onready var player = $Player
onready var main_camera = $MainCamera
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(_delta):
	main_camera.set_position(player.get_position())
	

	
