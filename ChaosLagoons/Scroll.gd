extends Spatial

signal picked

var elapsed = 0;
var baseY

func _ready():
	baseY = translation.y

# Animate the scroll rotation and elevation
func _physics_process(delta):
	rotate_y(delta)

	translation.y = baseY + sin(elapsed) + 1
	
	elapsed += delta

func _on_Area_body_entered(_body):
	if !visible:
		# Do nothing if already picked
		return

	# We got collected; hide
	visible = false
	
	emit_signal('picked', self)	
