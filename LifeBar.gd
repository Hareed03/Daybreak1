extends HBoxContainer

var maximum_value = 20
var current_health = 0

func initialize(maximum):
	maximum_value = maximum
	$TextureProgress.max_value = maximum

func _on_UserInterface_health_change(health):
	animate_value(current_health, health)
	current_health = health

func animate_value(start, end):
	
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.3, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "set_count_text", start, end, 0.6, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start
	if end < start:
		$AnimationPlayer.play("shake")
	
	
func set_count_text(value):
	$Count/Number.text = str(round(value)) + "/" + str(maximum_value)
