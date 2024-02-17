extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var ui_color = %PlayerRight.playercolor
	# Iterate over children nodes named "ScoreballX" so we can change their color; Changing golden balls is sketchy
	for ball in range(1, 11):
		# Find the child
		var ball_name = "ScoreBall"+str(ball)
		# Collect the child
		var scoreball = get_node(ball_name)
		#Double check it's not a nothing node
		if scoreball != null:
			# Change that scoreball's color
			scoreball.self_modulate = ui_color
