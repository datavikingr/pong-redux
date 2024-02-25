extends Timer

var goal_splash

func _ready() -> void:
	goal_splash = get_parent().get_node("Goal Splash") # On load, double check the goal splash is hidden
	goal_splash.visible = false

func _on_ui_elements_goal_splash_begin():
	goal_splash.visible = true # But once the signal arrives to start the timer, then unhide this mamajama
	self.start() # And actually turn on the timer. Lol