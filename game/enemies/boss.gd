extends CharacterBody2D

var life: int = 50
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var dead: bool = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var ray_ground_cast: RayCast2D = $Sprite/RayCastGround
@onready var ray_wall_cast: RayCast2D = $Sprite/RayCastWall
@onready var sprite = $Sprite
@onready var far_cast: RayCast2D = $Sprite/FarCast

func hit():
	life -= 10
	
	

func _physics_process(delta):
	if life <= 0:
		dead = true
		queue_free()
	if global_position.y >= 500:
		queue_free()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if not DialogueManager.dialoguing and not dead:
		_move()
		move_and_slide()
	
var direction: int = -1
func _move():
	get_tree().get_first_node_in_group("camera_animation").play("trauma")
	velocity.x = SPEED * direction
	if not ray_ground_cast.is_colliding():
		sprite.scale.x *= -1
		direction = direction * -1
	if ray_wall_cast.is_colliding():
		if ray_wall_cast.get_collider() is TileMap:
			sprite.scale.x *= -1
			direction = direction * -1
	if far_cast.is_colliding():
		if far_cast.get_collider().is_in_group("player"):
			far_cast.get_collider().sixth_sense()



func _on_hit_box_body_entered(body):
	if body.is_in_group("player") and not dead and not get_tree().get_first_node_in_group("health_ui").dead:
		body.hit(direction, 600)


func _on_hurt_area_area_entered(area):
	if area.get_parent().is_in_group("player") and not dead:
		hit()
		area.get_parent().jump()
