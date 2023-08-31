extends Panel
var pressed: bool = false
var _dialog
var index: int = 0


func _on_button_next_pressed():
	if not pressed:
		pressed = true
		$SpeechAnimation.play("hide")
		set_dialogue(_dialog, index + 1)
		


func _on_speech_animation_animation_finished(anim_name):
	pressed = false

func _process(_delta):
	if $".".visible:
		DialogueManager.dialoguing = true
		#get_tree().get_first_node_in_group("player").can_move = false
	else:
		DialogueManager.dialoguing = false
		#get_tree().get_first_node_in_group("player").can_move = true

func set_dialogue(dialog, indx: int = 0):
	
	index = indx
	_dialog = dialog
	if range(dialog.context.size()).has(indx):
		if dialog.context[indx].text != "end_level_1_teleport_to_boss": #
			if dialog.context[indx].text != "end_boss":
				$Speaker.text = str(dialog.context[indx].speaker)
				$Text.text = str(dialog.context[indx].text)
				$SpeechAnimation.play("show")
		if  dialog.context[indx].text == "end_boss":
			get_tree().get_first_node_in_group("player").get_node("ScoreCounter")._show()
		
		if dialog.context[indx].text == "end_level_1_teleport_to_boss":
			get_tree().change_scene_to_file("res://game/levels/boss_level.tscn")
		
		
