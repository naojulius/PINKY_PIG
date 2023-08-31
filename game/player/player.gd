extends CharacterBody2D

@onready var animation_tree: AnimationTree = $Mesh/AnimationTree
@onready var sprite: AnimatedSprite2D = $Mesh/Sprite
@onready var trail: Line2D = $Trail
var SPEED = 200.0
const JUMP_VELOCITY = -800.0
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") * 3
var DIRECTION: int = 0
var ENEMY_DIRECTION: int = 0
var should_trail: bool = true
var dead: bool = false
var can_move: bool = true
func _ready():
	should_trail = true
	$CoyoteTimer.connect("timeout", coyote_timer_finished)
	$KnockBackTimer.connect("timeout", knocked_back_timer_finished)
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


var CAN_JUMP: bool = true
func _process(delta):
	set_trail()
	if is_on_floor() and not CAN_JUMP:
		CAN_JUMP = true
	if CAN_JUMP and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start(0.1)
		
	if Input.is_action_just_pressed("jump") and CAN_JUMP and not DialogueManager.dialoguing:
		jump()
	if not is_on_floor() and not CAN_JUMP:
		animation_tree.set("parameters/MOVEMENT/transition_request", "JUMP")
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		
	if global_position.y >= 500:
		dead = true
	else:
		dead = get_tree().get_first_node_in_group("health_ui").dead
	#

func jump(force: int = 1):
	velocity.y = JUMP_VELOCITY * force
	
	#animation_tree.set("parameters/JUMP_BLEND/blend_position", 1)
	#animation_tree.set("parameters/SHOT/request", true)

func _physics_process(_delta):
	if not dead:
		if not knocked_back:
			if not DialogueManager.dialoguing:
				DIRECTION = Input.get_axis("left", "right")
			if DIRECTION:
				animation_tree.set("parameters/MOVEMENT/transition_request", "WALK")
				velocity.x = DIRECTION * SPEED
				if sign(sprite.scale.x) != sign(DIRECTION):
					sprite.scale.x *= -1
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED)
				animation_tree.set("parameters/MOVEMENT/transition_request", "IDLE")
		else:
			velocity.x = ENEMY_DIRECTION   * knockback_power
		if DialogueManager.dialoguing:
			SPEED = 0
			animation_tree.set("parameters/MOVEMENT/transition_request", "IDLE")
		else:
			SPEED = 200.0
		move_and_slide()
	else:
		$GameOver._show()
	
	
var trail_queue: Array 
var max_trail_length: int = 10

func set_trail():
	var pos = position
	trail_queue.push_front(pos)
	if trail_queue.size() > max_trail_length:
		trail_queue.pop_back()
		
	trail.clear_points()
	for point in trail_queue:
		trail.add_point(point)

#var area_hited: bool = false
func _on_hit_area_area_entered(area):
	#if area.is_in_group("enemy_hurt_box") and not area_hited:
	#	area_hited = true
	#	area.get_parent().hit()
	#	area.get_parent().get_node("Collision").disabled = true
	#	jump()
	pass

func coyote_timer_finished():
	CAN_JUMP = false
var knockback_power: int = 150
func hit(enemy_dir, knockback_power: int = 150):
	get_tree().get_first_node_in_group("health_ui").remove_heath()
	get_tree().get_first_node_in_group("camera_animation").play("trauma")
	animation_tree.set("parameters/SHOT/request", true)
	ENEMY_DIRECTION = enemy_dir
	knockBack()

var knocked_back: bool = false
func knockBack():
	knocked_back = true
	$KnockBackTimer.start()

	
func knocked_back_timer_finished():
	knocked_back = false
	knockback_power = 150

func sixth_sense():
	$Emote._show("exclamation")
	pass
