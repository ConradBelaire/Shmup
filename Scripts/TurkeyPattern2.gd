extends "res://Scripts/BulletPattern.gd"

var shottimer = 0.0
var alt_shottimer = 0.0

var step = 0
var step_timer = 2.5
var shot_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_parent().position # No clue why pattern won't follow its parent otherwise
	if (step < 4):
		_subpattern_1(delta)
	elif (step < 5):
		_subpattern_2(delta)
	else:
		step = 0
		step_timer = 3.0 # Add delay after subpat 2
		get_parent().speed = 50


func _subpattern_1(delta):
	if (step_timer > 0.0):
		step_timer -= delta
		return
	
	if (shot_count >= 2):
		shot_count = 0
		step_timer = 1
		step += 1
		alt_shottimer = 3
		return
		
	if (shottimer > 0.0):
		shottimer -= delta
		return
		
	shottimer += 0.5 - delta
	shot_count += 1
	
	var num_shots = 15
	var angle_diff = -10
	var d_angle_diff = 8
	var pos_diff = 50
	
	for i in num_shots:
		var higher_pos = Vector2(position.x + _spread(num_shots, pos_diff, i), position.y - 100)
		var angle_vec = player.position - higher_pos
		var angle = -rad_to_deg(angle_vec.angle())
		
		_shoot(500, angle + _spread(num_shots, angle_diff, i) , higher_pos, _spread(num_shots, d_angle_diff, i))
	

func _subpattern_2(delta):
	if (get_parent().speed != 0): #Get into roughly middle of screen before starting pattern
		if (get_parent().position.x < 620 || get_parent().position.x > 660):
			get_parent().speed = 400
			return
		get_parent().speed = 0
	
	if (alt_shottimer > 0):
		alt_shottimer -= delta
	else:
		var angle_vec = player.position - position
		var angle = -rad_to_deg(angle_vec.angle())
		_shoot(300, angle, position, 0)
		alt_shottimer = 0.4
		
	
	if (step_timer > 0.0):
		step_timer -= delta
		return
	
	if (shot_count >= 160):
		shot_count = 0
		step_timer = 3.0 
		step += 1
		alt_shottimer = 3
		return
	
	if (shottimer > 0):
		shottimer -= delta
		return
	
	shottimer += 0.05 - delta
	shot_count += 1
	
	var num_shots = 14
	var angle_diff = 36
	var d_angle_diff = 0
	var angle_offset
	if ((shot_count / 20) % 2 == 1): # Alternate directions based on which 20
		angle_offset = (shot_count % 20) * 2
	else:
		angle_offset = (20 - (shot_count % 20)) * 2
	
	for i in num_shots:
		_shoot(350, -10 + _spread(num_shots, angle_diff, i) + angle_offset, position, 0)
		#_shoot(140, 270 + 70 + _spread(num_shots, angle_diff, i) , position, -10 + _spread(num_shots, d_angle_diff, i), 4.0)
	
