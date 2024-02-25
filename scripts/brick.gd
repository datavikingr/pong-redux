extends RigidBody2D

# The Old method, I'm not destroying this.
signal deathtimer()

func _ready():
	self.body_entered.connect(_on_body_entered) #connect("body_entered", selfobj) # Connect the "body_entered" signal to the "_on_body_entered" method within the same object

func _on_body_entered(body):
	if body.name == "Ball":
		deathtimer.emit()

func _on_timer_timeout():
	self.queue_free()  # Destroy the brick