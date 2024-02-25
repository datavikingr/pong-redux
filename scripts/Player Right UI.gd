extends Node2D

func _ready():
	var ui_color = %"Player East".playercolor
	for ball in range(1, 11): # Iterate over children nodes named "ScoreballX" so we can change their color; Changing golden balls is sketchy
		var ball_name = "ScoreBall"+str(ball) # Find the child
		var scoreball = get_node(ball_name) # Collect the child
		if scoreball != null: # Double check it's not a nothing node
			scoreball.self_modulate = ui_color # Change that scoreball's color
