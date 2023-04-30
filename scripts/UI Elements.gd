extends Node2D

@export var leftscore = 0
@export var rightscore = 0
@export var leftgames = 0
@export var rightgames = 0
signal goal_splash_begin
var ball_name
var highlight_ball
var scoring_player 

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
				#TODO: Match win code
	else:
		goal_splash_begin.emit()
		rightscore += 1
		ball_name = "ScoreBall"+str(rightscore)
		scoring_player = get_node("Player Right UI")
		highlight_ball = scoring_player.get_node(ball_name)
		highlight_ball.modulate.a = 1
		if rightscore >= 10: # This is round win condition
			rightscore = 0
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
				#TODO: Match win code
