extends Node2D
@export var score_multiply_times: int = 2
@onready var animation_player: AnimationPlayer = $AnimationPlayer
var got: bool = false
func _ready():
	$RichTextLabel.text = str("x",score_multiply_times)


func _on_area_2d_body_entered(body):
	if body.is_in_group("player") and not got:
		animation_player.play("explode")
		get_tree().get_first_node_in_group("health_ui").multiply_score(score_multiply_times)
		got = true


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "explode":
		queue_free()
