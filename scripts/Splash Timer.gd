extends Timer

var goal_splash

func _ready() -> void:
	# On load, double check the goal splash is hidden
	goal_splash = get_parent().get_node("Goal Splash")
	goal_splash.visible = false
	pass

func _on_ui_elements_goal_splash_begin():
	# But once the signal arrives to start the timer, then unhide this mamajama
	goal_splash.visible = true
	# And actually turn on the timer. Lol
	self.start()
	pass # Replace with function body.
