extends RigidBody2D

@export var speed = 150 # Self evident & pretty quick, too
@export var playercolor: Color = Color(0.4, 0.133, 0.8)

func _ready():
	self.modulate = playercolor

func _physics_process(_delta):
	# Normalize from previous cycle, same as the cal lab: zero before every measurement.
	var input_direction = Vector2.ZERO
	# Get the input info, set in project settings > Input Mapping. Type in text box, then click it's plus in the menu
	input_direction = Vector2(
		# Right is postive. This does cause cancel, from multiple opposite inputs (keyboard)
		Input.get_action_strength("playerright_right") - Input.get_action_strength("playerright_left"),
		# Down is postive, for some bloody reason. This does cause cancel, from multiple opposite inputs (keyboard)
		Input.get_action_strength("playerright_down") - Input.get_action_strength("playerright_up")
	)
	# Make go zoom
	linear_velocity = input_direction * speed
	# But don't let it spin, yet
	rotation = 0

func _on_body_entered(_body):
	# No really, don't bloody rotate unless the player says so
	angular_velocity = 0
