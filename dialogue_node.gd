extends Area2D

var can_talk = true
var talking_pearson = null
var actors = ["actor_1", "actor_2", "actor_3", "actor_4", "actor_hank",]
var actions = ["play_animation", "set_animation", "end_dialogue"]
var execute_action = null
var dialogue_line_number = 0
var dialogue_start = false
var animation_name : String

export (Color) var actor_1_text_color
export (Color) var actor_2_text_color
export (Color) var actor_3_text_color
export (Color) var actor_4_text_color

export (NodePath) var actor_1
export (NodePath) var actor_2
export (NodePath) var actor_3
export (NodePath) var actor_4
export (NodePath) var actor_hank

export (Array, String) var dialogue_lines

export (bool) var active

onready var ghost = get_parent().get_parent().get_node("Ghost")
onready var hank_text = get_node("../hank/hank_text")
onready var director = get_node("../director")
onready var hank_animation = get_node("../hank/AnimationPlayer")

signal line_finished

func _ready():
	print()
	if active == true:
		$CollisionShape2D.disabled = false
	else:
		$CollisionShape2D.disabled = true

func _process(delta):
	print()


func _on_dialogue_node_area_entered(area):
	dialogue_start = true
	hank_text.show()


func _on_dialogue_node_area_exited(area):
	dialogue_start = false
	hank_text.hide()




func _input(event):
	if dialogue_start == true:
		if Input.is_action_just_pressed("e"):
			if can_talk == true:
				$dialogue_placer/text_box.show()
				$dialogue_placer/next.hide()
				ghost.talking = true
				$dialogue_placer/speaker_name.show()
				dialogue()
			else:
				return
	else:
		return



func dialogue():
	can_talk = false
	$dialogue_placer/text.visible_characters = 0
	$dialogue_placer/text.text = dialogue_lines[dialogue_line_number]
	
	
	if dialogue_lines[dialogue_line_number] in actors:
		talking_pearson = dialogue_lines[dialogue_line_number]
		
		match talking_pearson:
			
			"actor_1":
				talking_pearson = actor_1
				$dialogue_placer/text.set("custom_colors/font_color", actor_1_text_color)
				$dialogue_placer/speaker_name.set("custom_colors/font_color", actor_1_text_color)
				$dialogue_placer/speaker_name.text = get_node(talking_pearson).name
				dialogue_line_number += 1
				dialogue()
				return
			"actor_2":
				talking_pearson = actor_2
				$dialogue_placer/text.set("custom_colors/font_color", actor_2_text_color)
				$dialogue_placer/speaker_name.set("custom_colors/font_color", actor_2_text_color)
				$dialogue_placer/speaker_name.text = get_node(talking_pearson).name
				dialogue_line_number += 1
				dialogue()
				return
			"actor_3":
				talking_pearson = actor_3
				$dialogue_placer/text.set("custom_colors/font_color", actor_3_text_color)
				$dialogue_placer/speaker_name.set("custom_colors/font_color", actor_3_text_color)
				$dialogue_placer/speaker_name.text = get_node(talking_pearson).name
				dialogue_line_number += 1
				dialogue()
				return
			"actor_4":
				talking_pearson = actor_4
				$dialogue_placer/text.set("custom_colors/font_color", actor_4_text_color)
				$dialogue_placer/speaker_name.set("custom_colors/font_color", actor_4_text_color)
				$dialogue_placer/speaker_name.text = get_node(talking_pearson).name
				dialogue_line_number += 1
				dialogue()
				return
			"actor_hank":
				talking_pearson = actor_hank
				$dialogue_placer/text.set("custom_colors/font_color", Color("#ffffff"))
				$dialogue_placer/speaker_name.set("custom_colors/font_color", Color("#ffffff"))
				$dialogue_placer/speaker_name.text = get_node(talking_pearson).name
				dialogue_line_number += 1
				dialogue()
				return
	else:
		pass
	
	
	if dialogue_lines[dialogue_line_number] in actions:
		execute_action = dialogue_lines[dialogue_line_number]
		
		match execute_action:
			
			"play_animation":
				
				$dialogue_placer/text_timer.stop()
				$dialogue_placer/speaker_name.hide()
				$dialogue_placer/text_box.hide()
				
				var a = get_node(str(talking_pearson) + "/AnimationPlayer")
				
				a.play(animation_name)
				yield(a, "animation_finished")
				dialogue_line_number += 1
				$dialogue_placer/text_box.show()
				$dialogue_placer/speaker_name.show()
				dialogue()
				return
			
			"set_animation":
				animation_name = dialogue_lines[dialogue_line_number +1]
				dialogue_line_number += 2
				dialogue()
				return
			
			"end_dialogue":
				
				$dialogue_placer/text_timer.stop()
				$dialogue_placer/speaker_name.hide()
				$dialogue_placer/text_box.hide()
				director.zoom(Vector2(0.6, 0.6), 1.0)
				ghost.talking = false
				queue_free()
	else:
		pass
	
	
	
	$dialogue_placer/text_timer.start()
	yield(self, "line_finished")
	dialogue_line_number += 1
	can_talk = true



func _on_text_timer_timeout():
	if $dialogue_placer/text.percent_visible != 1:
		$dialogue_placer/text.visible_characters += 1
	else:
		emit_signal("line_finished")
		$dialogue_placer/next.show()
