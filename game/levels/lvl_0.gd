extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogueManager.score = 0
	var dialog =  DialogueManager.dialogs[0]
	get_tree().get_first_node_in_group("speech_bubble").set_dialogue(dialog)
	pass


func _on_big_boss_point_entrence_body_entered(body):
	if body.is_in_group("player") and $Enemies.get_children().size() == 0: 
		var dialog =  DialogueManager.dialogs[1]
		get_tree().get_first_node_in_group("speech_bubble").set_dialogue(dialog)
