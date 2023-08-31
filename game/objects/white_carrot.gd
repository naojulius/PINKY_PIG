extends Node2D

var picked: bool = false
func _on_area_2d_body_entered(body):
	
	if body.is_in_group("player"):
		if not picked:
			take()
func take():
	picked = true
	#$Sprite2D.hide()
	$PickUpSFX.play()
	get_tree().get_first_node_in_group("health_ui").add_health()


func _on_pick_up_sfx_finished():
	queue_free()
