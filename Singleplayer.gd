extends Node2D



func _on_Door_body_entered(body):
	pass
		
func _ready():         
	connect("body_entered" , self, "_area_entered")     
	connect("body_exited" , self, "_area_exited")     



func _on_Church_title_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("res://churchFloor.tscn")
	else:
		pass
	


func _on_Area2D_body_entered(body):
	while Input.is_action_just_pressed("crouch"):
		print("hello")
		$StaticBody2D.set_deferred("disabled", true)
	



func _on_Area2D_area_entered(area):
	if Input.is_action_pressed("crouch"):
		print("hello")
		$StaticBody2D.set_deferred("disabled", true)
	


func _on_ChurchEntryTitle_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().change_scene("res://churchINT.tscn")
	else:
		pass
