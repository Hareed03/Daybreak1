extends "res://state_machine.gd"

func _state_logic(delta):
	add_state("idle")
	add_state("walking")
	call_deferred("set_state", states.idle)

func _get_transition(delta):
	return null

func _enter_state(new_state, old_state):
	pass

func _exit_state(old_state, new_state):
	pass
func _input(event):
	if [states.idle, states.walking].has(state):
		if Input.is_action_pressed("walk_right"):
			
