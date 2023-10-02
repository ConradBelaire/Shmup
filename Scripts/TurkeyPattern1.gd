extends "res://Scripts/BulletPattern.gd"

var shottimer = 0.0
var alt_shottimer = 0.0

var step = 0
var step_timer = 0.0
var shot_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (step < 3):
		_subpattern_1(delta)
	elif (step < 5):
		_subpattern_2(delta)
	else:
		step = 0
		step_timer = 3.0 # Add delay after subpat 2


func _subpattern_1(delta):
	if (step_timer > 0.0):
		step_timer -= delta
		return
	
	if (shot_count >= 8):
		shot_count = 0
		step_timer = 1
		step += 1
		return
		
	if (shottimer > 0.0):
		shottimer -= delta
		return
		
	shottimer += 0.25 - delta
	shot_count += 1
	
	var angle_vec = player.position - position
	var angle = -rad_to_deg(angle_vec.angle())
	
	var num_shots = 14 + (shot_count % 2)
	var angle_diff = 10
	var d_angle_diff = 0
	for i in num_shots:
		_shoot(300, angle + _spread(num_shots, angle_diff, i) , position, _spread(num_shots, d_angle_diff, i))
	

func _subpattern_2(delta):
	if (alt_shottimer > 0):
		alt_shottimer -= delta
	else:
		var angle_vec = player.position - position
		var angle = -rad_to_deg(angle_vec.angle())
		_shoot(300, angle, position, 0)
		alt_shottimer = 0.3
		
	
	if (step_timer > 0.0):
		step_timer -= delta
		return
	
	if (shot_count >= 5):
		shot_count = 0
		step_timer = 3.0 
		step += 1
		return
	
	if (shottimer > 0):
		shottimer -= delta
		return
	
	shottimer += 0.5 - delta
	shot_count += 1
	
	var num_shots = 8 + (shot_count % 2)
	var angle_diff = 10
	var d_angle_diff = 1
	for i in num_shots:
		_shoot(140, 270 - 70 + _spread(num_shots, angle_diff, i) , position, 10 + _spread(num_shots, d_angle_diff, i), 4.0)
		_shoot(140, 270 + 70 + _spread(num_shots, angle_diff, i) , position, -10 + _spread(num_shots, d_angle_diff, i), 4.0)
	
