extends Control
class_name DialogueBox

signal dialogue_ended()

onready var dialogue_player : DialoguePlayer = get_node("DialoguePlayer")

onready var name_label : = get_node("TextureRect/HBoxContainer/Name") as Label
onready var text_label : = get_node("TextureRect/VBoxContainer/Text") as Label

func start(dialogue : Dictionary) -> void:
	dialogue_player.start(dialogue)
	update_content()
	show()
	
func _on_button
