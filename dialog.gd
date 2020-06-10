extends Control

export(Array, String) var dialog
onready var textObj = $TextureRect/RichTextLabel
var dialog_index = 0
var is_in_NPC = false
export (int) var text_speed
signal text_speed_changed
var finished = false
onready var _timer = $Timer
onready var audio = $AudioStreamPlayer2D
var pause =0.0
func _ready():
	$TextureRect/RichTextLabel.text = " + You've met someone new!"
var playing = false
var text_limit
func _load_dialog():
	
	
	if dialog_index < dialog.size():
		playing = true
		finished = false
		yield(get_tree(),"idle_frame")
		$TextureRect/RichTextLabel.bbcode_text = dialog[dialog_index]

		text_limit = $TextureRect/RichTextLabel.text.length()
		$TextureRect/RichTextLabel.visible_characters = 0
		$Timer.start()

	dialog_index += 1
	
	
func _on_Timer_timeout():
	if text_limit > $TextureRect/RichTextLabel.visible_characters:
		$TextureRect/RichTextLabel.visible_characters += 1
		$AudioStreamPlayer2D.volume_db = rand_range(-22.0, -12.0)
		$AudioStreamPlayer2D.pitch_scale = rand_range(0.95, 1.05)
		$AudioStreamPlayer2D.play()
	else:
		$Timer.stop()
	

func _process(delta):
	if is_in_NPC:
		if Input.is_action_just_pressed("e"):
			_load_dialog()
func text_completed():
	playing = false

func _on_GhostDialogue_area_entered(area):
	$Label.text = "Ghost"
	is_in_NPC = true


func _on_GhostDialogue_area_exited(area):
	is_in_NPC =false
	dialog_index = 0
	_load_dialog()




