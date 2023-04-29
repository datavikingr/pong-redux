extends Node2D

var court_size = Vector2(240, 135)  # the size of the court

func is_out_of_bounds() -> bool:
	var current_position = get_position()
	return current_position.x > court_size.x or current_position.y > court_size.y or current_position.x < 0 or current_position.y < 0

func _physics_process(_delta):
	if is_out_of_bounds():
		var board_node = get_node("Player Layer")
		board_node.spawn_ball()  # add the new ball to the scene tree
		queue_free() # deletes this ball from the scene
