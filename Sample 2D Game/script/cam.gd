extends Camera2D


onready var f1forcontrol = $PressF1
onready var controlmenu = $ControlMenu

func _ready():
	controlmenu.visible = false
	pass

func get_input():
	if Input.is_action_just_pressed("controlmenu"):
		f1forcontrol.visible = false
		controlmenu.visible = true
	elif Input.is_action_just_released("controlmenu"):
		f1forcontrol.visible = true
		controlmenu.visible = false
		
func _process(_delta):
	get_input()

	