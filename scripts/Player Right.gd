extends RigidBody2D

@export var speed = 150

func _physics_process(_delta):
    var input_direction = Vector2.ZERO
    input_direction = Vector2(
        Input.get_action_strength("playerright_right") - Input.get_action_strength("playerright_left"),
        Input.get_action_strength("playerright_down") - Input.get_action_strength("playerright_up")
    )

    linear_velocity = input_direction * speed
    rotation = 0

func _on_body_entered(_body):
    angular_velocity = 0