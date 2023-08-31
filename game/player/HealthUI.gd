extends Panel
@onready var health = $Bar
var dead: bool = false
var health_min = 0
var health_max = 230

func remove_heath():
	if health.size.x > health_min:
		health.size.x -= 23
		
func add_health():
	if health.size.x < health_max:
		health.size.x += 23
		if health.size.x > health_max:
			health.size.x = health_max
	
func _process(_delta):
	if health.size.x <= 0:
		dead = true
		health.size.x = 0
	else:
		dead = false
	$Score/Value.text = str(DialogueManager.score)

func add_score():
	for i in 20:
		await get_tree().create_timer(0.03).timeout
		
		DialogueManager.score = DialogueManager.score + 1
		#$Score/Value.text =   str(int($Score/Value.text) + 1)
		
func multiply_score(times: int):
	DialogueManager.score = DialogueManager.score * times
	#$Score/Value.text = str(int($Score/Value.text) * times)
