extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in $".".get_children():
		if i is Sprite2D:
			i.hide()
	pass # Replace with function body.

func _show(_name):
	for i in $".".get_children():
		if i is Sprite2D:
			i.hide()
	$".".get_node(str(_name)).show()
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play(str(_name))

