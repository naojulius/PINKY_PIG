extends CharacterBody2D
@onready var sprite: AnimatedSprite2D = $Mesh/Sptite
@onready var animation_tree: AnimationTree = $Mesh/AnimationTree
@export var  SPEED = 50.0
@onready var ray_ground_cast: RayCast2D = $Mesh/Sptite/RayCastGround
@onready var ray_wall_cast: RayCast2D = $Mesh/Sptite/RayCastWall
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * 2
var dead: bool = false
func _ready():
	$KnockedBackTimer.connect("timeout", _knockedback_timer_finished)

func hit():
	dead = true
	$Explosion.play("explosion")
	if not $ExplosionSound.is_playing():
		$ExplosionSound.pitch_scale = [0.9, 1, 1.1, 1.2, 1.3].pick_random()
		$ExplosionSound.play()
		get_tree().get_first_node_in_group("camera_animation").play("trauma")

func _process(_delta):
	if dead:
		$Collision.disabled = true
		$Mesh.hide()
		if $HurtArea.is_connected("area_entered", _on_hurt_area_area_entered):
			$HurtArea.disconnect("area_entered", _on_hurt_area_area_entered)
		
	if global_position.y >= 500:
		queue_free()

func _physics_process(delta):
	if not get_tree().get_first_node_in_group("health_ui").dead:
		if not is_on_floor():
			velocity.y += gravity * delta
		if not DialogueManager.dialoguing and not dead:
			_move()
			move_and_slide()
			
	
var direction: int = -1
func _move():
	if knockedback:
		velocity.x = SPEED * -direction
	else:
		velocity.x = SPEED * direction
	if not ray_ground_cast.is_colliding():
		sprite.scale.x *= -1
		direction = direction * -1
	if ray_wall_cast.is_colliding():
		if ray_wall_cast.get_collider() is TileMap or ray_wall_cast.get_collider().is_in_group("enemy"):
			sprite.scale.x *= -1
			direction = direction * -1
	
	
func _on_explosion_animation_finished():
	get_tree().get_first_node_in_group("health_ui").add_score()
	queue_free()

var knockedback: bool = false
var hited: bool = false
func _on_hit_box_body_entered(body):
	if body.is_in_group("player") and not dead and not get_tree().get_first_node_in_group("health_ui").dead:
		body.hit(direction)
		$KnockedBackTimer.start()
		knockedback = true

func _knockedback_timer_finished():
	knockedback = false


func _on_hurt_area_area_entered(area):
	if area.get_parent().is_in_group("player") and not dead:
		hit()
		area.get_parent().jump()
