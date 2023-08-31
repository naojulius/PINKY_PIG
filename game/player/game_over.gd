extends Node2D

@onready var button_replay = $CanvasLayer/Control/Panel/VBoxContainer/ButtonReplay
@onready var button_main_menu = $CanvasLayer/Control/Panel/VBoxContainer/ButtonMainMenu

func _ready():
	button_replay.connect("pressed", _on_replay_pressed)
	button_main_menu.connect("pressed", _on_main_menu_pressed)
	_hide()


func _on_replay_pressed():
	get_tree().change_scene_to_file("res://game/levels/lvl_0.tscn")
	#InteractiveSceneChanger.load_scene("res://game/levels/lvl_0.tscn")
	
func  _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://game/screens/menu.tscn")
	#InteractiveSceneChanger.load_scene("res://game/screens/menu.tscn")

func _hide():
	$CanvasLayer/Control.hide()

var played: bool = false
func _show():
	if not $AudioStreamPlayer.is_playing() and not played:
		$AudioStreamPlayer.play()
		var bg_music: AudioStreamPlayer = get_tree().get_first_node_in_group("bg_music")
		bg_music.stop()
		played = true
	$CanvasLayer/Control.show()
