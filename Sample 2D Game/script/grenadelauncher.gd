extends Node2D

var projectiles = [$projectile_grenade1,$projectile_grenade2,$projectile_grenade3,$projectile_grenade4] # All of the projectile instances
var projectiles_cycle = 3 # Will cycle through all of the projectile instances
var firerate_available = true # If true, the next time `shoot()` is called, it will fire a projectile (if `projectiles_cycle` is not -1 or lower)
var firerate = Timer.new() # Will set `firerate_available` back to true on timeout
func _ready():
	firerate.connect("timeout", self, "on_firerate")
	print("grenadelauncher.gd: Loaded Grenade Launcher")

func on_attack1(entity_rotation,entity_position):
	if projectiles_cycle > 0: # When projectiles_cycle = -1, the weapon will not shoot a projectile
		pass
	elif firerate_available == false: # The firerate of a weapon
		pass
	else:
		projectiles[projectiles_cycle].shoot(entity_rotation, entity_position)
		projectiles_cycle -= 1
		firerate_available = false
		firerate.start(0.4)

func on_reload():
	while(projectiles < 3 and firerate_available == true):
		
func on_firerate():
	firerate_available = true