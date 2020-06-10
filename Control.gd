extends Control


func _on_NewGame_pressed():
	get_tree().change_scene("res://Singleplayer.tscn")
	
func _on_QuitGameButton_pressed():
	get_tree().quit()
