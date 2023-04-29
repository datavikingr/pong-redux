extends RigidBody2D

var ball
@export var speed = 150

func _physics_process(_delta):
	var input_direction = Vector2.ZERO
	input_direction = Vector2(
		Input.get_action_strength("playerleft_right") - Input.get_action_strength("playerleft_left"),
		Input.get_action_strength("playerleft_down") - Input.get_action_strength("playerleft_up")
	)
	linear_velocity = input_direction * speed
	rotation = 0
	var killswitch = Input.get_action_strength("kill")
	if killswitch > 0:
		print("KILL")
		ball = get_node_or_null("../Ball")
		if ball != null:
			ball.queue_free()

func _on_body_entered(_body):
	angular_velocity = 0
