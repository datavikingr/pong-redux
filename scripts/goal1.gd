extends CollisionPolygon2D

var ball = null

func _ready():
	while ball == null:
		ball = get_node_or_null("/root/Main/Board/Ball")
		await get_tree().process_frame
	print(ball)
	ball.body_entered.connect(_on_body_Ball_entered)
	print("what the fuck")

func _on_body_Ball_entered():
	print("GOAL!!!")
