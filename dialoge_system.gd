extends Control

var text = ""
var spd_custom = {}
var spd = 0.005
var default_spd = 0.005
var auto_rhythm = true
signal clicked (finished_text)
signal textFinished(finished_text)
var sound_enable = true
var talker_picture = null
var talker_name = ""
var immediately = false

func _ready():
	var err = $btn_dialogue.connect("pressed", self, "_on_btn_dialogue_pressed")
	var err2 = connect("clicked", self, "textboxClicked")
	if err == OK or err2 == OK: pass
	# dialogue examples
	immediately = false
	talker_name = "Thanh"
	talker_picture = load("res://images/avatars/thanh (1).png")
	play_text("Quickly, run and tell your father what has happened, I will stop it for a while!")
	yield(self, "textFinished") # if text finished
	$choice_system/OptionButton.clear()
	$choice_system/OptionButton.add_item("Run")
	$choice_system/OptionButton.add_item("Not Run")
	$choice_system.show()
	yield($choice_system/OptionButton, "item_selected") # if player choiced
	var selected = $choice_system/OptionButton.get_item_text($choice_system/OptionButton.get_selected_items()[0])
	$choice_system.hide()
	if selected == "Run":
		talker_name = "Bim"
		talker_picture = load("res://images/avatars/bim.png")
		play_text("focus on staying alive, okay?")
	else:
		talker_name = "Bim"
		talker_picture = load("res://images/avatars/bim.png")
		play_text("Ha.. ha!..I wouldn't let you down!")
		yield(self, "textFinished")
		yield(get_tree().create_timer(1, false), "timeout")
		play_text("Let's fight together!")
	##########################################

func _on_btn_dialogue_pressed():
	emit_signal("clicked", text)
		
func play_text(dialogue_argument):
	$btn_dialogue.disabled = true
	text = dialogue_argument
	$dialogBox.bbcode_text = "[b]"+"[color=black]"
	$talker_name.text = talker_name
	$talker_picture.texture = talker_picture
	show()
	if text.length() > 0:
		spd = default_spd
		if !immediately:
			for i in text.length():
				if auto_rhythm:
					if text[i] == "." or text[i] == "_":
						spd = 0.5
					elif text[i] == ",":
						spd= 0.3
					else:
						spd = 0.05
						if sound_enable:
							$sound.playing = true
				else:
					if spd_custom.has(i):
						spd = spd_custom[i]
					else: pass
				if text[i] == "_":
					$dialogBox.bbcode_text += ""
				else:
					$dialogBox.bbcode_text += text[i]
				yield(get_tree().create_timer(spd, true), "timeout")
		else:
			$dialogBox.bbcode_text += text
			if sound_enable:
				$sound.playing = true
	$btn_dialogue.disabled = false
	yield(get_tree().create_timer(0.1, true), "timeout")
	emit_signal("textFinished", text)
	
func textboxClicked(finishedText):
	if finishedText == "":pass
	
