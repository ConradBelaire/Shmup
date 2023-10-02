extends "res://Scripts/BulletPattern.gd"

var firerate = 2
var shottimer = 0

var step = 0
var step_timer = 0.0
var shot_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (step < 5):
		if (step_timer <= 0.0):
			if (shot_count < 8):
				if (shottimer < 0):
					shottimer += 0.1 - delta
					shot_count += 1
					
					var angle_vec = player.position - position
					var angle = -rad_to_deg(angle_vec.angle())
					for i in 5:
						_shoot(300, angle + 10 - 5*i , position, -20 + 10*i)
					
				else:
					shottimer -= delta
			else:
				shot_count = 0
				step_timer = 0.5
				step += 1
		else:
			step_timer -= delta
	pass
