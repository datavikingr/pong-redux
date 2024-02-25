extends RigidBody2D
signal deathtimer()

func _process(_delta):
	for body in get_colliding_bodies(): # Check for collisions with other bodies
		if body.name == "Ball": # Check if the colliding body is the ball
			deathtimer.emit()

func _on_timer_timeout():
	self.queue_free()  # Destroy the brick
