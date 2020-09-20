extends Spatial

# Provide rock positions to caller
func get_assets_positions():
	var result = []
	for c in get_children():
		result.append(c.translation)
	return result
