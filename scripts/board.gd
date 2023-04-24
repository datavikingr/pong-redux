extends Node2D

var court_size = Vector2(240, 135)  # the size of the court

func _ready():
	spawn_ball()

func spawn_ball():
	var ball_scene = load("res://tscn/ball.tscn")
	var new_ball = ball_scene.instantiate()
	new_ball.position = Vector2(court_size.x/2, court_size.y/2)  # place the new ball in the center of the court
	add_child.call_deferred(new_ball)  # add the new ball to the scene tree

func _physics_process(_delta):
	# Check if "ball" node exists
	if has_node("*Ball*"):
		# Get "ball" node position
		var ball_pos = get_node("Ball").position
		print(ball_pos)
		# Check if "ball" is outside of x and y range
		if ball_pos.x < 0 or ball_pos.x > 240 or ball_pos.y < 0 or ball_pos.y > 135:
			# Remove the "ball" node
			get_node("Ball").queue_free()
			# Spawn a new "ball" node
			spawn_ball()
			pass
