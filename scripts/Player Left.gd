extends RigidBody2D

@export var speed: int  = 150 # Self evident & pretty quick, too
@export var playercolor: Color = Color(1, .056, .502) # #c1236f is a vaporwave pink
@export var accumulated_rotation: float = 0.0 #starting setting
@export var rotation_speed: float = 10.0  # Adjust as needed

func _ready() -> void:
	self.modulate = playercolor

func _on_body_entered(_body) -> void:
	angular_velocity = 0 # No really, don't bloody rotate unless the player says so

func _physics_process(delta) -> void:
	player_movement()
	player_rotation(delta)

func player_movement() -> void:
	var input_direction = Vector2.ZERO # Normalize from previous cycle, same as the cal lab: zero before every measurement.
	input_direction = Vector2( # Get the input info, set in project settings > Input Mapping. Type in text box, then click it's plus in the menu
		Input.get_action_strength("playerleft_right") - Input.get_action_strength("playerleft_left"), # Right is postive. This does cause cancel, from multiple opposite inputs (keyboard)
		Input.get_action_strength("playerleft_down") - Input.get_action_strength("playerleft_up") # Down is postive, for some bloody reason. This does cause cancel, from multiple opposite inputs (keyboard)
	)
	linear_velocity = input_direction * speed # Make go zoom
	#rotation = 0 # But don't let it spin, yet

func player_rotation(delta) -> void:
	var rotation_direction = Input.get_action_strength("playerleft_cw") - Input.get_action_strength("playerleft_ccw") #TODO: We'll see if this needs flipped
	var rotation_angle = rotation_direction * rotation_speed * delta # Calculate rotation angle based on direction and rotation speed
	accumulated_rotation += rotation_angle
	rotation += accumulated_rotation # Apply rotation 
