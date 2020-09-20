extends Spatial

signal scroll_picked

func _ready():
	# Programmatically connect to children "picked" signal
	for c in get_children():
		c.connect("picked", self, "on_scroll_picked")

# Provide scrolls positions to caller
func get_assets_positions():
	var result = []
	for c in get_children():
		result.append(c.translation)
	return result


func on_scroll_picked(which):
	# Emit a number between 0 and 8 to signal which scroll was picked
	emit_signal("scroll_picked", which.get_index())
