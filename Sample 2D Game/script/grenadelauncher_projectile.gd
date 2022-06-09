extends KinematicBody2D

signal damagedealt(total)

var speed = 1200
var velocity = Vector2()

onready var fusetimer = $Fusetimer
onready var pill_sprite = $Pill
onready var pill_sound = $Pill/GrenadeLaunchSound
onready var pill_hitbox = $Pill/hitboxpill
const pill_damage = 100

onready var explosion_sprite = $Explosion
onready var explosion_sound = $Explosion/ExplosionSound
onready var explosion_hitbox = [$Explosion/hitboxexplosion_root,$Explosion/hitboxexplosion_root/child1,$Explosion/hitboxexplosion_root/child1/child2,$Explosion/hitboxexplosion_root/child1/child2/child3,$Explosion/hitboxexplosion_root/child1/child2/child3/child4,$Explosion/hitboxexplosion_root/child1/child2/child3/child4/child5]
const explosion_damage_perlayer = 10
var active = true
func movement(): # Moves according to this projectiles rotation
	velocity = Vector2()
	velocity = Vector2(speed, 0).rotated(self.rotation)

func _ready():
	pill_sprite.visible = false
	explosion_sprite.visible = false
	active = false
	fusetimer.connect("timeout",self,"_on_fusetimer") # When grenade runs out of fuse, this will call `on_fusetimer`
	pill_hitbox.connect("area_entered",self,"_on_pill_hitbox_detect")
	explosion_hitbox[0].connect("area_entered",self,"_on_explosion_hitbox_detect")

func shoot(entity_rotation, entity_position):
	pill_sound.play()
	self.set_position(entity_position) # Sets the position of this projectile to the position of the entity shooting it, see `grenadelauncher.gd`
	self.rotation_degrees = entity_rotation # sets the rotation of this projectile to the rotation of the entity shooting it
	active = true # Makes this projectile active, allowing movement and collision
	pill_sprite.visible = true 
	fusetimer.start()  # See `on_fusetimer` for what happens when this time runs out

func _process(_delta):
	if active == true:
		movement()
		velocity = move_and_slide(velocity)

func _on_pill_hitbox_detect(area):
	print("grenadelauncher_projectile.gd: Pill detected an area: " + str(area))
	fusetimer.stop()
	area.get_parent().hurt(pill_damage)
	fusetimer.emit_signal("timeout")

func _on_explosion_hitbox_detect(area):
	print("grenadelauncher_projectile.gd: Explosion detected an area: " + str(area))

func _on_fusetimer():
	active = false
	pill_sprite.visible = false
	explosion_sprite.visible =true
	# The explosion is only visual for now
	yield(get_tree().create_timer(0.1),"timeout")
	explosion_sprite.visible = false
	explosion_sound.play()

func _set_team(type:int):
	if type == 1:
		pill_hitbox.set_collision_mask_bit(4,false)
		explosion_hitbox[0].set_collision_mask_bit(4,false)
		pill_hitbox.set_collision_mask_bit(5,true)
		explosion_hitbox[0].set_collision_mask_bit(5,true)
	elif type == 2:
		pill_hitbox.set_collision_mask_bit(4,true)
		explosion_hitbox[0].set_collision_mask_bit(4,true)
		pill_hitbox.set_collision_mask_bit(5,false)
		explosion_hitbox[0].set_collision_mask_bit(5,false)

