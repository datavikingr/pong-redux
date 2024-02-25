extends Node2D

@export var ballExplosion : PackedScene # This is ball-kill particle effect
@export var eastbricks : PackedScene # Breakout bricks in front of the east goal
@export var westbricks : PackedScene # Breakout bricks in front of the west goal
var ball # Seek and Destroy!! (mostly, but not always)
var inner_court_size = Vector2(6, 16) #Top-left court bounds
var outer_court_size = Vector2(234, 129) #Bottom-right court bounds
var particle_color # goal explosion colors
var vfx # the goal explosion particle effects
var new_bricks # so I can use outside the if/then where I use it.
signal goal(player:String) #All one signal, baby!!
# TODO: I really need to free() the ballsplosions, but I'll figure that out later.

func _ready() -> void:
	ball = get_node("Ball") # Find that ball, for positional tracking

func _physics_process(_delta) -> void:
	if ball == null: #Then the ball's dead
		spawn_ball() #make a new one!!
		ball = get_node_or_null("Ball") # Set the variable
	elif ball != null: # We have a ball!
		var current_position = ball.get_position() # Find it!
		# See if the ball popped out of bounds
		if current_position.x > outer_court_size.x or current_position.y > outer_court_size.y or current_position.x < inner_court_size.x or current_position.y < inner_court_size.y:
			var ball_color = Color("#ffffff") # set the explosion color to white
			goal_explosion(ball_color, ball) # The ball explodes when it pops, now.
			ball.queue_free() # kill it
			ball = null # reset the ball variable most notably for the above

func spawn_ball() -> void:
	var ball_scene = load("res://tscn/ball.tscn") #load scene
	var new_ball = ball_scene.instantiate() # create the scene
	new_ball.name = "Ball" # Set the name of the new node to "Ball"
	new_ball.position = Vector2(outer_court_size.x/2, outer_court_size.y/2) # Center ball
	add_child(new_ball)# Attach it to the player layer
	ball = get_node("Ball") # Set the variable for use all over this script

func _on_goal_east(body:Node) -> void:
	particle_color = get_node("Player West").playercolor # Grab the player's color, so we can colorize the goal explosion
	if body.is_in_group("ball"):
## GOAL EXPLOSION
		goal_explosion(particle_color, body)
		set_physics_process(false) # Turn off ball spawning for the goal period
		body.queue_free() # kill that ball for respawn; called last to 'hide' the disappearance
		reset_bricks("East") # clear and re-spawn the bricks
		goal.emit("Left") # All one custom signall baby, heading over to UI Elements

func _on_goal_west(body:Node) -> void:
	particle_color = get_node("Player East").playercolor # Grab the player's color, so we can colorize the goal explosion
	if body.is_in_group("ball"):
## GOAL EXPLOSION
		goal_explosion(particle_color, body)
		set_physics_process(false) # Turn off ball spawning for the goal period
		body.queue_free() # kill that ball for respawn; called last to 'hide' the disappearance
		reset_bricks("West") # clear and re-spawn the bricks
		goal.emit("Right") # All one custom signall baby, heading over to UI Elements

func reset_bricks(half_of_field:String) -> void:
	var old_bricks_name = "Bricks "+half_of_field # Set the name string for which bricks-set it is
	var old_bricks = get_node(old_bricks_name) # get the node
	old_bricks.free() # kill it with prejudice
	if half_of_field == "East": # East side
		new_bricks = eastbricks.instantiate() # create new instance
	else: # West side
		new_bricks = westbricks.instantiate() # create new instance
	call_deferred("add_child", new_bricks) # after this frame, add it to the scene tree
	new_bricks.name = old_bricks_name # name it after the old set of bricks; there can only ever be one.

func goal_explosion(particlecolor, ballbody):
	vfx = ballExplosion.instantiate() # Create the Particle Effect
	vfx.one_shot = true # ensure it only happens once
	vfx.modulate = particlecolor #set the appropirate goal color
	vfx.position = ballbody.position # Set its position and rotation relative to the ball
	vfx.rotation = ballbody.rotation # Set its position and rotation relative to the ball
	vfx.emitting = true # Turn it on, so actually goes
	add_child(vfx) # add the vfx to the scene tree
	vfx.name = ("Explosion") # name it, so we can find it later

func _on_splash_timer_timeout():
	set_physics_process(true)# Turn ball spawn back on
	vfx = get_node("Explosion") # Find the explosion
	vfx.queue_free() # kill it, so it doesn't soak up memory

func _on_game_over():
	set_physics_process(false) # Turn ball spawning off
	ball = get_node("Ball") # Seek and Destroy, one final time
	ball.queue_free() #kill it
# Bring the players, up and out of the ball or wall space and over the text (52)
	get_node("Player West").set_z_index(53)
	get_node("Player West").set_collision_layer(2)
	get_node("Player East").set_z_index(53)
	get_node("Player East").set_collision_layer(2)
