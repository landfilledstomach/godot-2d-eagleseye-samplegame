extends Camera2D


onready var f1forcontrol = $HUD/PressF1
onready var controlmenu = $HUD/ControlMenu
onready var hud_crosshair = $HUD/Crosshair
onready var hud_crosshair_clipsize = $HUD/Crosshair/Control/Clipsize
func _ready():
	self.visible = true
	controlmenu.visible = false

func updatecrosshair():
	hud_crosshair.set_position(get_global_mouse_position() - self.get_position())

func _on_crosshair_clipsize(clipsize):
	hud_crosshair_clipsize.set_text(str(clipsize + 1))

func get_input():
	if Input.is_action_just_pressed("controlmenu"):
		f1forcontrol.visible = false
		controlmenu.visible = true

	elif Input.is_action_just_released("controlmenu"):
		f1forcontrol.visible = true
		controlmenu.visible = false
		
func _process(_delta):
	get_input()
	updatecrosshair()
	