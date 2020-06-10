extends AnimationTree


# Declare member variables here. Examples:
# var a = 2
var state_machine : AnimationNodeStateMachinePlayback


# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = get("parameters/playback")
	state_machine.start("idle")
	active = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("walk_right"):
		state_machine.travel("walking")
		return
	if Input.is_action_pressed("walk_left"):
		state_machine.travel("walking")
		return
	else:
		state_machine.travel("idle")
