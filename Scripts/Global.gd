extends Node2D

var lives = 3

func _update_lives():
	print(get_node("/root/").get_child(1).find_child("UI").name)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
