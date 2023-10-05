extends Area2D

var speed = 500
var angle = 270
var d_angle = 0
var direction : Vector2

var hit_cooldown = 0.0
var hitcount = 0
var target
var colliding = false

func _init_vars(speed, angle, position, d_angle):
	self.speed = speed
	self.angle = angle
	self.position = position
	self.d_angle = d_angle
	
	_update_direction()

func _update_direction():
	direction = Vector2(cos(deg_to_rad(angle)), -sin(deg_to_rad(angle))) # Negative y so its standard CCW rotation
	rotation = deg_to_rad(90) - deg_to_rad(angle) # Editor uses CW from top

# Called when the node enters the scene tree for the first time.
func _ready():
	_update_direction()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if d_angle != 0:
		angle += d_angle * delta
		_update_direction()
		
	
	hit_cooldown -= delta
	rotation += 2*PI * delta
	
	if (colliding):
		#print("Colliding!")
		if (hit_cooldown > 0):
			pass
		else:
			target._hit()
			hit_cooldown = 0.05
			hitcount += 1
	
	position += direction * speed * delta
	if (position.x < -50 || position.x > 1330):
		queue_free()
		#print("Destroyed bullet")
	if (position.y < -50 || position.y > 1130):
		print(hitcount)
		queue_free()
		#print("Destroyed bullet")


func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		target = area
		colliding = true
	if area.is_in_group("Enemy_bullet"):
		area.queue_free()


func _on_area_exited(area):
	if area.is_in_group("Enemy"):
		#print("Left area")
		colliding = false
	pass # Replace with function body.
