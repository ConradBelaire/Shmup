extends Area2D

@export var speed = 300
@export var hp = 30
#@export var bullet: PackedScene
var pattern_scene1 = preload("res://Scenes/Pattern1.tscn")
var pattern_scene2 = preload("res://Scenes/Pattern2.tscn")
var pattern1
var pattern2

var ship_sprite = preload("res://Sprites/evil_ship2.png")
var explosion_sprite = preload("res://Sprites/explosion.png")

var phase = 1

var top_left : Vector2
var bottom_right : Vector2

var firerate = 5
var shotspeed = 500
var shot_timer = 0

var going_left = false
var dead = false
var death_timer = 0

func _hit():
	hp -= 1
	if (hp <= 0):
		print ("Kaboom!")
		for _i in self.get_children():
			print(_i)
		$Sprite.set_texture(explosion_sprite)
		self.remove_from_group("Enemy")
		death_timer = 1.0
		dead = true
	elif (hp <= 15 && phase == 1):
		_change_phase()

func _change_phase():
	phase = 2
	pattern1.queue_free()
	pattern2 = pattern_scene2.instantiate()
	pattern2._init_vars($Gun.position, owner)
	pattern2.set_name("Pattern2")
	add_child(pattern2)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	top_left = Vector2(owner.find_child("TopLeft").position)
	bottom_right = Vector2(owner.find_child("BottomRight").position)
	#position = owner.find_child("PlayerSpawn").position
	pattern1 = pattern_scene1.instantiate()
	pattern1._init_vars($Gun.position, owner)
	pattern1.set_name("Pattern1")
	add_child(pattern1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (dead):
		death_timer -= delta
		if (death_timer <= 0):
			queue_free()
		return
	var velocity
	if (!going_left):
		velocity = speed * delta
	else:
		velocity = speed * delta * -1
	position.x += velocity
	if (position.x < top_left.x || position.x > bottom_right.x):
		going_left = !going_left
		position = position.clamp(top_left, bottom_right)
	


