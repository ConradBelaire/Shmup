extends "res://Scripts/Enemy.gd"

var going_left = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pattern_scenes = [preload("res://Scenes/Pattern1.tscn"), \
		preload("res://Scenes/Pattern2.tscn")]
	
	pattern = pattern_scenes[0].instantiate()
	pattern._init_vars($Gun.position, get_parent())
	add_child(pattern)
	
	hp_thresholds = [25,-1]
	hp = 40
	speed = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (dead):
		death_timer -= delta
		if (death_timer <= 0):
			emit_signal("defeated")
			queue_free()
		return
	var velocity
	if (!going_left):
		velocity = speed * delta
	else:
		velocity = speed * delta * -1
	position.x += velocity
	if (position.x < top_left.x || position.x > bottom_right.x):
		going_left = !going_left
		position = position.clamp(top_left, bottom_right)
	


