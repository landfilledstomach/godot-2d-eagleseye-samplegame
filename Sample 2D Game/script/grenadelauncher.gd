extends Node2D

signal weapon_clip_size(clipsize)

signal weapon_setteam(type)
var team = 0
onready var reloading = $Reload
const reloading_time = 0.4

onready var firerate = $Firerate # Will set `firerate_available` back to true on timeout
var firerate_available = true # If true, the next time `shoot()` is called, it will fire a projectile (if `projectiles_cycle` is not -1 or lower)
const firerate_time = 0.4

onready var projectiles = [$projectile_grenade1,$projectile_grenade2,$projectile_grenade3,$projectile_grenade4] # All of the projectile instances
var projectiles_cycle = 3 # Will cycle through all of the projectile instances
const projectiles_max = 3
func _ready():
	var temp = projectiles_cycle
	while (temp != -1):
		self.connect("weapon_setteam",projectiles[temp],"_set_team")
		temp -= 1
	firerate.connect("timeout", self, "on_firerate")
	reloading.connect("timeout",self,"_on_reloading_timeout")
	emit_signal("weapon_clip_size", projectiles_cycle)

func _on_attack1(entity_rotation,entity_position):
	if projectiles_cycle < 0 and firerate_available == false: 
		null
	elif projectiles_cycle <= projectiles_max and projectiles_cycle >= 0 and firerate_available == true:
		firerate_available = false
		projectiles[projectiles_cycle].shoot(entity_rotation, entity_position)
		projectiles_cycle -= 1
		firerate.start(firerate_time)
		emit_signal("weapon_clip_size",projectiles_cycle)
		if reloading.is_stopped() == true:
			null
		elif reloading.is_stopped() == false:
			reloading.stop()

func _on_reload():
	reloading.start(reloading_time)

func _on_reloading_timeout():
	if firerate_available == false:
		return null
	projectiles_cycle += 1
	emit_signal("weapon_clip_size",projectiles_cycle)
	if projectiles_cycle == projectiles_max:
		null
	else:
		reloading.start(reloading_time)
	

func on_firerate():
	firerate_available = true

func set_team(type:int):
	emit_signal("weapon_setteam",type)
		
