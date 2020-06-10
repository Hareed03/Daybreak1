extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():         
	connect("body_entered" , self, "_area_entered")     
	connect("body_exited" , self, "_area_exited")     
func _area_entered(object):
	if Input.is_action_just_pressed("interact"):
		get_tree().change_scene("res://home1.tscn")
	
func _physics_process(delta):
	pass
