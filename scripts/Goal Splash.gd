extends Node2D

func _on_splash_timer_timeout():
	self.visible = false # When the timer expires, this becomes invisible again
