extends KinematicBody2D


export (String) var chapter = "beginning"
export (String) var dialog = "ghost"
export (int) var start_at = 0
var is_in_NPC = false
var showdiag = false
func is_NPC():
	pass
func _process(delta):
	if is_in_NPC:
		$CanvasLayer/Control.show()
	else:
		$CanvasLayer/Control.hide()
func _on_GhostDialogue_area_entered(area):
	is_in_NPC = true
	$Label.text = "[Press E]"


func _on_GhostDialogue_area_exited(area):
	is_in_NPC = false
	$Label.text = ""
