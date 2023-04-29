extends Node2D

var ball
var court_size = Vector2(240, 135) # the size of the court

func _ready():
	ball = get_node("Ball")

func _physics_process(_delta):
	if is_out_of_bounds():
		spawn_ball()  # add the new ball to the scene tree
		ball.queue_free() # deletes this ball from the scene

func spawn_ball():
	var ball_scene = load("res://tscn/ball.tscn")
	var new_ball = ball_scene.instantiate()
	new_ball.name = "Ball"  # Set the name of the new node to "Ball"
	new_ball.position = Vector2(court_size.x/2, court_size.y/2)
	add_child(new_ball)
	ball = get_node("Ball")  # Ensure that the new node can be accessed with % notation

func is_out_of_bounds() -> bool:
	while ball == null:
		spawn_ball()
		ball = get_node("Ball")
	var current_position = ball.get_position()
	return current_position.x > court_size.x or current_position.y > court_size.y or current_position.x < 0 or current_position.y < 0

func _on_ball_tree_exited():
	ball = null

func _on_goal_line_west_body_entered(body):
	print("contact")
	if body.is_in_group("ball"): #Check for player or ball collision
		print("GOAL BY Right Player")
	pass # Replace with function body.


func _on_goal_line_east_body_entered(body):
	print("contact")
	if body.is_in_group("ball"): #Check for player or ball collision
		print("GOAL BY Left Player")
	pass # Replace with function body.
