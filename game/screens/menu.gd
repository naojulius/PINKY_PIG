extends Node2D
@onready var button_containers = $CanvasLayer/Control/VBoxContainer

func _ready():
	get_tree().paused = false
	for i in button_containers.get_children():
		i.connect("mouse_entered", on_button_hover)
		i.connect("pressed", on_button_pressed.bind(i.text))
func _on_button_play_pressed():
	#InteractiveSceneChanger.load_scene("res://game/levels/lvl_0.tscn")
	get_tree().change_scene_to_file("res://game/levels/lvl_0.tscn")
	pass


func _on_button_quit_pressed():
	#get_tree().quit()
	pass # Replace with function body.


func _on_button_credits_pressed():
	$CanvasLayer/Credits._show(true)
	
	pass # Replace with function body.

func on_button_hover():
	$CanvasLayer/Control/AudioStreamPlayer.play()

var pressed_btn: String = ""
func on_button_pressed(_name):
	pressed_btn = str(_name)
	if not $CanvasLayer/Control/ButtonPressed.is_playing():
		$CanvasLayer/Control/ButtonPressed.play()


func _on_button_pressed_finished():
	match pressed_btn:
		"Play":
			#InteractiveSceneChanger.load_scene("res://game/levels/lvl_0.tscn")
			pass
		"Credits":
			pass
		"Quit":
			get_tree().quit()


