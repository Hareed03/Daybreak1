extends Control

signal CloseOptions

func _on_Exit_pressed():
	emit_signal("CloseOptions")


func _on_HSlider_value_changed(value):
	pass
