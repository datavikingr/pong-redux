extends RigidBody2D

@export var speed = 200
@export var min_speed = 100
@export var max_speed = 300
#var ball_scene = preload("res://tscn/ball.tscn")  # the path to the ball scene


func _ready():
	randomize()
	set_linear_velocity(Vector2(speed, 0).rotated(deg_to_rad(randf_range(0, 360))))

func _physics_process(_delta):
	# Check the current velocity magnitude
	var current_speed = get_linear_velocity().length()
	var velocity = linear_velocity

	# Clamp speed based on min/max speeds
	if current_speed > max_speed:
		velocity = velocity.normalized() * min_speed
	if current_speed < min_speed:
		velocity = velocity.normalized() * min_speed
	
	# Set the new velocity
	set_linear_velocity(velocity)
