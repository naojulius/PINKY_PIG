extends Node2D
@onready var green_pig = preload("res://game/enemies/green_pig.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialog =  DialogueManager.dialogs[2]
	get_tree().get_first_node_in_group("speech_bubble").set_dialogue(dialog)


var called_end_speech: bool = false
func _process(delta):
	if  not $Enemies.has_node("Boss") and not called_end_speech and $Enemies.get_children().size() <= 0:
		called_end_speech = true
		var dialog =  DialogueManager.dialogs[3]
		get_tree().get_first_node_in_group("speech_bubble").set_dialogue(dialog)

	if $Enemies.has_node("Boss") and $Enemies.get_children().size() < 5:
		var _pig: CharacterBody2D = green_pig.instantiate()
		var spawner = $PigsSpawner.get_children().pick_random()
		_pig.global_position = spawner.global_position
		if spawner.get_child(0).is_colliding() and not spawner.get_child(0).get_collider().is_in_group("enemy"):
			$Enemies.add_child(_pig)
			
