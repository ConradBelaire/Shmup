extends Area2D

var speed = 500
var angle = 270
var d_angle = 0
var direction : Vector2


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
		
	
	position += direction * speed * delta
	if (position.x < -50 || position.x > 1330):
		queue_free()
		#print("Destroyed bullet")
	if (position.y < -50 || position.y > 1130):
		queue_free()
		#print("Destroyed bullet")


func _on_area_entered(area):
	if area.is_in_group("Enemy"):
		area._hit()
		get_parent()._increase_super()
		queue_free()
