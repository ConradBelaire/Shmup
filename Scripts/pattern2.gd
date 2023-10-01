extends "res://Scripts/BulletPattern.gd"

var firerate = 9
var shottimer = 0
var angle = 0
var d_angle = 280

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	angle += d_angle * delta
	if (shottimer < 0):
		shottimer += 1.0 / firerate - delta
		_shoot(200, angle, self.global_position, 0)
	else:
		shottimer -= delta
	pass
