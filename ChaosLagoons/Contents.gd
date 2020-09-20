extends Control


# Set by root node
var playerWorldPosition = Vector3.ZERO

# Drawing zone size
var size := Vector2(200, 200)
var center = size * 0.5
var scaling = .2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# We want to redraw at each frame
	update()

func _draw():
	# Draw player position
	var playerMapPos = world_to_map(playerWorldPosition)
	draw_rect(Rect2(playerMapPos, Vector2(5, 5)), Color.greenyellow, true)

func world_to_map(pos : Vector3) -> Vector2:
	# Basic linear conversion
	var mpos = center + Vector2(pos.x, pos.z) * scaling

	# Ensure we stay in the minimap
	var clamped = Vector2(clamp(mpos.x, 0, size.x), clamp(mpos.y, 0, size.y))
	return clamped

