extends Node2D

@export var leftscore = 0
@export var rightscore = 0
signal goal_splash_begin
var ball_name
var highlight_ball
var scoring_player 

func _ready() -> void:
	pass

func _on_player_layer_goal(player):
	if player == "Left":
		print("left signal received")
		leftscore += 1
		print(leftscore)
		goal_splash_begin.emit()
		if leftscore >= 10:
			print("Left Wins")
		ball_name = "ScoreBall"+str(leftscore)
		scoring_player = get_node("Player Left UI")
		highlight_ball = scoring_player.get_node(ball_name)
		highlight_ball.modulate.a = 1
	else:
		print("right signal received")
		rightscore += 1
		print(rightscore)
		goal_splash_begin.emit()
		if rightscore >= 10:
			print("Right Wins")
		ball_name = "ScoreBall"+str(rightscore)
		scoring_player = get_node("Player Right UI")
		highlight_ball = scoring_player.get_node(ball_name)
		highlight_ball.modulate.a = 1
