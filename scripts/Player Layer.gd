extends Node2D

var ball
var inner_court_size = Vector2(6, 16) #Top-left court bounds
var outer_court_size = Vector2(234, 129) #Bottom-right court bounds
signal goal(player:String)

func _ready() -> void:
	ball = get_node("Ball")

func _physics_process(_delta) -> void:
	if ball == null:
		spawn_ball()
		ball = get_node_or_null("Ball")
	elif ball != null:
		var current_position = ball.get_position()
		if current_position.x > outer_court_size.x or current_position.y > outer_court_size.y or current_position.x < inner_court_size.x or current_position.y < inner_court_size.y:
			ball.queue_free()
			ball = null

func spawn_ball() -> void:
	var ball_scene = load("res://tscn/ball.tscn")
	var new_ball = ball_scene.instantiate()
	new_ball.name = "Ball"  # Set the name of the new node to "Ball"
	new_ball.position = Vector2(outer_court_size.x/2, outer_court_size.y/2)
	add_child(new_ball)
	ball = get_node("Ball")  # Ensure that the new node can be accessed with % notation

func _on_ball_tree_exited() -> void:
	ball = null

func _on_goal_east(body:Node) -> void:
	#print("contact east ", body)
	if body.is_in_group("ball"):
		print("GOAL! Player Left Scored!")
		goal.emit("Left")
	pass # Replace with function body.

func _on_goal_west(body:Node) -> void:
	#print("contact west ", body)
	if body.is_in_group("ball"):
		print("GOAL! Player Right Scored!")
		goal.emit("Right")
	pass # Replace with function body.
