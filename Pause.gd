extends CanvasLayer

onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("GameMenu")
var text_speed
var paused: = false setget set_paused




		
func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()


func _on_Resume_button_up():
	get_tree().paused = false
	$PauseOverlay.hide()


func _on_KinematicBody2D_dead():
	$DeathOverlay.show()


func _on_Restart_button_up():
	get_tree().reload_current_scene()


func _on_Options_pressed():
	var options_menu = load("res://Options.tscn").instance()
	add_child(options_menu)
	get_node("Options").connect("CloseOptions", self, "CloseOptions")

func CloseOptions():
	get_node("Options").queue_free()


func _on_Exit_pressed():
	get_node("GameMenu").hide()


func _on_HSlider_value_changed(value):
	pass
	

func _on_Control_text_speed_changed():
	pass
