extends RigidBody2D

@export var speed = 200 # starting speed
@export var min_speed = 100 # pretty obvious
@export var max_speed = 300 # also self-evident

func _ready():
	# random seed, baby, Roll them dice!
	randomize()
	# Let's see where they point!
	set_linear_velocity(Vector2(speed, 0).rotated(deg_to_rad(randf_range(0, 360))))

func _physics_process(_delta):
	# Check the current velocity magnitude
	var current_speed = get_linear_velocity().length()
	# Editor variable, for tweaking
	var velocity = linear_velocity 
	# Clamp speed based on min/max speeds
	if current_speed > max_speed: # Strangely, I'm told this normalizes the speed toward the max
		velocity = velocity.normalized() * max_speed
	if current_speed < min_speed: # Strangely, I'm told this normalizes the speed toward the min
		velocity = velocity.normalized() * min_speed
	# Set the new velocity
	set_linear_velocity(velocity)
