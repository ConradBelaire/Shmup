extends "res://Scripts/Enemy.gd"

var going_left = false
var intro = true
var plate_gone = false

# Called when the node enters the scene tree for the first time.
func _ready():
	position.x = (top_left.x + bottom_right.x) / 2
	position.y = top_left.y - 400
	
	pattern_scenes = [preload("res://Scenes/TurkeyPattern1.tscn")]
	
	hp_thresholds = [-1]
	hp = 200
	speed = 300


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (intro):
		var vel = 200 * delta
		position.y += vel
		if (position.y > 200):
			position.y = 200
			intro = false
			
			pattern = pattern_scenes[0].instantiate()
			pattern._init_vars(position, get_parent(), get_parent().find_child("Player"))
			add_child(pattern)
		return
	
	$Dinnerplate.position.y -= 200 * delta
