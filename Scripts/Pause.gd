extends Control

signal unpause

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/ContinueButton.grab_focus()
	print("hi there")
	pass # Replace with function body.

func _process(delta):
	if (Input.is_action_just_pressed("esc")):
		print("esc")
		unpause.emit()

func _on_menu_button_pressed():
	print("menu")
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")


func _on_quit_button_pressed():
	print("quit")
	get_tree().quit()


func _on_continue_button_pressed():
	print("continue")
	unpause.emit()
