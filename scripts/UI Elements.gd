extends Node2D

@export var leftscore = 0 # intra-round score for left player
@export var rightscore = 0 # intra-round score for right player, first to 10; points reset on new round. #TODO: New Round Placard
@export var leftgames = 0 # rounds won by left, first to 2
@export var rightgames = 0 # rounds won by right, first to 2
signal goal_splash_begin # Turn on the goal placard
signal game_over # The match is over, roll credits
var ball_name # Used to carry both "leftscore" balls AND "leftgames" balls, so we can represent score visually, with ease
var highlight_ball # That particular score's ball, specified. If Score = 6, Ball6. I couldn't have pulled this off a year ago.
var scoring_player # Whose score are we highlighting?
var win_ui # Win splash node; for visibility and high Z index
var player_win_text # Which Congratulations are we posting?
var player_layer # Communication channels reasons -appears unused

func win(player: String):
	game_over.emit() # Turning off the Ball repawn; connects to player layer #COMMO
	win_ui = get_node("Win Splash") # Grab the node
	win_ui.visible = true # Unhide it, for all the world to see
	if player == "Left": # Whose congrats are we rasing, furreal?
		player_win_text = win_ui.get_node("Control").get_node("LeftWin")
		player_win_text.visible = true
	else:
		player_win_text = win_ui.get_node("Control").get_node("RightWin")
		player_win_text.visible = true

func _on_player_layer_goal(player):
# double check no carry-over data from last score
	ball_name = null
	scoring_player = null
	highlight_ball = null
# Begin Score logic
	if player == "Left": 
		goal_splash_begin.emit() # Turns the goal splash timer on, which turns on the on-screen notification
		leftscore += 1 # add points
		ball_name = "ScoreBall"+str(leftscore) # Find the appropriate 'scoreball'
		scoring_player = get_node("Player Left UI") # Make sure we're looking at the correct set of UI elements
		highlight_ball = scoring_player.get_node(ball_name) # Actually grab the scoreball set two lines above
		highlight_ball.modulate.a = 1 # Highlight the bad boi, so the players can see the score
		if leftscore >= 10: # This is round win condition
# Reset scores for the round - left and right
			leftscore = 0
			rightscore = 0
# Undo any highlighting above
			for i in range(1,11):
				ball_name = "ScoreBall"+str(i)
				highlight_ball = scoring_player.get_node(ball_name)
				highlight_ball.modulate.a = 0.25
# This is how we're tracking rounds, and we're basically repeating the above ball highlighting
# But this time, its applied to the golden balls that indicate round score like a fighting game
			leftgames += 1
			ball_name = "RoundBall"+str(leftgames)
			highlight_ball = scoring_player.get_node(ball_name)
			highlight_ball.modulate.a = 1
			if leftgames >=2: # Then left fucking won the game then, didn't they?
				print("Left Player wins the match")
				win(player)
	else:
		goal_splash_begin.emit() # Turns the goal splash timer on, which turns on the on-screen notification
		rightscore += 1 # Add points
		ball_name = "ScoreBall"+str(rightscore) # Find the appropriate 'scoreball'
		scoring_player = get_node("Player Right UI") # Make sure we're looking at the correct set of UI elements
		highlight_ball = scoring_player.get_node(ball_name) # Actually grab the scoreball set two lines above
		highlight_ball.modulate.a = 1 # Highlight the bad boi, so the players can see the score
		if rightscore >= 10: # This is round win condition
# Reset scores for the round - left and right
			rightscore = 0
			leftscore = 0
# Undo any highlighting above
			for i in range(1,11):
				ball_name = "ScoreBall"+str(i)
				highlight_ball = scoring_player.get_node(ball_name)
				highlight_ball.modulate.a = 0.25
# This is how we're tracking rounds, and we're basically repeating the above ball highlighting
# But this time, its applied to the golden balls that indicate round score like a fighting game
			rightgames += 1
			ball_name = "RoundBall"+str(rightgames)
			highlight_ball = scoring_player.get_node(ball_name)
			highlight_ball.modulate.a = 1
			if rightgames >=2: # Then right fucking won the game then, didn't they?
				print("Right Player wins the match")
				win(player)
