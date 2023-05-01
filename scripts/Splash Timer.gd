extends Timer

var goal_splash

func _ready() -> void:
	goal_splash = get_parent().get_node("Goal Splash")
	goal_splash.visible = false
	pass

func _on_ui_elements_goal_splash_begin():
	goal_splash.visible = true
	self.start()
	pass # Replace with function body.
