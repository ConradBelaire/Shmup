extends CharacterBody2D

@export var speed = 300
@export var slow_speed = 100
@export var bullet: PackedScene

signal update_life

var top_left : Vector2
var bottom_right : Vector2

var firerate = 5
var shotspeed = 500
var shot_timer = 0

var dead = false
var death_timer = 0

func _shoot():
	if (shot_timer > 0):
		return
	for i in 4:
		var inst = bullet.instantiate()
		owner.add_child(inst)
		inst._init_vars(shotspeed, 95 - 2.5*i, find_child("Gun" + str(i+1)).global_position, 0)
	shot_timer = 1.0 / firerate
	

func _hit():
	print ("Kaboom!")
	$Sprite.play("Explode")
	#self.remove_from_group("Enemy")
	death_timer = 1.0
	dead = true
	Global.lives -= 1
	emit_signal("update_life")

# Called when the node enters the scene tree for the first time.
func _ready():
	top_left = Vector2(owner.find_child("TopLeft").position)
	bottom_right = Vector2(owner.find_child("BottomRight").position)
	position = owner.find_child("PlayerSpawn").position
	
	#emit_signal("update_life")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if (dead):
		if (death_timer < 0):
			if (Global.lives > 0):
				position = owner.find_child("PlayerSpawn").position
				dead = false
				death_timer = 1.0
				$Sprite.play("default")
			else:
				print("Game over!")
		else: 
			death_timer -= delta
		return
	shot_timer -= delta
	if Input.is_action_pressed("fire"):
		_shoot()
	
	var velocity = Vector2.ZERO
	var slowed = false
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("slow"):
		slowed = true
	
	if slowed:
		velocity *= slow_speed
	else:
		velocity *= speed
		
	position += velocity * delta
	position = position.clamp(top_left, bottom_right)
