extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# Check for collisions with other bodies
	for body in get_colliding_bodies():
		# Check if the colliding body is the ball
		print(body)
		if body.name == "Ball":
			# Perform actions when the ball enters the breakout brick
			on_ball_entered()

func on_ball_entered():
	# This function is called when a ball enters the breakout brick
	# You can implement your logic here, such as destroying the brick
	self.queue_free()  # Destroy the brick
