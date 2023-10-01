extends "res://Scripts/BulletPattern.gd"

var firerate = 2
var shottimer = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (shottimer < 0):
		shottimer += 1.0 / firerate - delta
		_shoot(300, 270, self.global_position, 0)
	else:
		shottimer -= delta
	pass
