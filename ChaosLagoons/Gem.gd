extends Spatial

signal gem_picked

func _on_Area_body_entered(body):
	if visible:
		emit_signal("gem_picked")
