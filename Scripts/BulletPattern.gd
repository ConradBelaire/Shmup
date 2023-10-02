extends Node2D

class_name BulletPattern

var bullet = preload("res://Scenes/Enemy_Bullet.tscn")
var target_scene
var player

func _init_vars(position, scene, player = null):
	self.position = position
	target_scene = scene
	self.player = player

func _shoot(speed, angle, position, d_angle, d_angle_timeout = 1.0):
	var inst = bullet.instantiate()
	target_scene.add_child(inst)
	inst._init_vars(speed, angle, position, d_angle, d_angle_timeout)
	

# Returns an int you add to a base angle to spread out the bullets when shooting a blast
# EX. with 3 shots, it shoots i=0 diff degrees to right, i=1 at angle, i=2 diff to left
# Also handy if doing d_angle stuff
func _spread(num_shots, diff, i) -> int:
	return ((num_shots-1) * diff / 2) - diff*i
