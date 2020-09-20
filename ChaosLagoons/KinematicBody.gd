extends KinematicBody

# This script is responsible for animating the player model

# No gravity, we float...

export var speed = 0.4
export var rot_speed = 1.3
export var max_speed = 25
export var drag = 0.7

var max_speed_squared = max_speed * max_speed

# This will maintain player velocity
var velocity = Vector3.ZERO


func _physics_process(delta):
	# Get input from player, alter velocity accordingly
	get_input(delta)

	# Move player model, taking collisions into account
	velocity = move_and_slide(velocity, Vector3.UP)

# See https://www.youtube.com/watch?v=rOA8i_clm1Y
func get_input(delta):
	var velocity_changed = false
	if Input.is_action_pressed("forward"):
		# "Local forward vector"
		velocity += -transform.basis.z	* speed
		velocity_changed = true
	if Input.is_action_pressed("backward"):
		velocity += transform.basis.z	* speed
		velocity_changed = true
	if Input.is_action_pressed("rotate_left"):
		rotate_y(rot_speed * delta)
	if Input.is_action_pressed("rotate_right"):
		rotate_y(-rot_speed * delta)

	if velocity_changed:
		var currentSpeedSqr = velocity.length_squared()
		if currentSpeedSqr > max_speed_squared:
			# Cap max speed while keeping direction
			velocity = velocity.normalized() * max_speed
	else:
		# The ship will slow other time
		velocity *= 1 - (drag * delta)
