extends KinematicBody2D

# This is used for making the enemy act the way it acts.
var metadata = null

# Called when the node enters the scene tree for the first time.
func _ready():
	print("New Enemy entity with the properties: " + metadata,"\t")


