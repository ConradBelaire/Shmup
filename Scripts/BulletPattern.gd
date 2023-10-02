extends Node2D

class_name BulletPattern

var bullet = preload("res://Scenes/Enemy_Bullet.tscn")
var target_scene
var player

func _init_vars(position, scene, player = null):
	self.position = position
	target_scene = scene
	self.player = player

func _shoot(speed, angle, position, d_angle):
	var inst = bullet.instantiate()
	target_scene.add_child(inst)
	inst._init_vars(speed, angle, position, d_angle)
	

