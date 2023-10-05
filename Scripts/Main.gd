extends Node2D

@onready var player = $Player
@onready var ui = $UI

@export var starting_lives = 3

@onready var menu_scene = load("res://Scenes/MainMenu.tscn")
@onready var turkey_enemy_scene = preload("res://Scenes/TurkeyEnemy.tscn")

var game_over = false

func _increase_super():
	if (Global.super_val < Global.super_max):
		Global.super_val += 1
		$UI.super_bar.value = Global.super_val * 100 / Global.super_max

func _spend_super():
	Global.super_val = 0
	$UI.super_bar.value = 0

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



func _on_return_timer_timeout():
	get_tree().paused = false
	get_tree().change_scene_to_packed(menu_scene)


func _on_enemy_1_defeated():
	# Last enemy calls signal before queue_free()ing itself
	if (get_tree().get_nodes_in_group("Enemy").size() != 1): 
		return
	var turkey_enemy = turkey_enemy_scene.instantiate()
	add_child(turkey_enemy)
