extends RigidBody2D

@export var speed = 200

func _physics_process(_delta):
    var input_direction = Vector2.ZERO
    input_direction = Vector2(
        Input.get_action_strength("right") - Input.get_action_strength("left"),
        Input.get_action_strength("down") - Input.get_action_strength("up")
    )

    linear_velocity = input_direction * speed
    rotation = 0

func _on_body_entered(_body):
    angular_velocity = 0