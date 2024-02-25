extends RigidBody2D

@onready var touchsfx = $TouchSFX
@export var speed = 125 # starting speed
@export var min_speed = 100 # pretty obvious
@export var max_speed = 250 # also self-evident
var is_playing_sfx = false #set the flag so we can play the sfx on first contact

func _ready():
	randomize() # random seed, baby, Roll them dice!
	set_linear_velocity(Vector2(speed, 0).rotated(deg_to_rad(randf_range(0, 360)))) # Let's see where they point!

func _physics_process(_delta):
	var current_speed = get_linear_velocity().length() # Check the current velocity magnitude
	var velocity = linear_velocity 
# Clamp speed based on min/max speeds
	if current_speed > max_speed: # If speed is higher than max, 
		velocity = velocity.normalized() * max_speed # normalize the speed toward the max
	if current_speed < min_speed: # If speed is higher than min, 
		velocity = velocity.normalized() * min_speed # normalize the speed toward the min
	set_linear_velocity(velocity) # Set the new velocity
# SFX
	if get_contact_count() > 0 and not is_playing_sfx: # Check for contact & not already playing
		is_playing_sfx = true # Turn on the flag, to ensure we don't call this multiple times at the same time
		touchsfx.play() # Play the sfx

func _on_touch_sfx_finished(): # Signal from the AudioPlayer
	is_playing_sfx = false # Turn the flag back off, so we can play the sfx again
