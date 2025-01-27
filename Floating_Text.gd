extends Position2D


onready var label = get_node("Label")
onready var tween = get_node("Tween")
var amount = 0
var velocity = Vector2(0,0)
var max_size = Vector2(1,1)
func _ready():
	label.set_text(str(amount))
	randomize()
	var side_movement = randi() % 121 - 60
	velocity = Vector2(side_movement, 50)
	tween.interpolate_property(self, 'scale', scale, max_size, 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.interpolate_property(self, 'scale', max_size, Vector2(0.1,0.1), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.start()

func _on_Tween_tween_all_completed():
	self.queue_free()

func _process(delta):
	position -= velocity * delta
