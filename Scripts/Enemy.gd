extends Area2D

class_name Enemy

var speed = 300
var hp = 30

var phase = 1 # 1-based indexing on enemy phases
var hp_thresholds = [-1] # at hp_thresholds[phase-1], advance phase
# The value is when the current phase should stop and the next phase should begin
# Keep -1 at end so no array out of bounds on last phase

var pattern_scenes = []
var pattern

@onready var top_left = Vector2(get_parent().find_child("TopLeft").position)
@onready var bottom_right = Vector2(get_parent().find_child("BottomRight").position)

var dead = false
var death_timer = 0

var explosion_sprite = preload("res://Sprites/explosion.png")

signal defeated

func _hit():
	hp -= 1
	if (hp <= 0):
		print ("Kaboom!")
		$Sprite.set_texture(explosion_sprite)
		self.remove_from_group("Enemy")
		death_timer = 1.0
		dead = true
		pattern.queue_free()
	elif (hp <= hp_thresholds[phase-1]):
		_change_phase(phase+1)

func _change_phase(phase_num):
	pattern.queue_free()
	phase = phase_num
	pattern = pattern_scenes[phase-1].instantiate()
	pattern._init_vars($Gun.position, owner)
	add_child(pattern)

func _on_body_entered(body):
	if body.is_in_group("Player"):
		body._hit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
