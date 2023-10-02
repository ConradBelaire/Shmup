extends Node

class_name BulletPattern

var bullet = preload("res://Scenes/Enemy_Bullet.tscn")
var target_scene

func _init_vars(position, scene):
	self.position = position
	target_scene = scene

func _shoot(speed, angle, position, d_angle):
	var inst = bullet.instantiate()
	target_scene.add_child(inst)
	inst._init_vars(speed, angle, position, d_angle)
	

