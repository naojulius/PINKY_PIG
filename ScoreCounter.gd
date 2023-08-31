extends Node2D

@onready var button_replay = $CanvasLayer/Control/Panel/VBoxContainer/ButtonReplay
@onready var button_main_menu = $CanvasLayer/Control/Panel/VBoxContainer/ButtonMainMenu

func _ready():
	$CanvasLayer/Control.hide()
	button_replay.connect("pressed", _on_replay_pressed)
	button_main_menu.connect("pressed", _on_main_menu_pressed)
	
	
func _process(delta):
	$CanvasLayer/Control/Panel/VBoxContainer/Label.text = str("Scored: ", DialogueManager.score)
	pass


func _on_replay_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game/levels/lvl_0.tscn")
	
func  _on_main_menu_pressed():
	get_tree().paused = false 
	get_tree().change_scene_to_file("res://game/screens/menu.tscn")

func _show():
	get_tree().paused = true
	$CanvasLayer/Control.show()
