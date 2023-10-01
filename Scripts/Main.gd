extends Node2D

@onready var player = $Player
@onready var ui = $UI

func _handle_update_life():
	ui.lives_counter.text = str(Global.lives)
	
	if (Global.lives == 0):
		$GameOver.visible = true
		get_tree().paused = true
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	player.connect("update_life", Callable(self, "_handle_update_life"))
	_handle_update_life()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
