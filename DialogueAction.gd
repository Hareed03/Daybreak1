extends MapAction
class_name DialogueAction

export (String, FILE, "*.json") var dialogue_file_path : String

func interact() -> void:
	var dialogue : Dictionary = load_dialogue(dialogue_file_path)
	yield(localmap.play_dialogue(dialogue), "completed")
	emit_signal("Finished")
	
func load_dialogue(file_path) -> Dictionary:
	var file = File.new()
	assert (file.file_exists(file_path))
	
	file.open(file_path, file.READ)
	var dialogue = parse_json(file.get_as_text)
	assert (dialogue.size() >0)
	return dialogue
