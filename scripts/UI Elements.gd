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
	# Turning off the Ball repawn; connects to player layer #COMMO
	game_over.emit()
	# Grab the node
	win_ui = get_node("Win Splash")
	# Unhide it, for all the world to see
	win_ui.visible = true
	# Whose congrats are we rasing, furreal?
	if player == "Left":
		player_win_text = win_ui.get_node("Control").get_node("LeftWin")
		player_win_text.visible = true
	else:
		player_win_text = win_ui.get_node("Control").get_node("RightWin")
		player_win_text.visible = true

func _ready() -> void:
	pass

func _on_player_layer_goal(player):
	ball_name = null
	scoring_player = null
	highlight_ball = null
	if player == "Left":
		goal_splash_begin.emit()
		leftscore += 1
		ball_name = "ScoreBall"+str(leftscore)
		scoring_player = get_node("Player Left UI")
		highlight_ball = scoring_player.get_node(ball_name)
		highlight_ball.modulate.a = 1
		if leftscore >= 10: # This is round win condition
			leftscore = 0
			rightscore = 0
			for i in range(1,11):
				ball_name = "ScoreBall"+str(i)
				highlight_ball = scoring_player.get_node(ball_name)
				highlight_ball.modulate.a = 0.25
			leftgames += 1
			ball_name = "RoundBall"+str(leftgames)
			highlight_ball = scoring_player.get_node(ball_name)
			highlight_ball.modulate.a = 1
			if leftgames >=2:
				print("Left Player wins the match")
				win(player)
	else:
		goal_splash_begin.emit()
		rightscore += 1
		ball_name = "ScoreBall"+str(rightscore)
		scoring_player = get_node("Player Right UI")
		highlight_ball = scoring_player.get_node(ball_name)
		highlight_ball.modulate.a = 1
		if rightscore >= 10: # This is round win condition
			rightscore = 0
			leftscore = 0
			for i in range(1,11):
				ball_name = "ScoreBall"+str(i)
				highlight_ball = scoring_player.get_node(ball_name)
				highlight_ball.modulate.a = 0.25
			rightgames += 1
			ball_name = "RoundBall"+str(rightgames)
			highlight_ball = scoring_player.get_node(ball_name)
			highlight_ball.modulate.a = 1
			if rightgames >=2:
				print("Right Player wins the match")
				win(player)
