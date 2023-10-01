extends Node2D

@onready var player = $Player
@onready var ui = $UI

@export var starting_lives = 3

@onready var menu_scene = load("res://Scenes/MainMenu.tscn")

var game_over = false

func _handle_update_life():
	ui.lives_counter.text = str(Global.lives)
	
	if (Global.lives == 0):
		$GameOver.visible = true
		get_tree().paused = true
		$ReturnTimer.start()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.lives = starting_lives
	player.connect("update_life", Callable(self, "_handle_update_life"))
	_handle_update_life()
	
	get_tree().paused = false
	$ReturnTimer.stop()
	$GameOver.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_return_timer_timeout():
	get_tree().paused = false
	get_tree().change_scene_to_packed(menu_scene)
