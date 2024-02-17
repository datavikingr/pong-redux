extends RigidBody2D

@export var speed = 200

func _physics_process(_delta):
	var input_direction = Vector2.ZERO
	input_direction = Vector2(
		Input.get_action_strength("right2") - Input.get_action_strength("left2"),
		Input.get_action_strength("down2") - Input.get_action_strength("up2")
	)

	linear_velocity = input_direction * speed
	rotation = 0

func _on_body_entered(_body):
	angular_velocity = 0
