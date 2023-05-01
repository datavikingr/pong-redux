extends RigidBody2D

#var ball #### DEBUGGING FEATURE - JUST DESTROY ####
@export var speed = 150 # Self evident & pretty quick, too

func _physics_process(_delta):
	# Normalize from previous cycle, same as the cal lab: zero before every measurement.
	var input_direction = Vector2.ZERO
	# Get the input info, set in project settings > Input Mapping. Type in text box, then click it's plus in the menu
	input_direction = Vector2(
		# Right is postive. This does cause cancel, from multiple opposite inputs (keyboard)
		Input.get_action_strength("playerleft_right") - Input.get_action_strength("playerleft_left"),
		# Down is postive, for some bloody reason. This does cause cancel, from multiple opposite inputs (keyboard)
		Input.get_action_strength("playerleft_down") - Input.get_action_strength("playerleft_up")
	)
	# Make go zoom
	linear_velocity = input_direction * speed
	# But don't let it spin, yet
	rotation = 0

	#### DEBUGGING FEATURE - JUST DESTROY ####
	#var killswitch = Input.get_action_strength("kill")
	#if killswitch > 0:
	#	print("KILL")
	#	ball = get_node_or_null("../Ball")
	##	This allows to overcome over-pressing, and not spawn-camp the new ball.
	#	if ball != null:
	#		ball.queue_free()

func _on_body_entered(_body):
	# No really, don't bloody rotate unless the player says so
	angular_velocity = 0
