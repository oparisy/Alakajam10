extends Control

# Easier to tune in the GUI
export var playerColor := Color.greenyellow
export var rockColor:Color = Color("00f3ff")

# Set by root node
var playerWorldPosition = Vector3.ZERO
var worldAssetsPos = []

# Drawing zone size
var size := Vector2(200, 200)
var center = size * 0.5

# Those help in finetuning minimap "filling"
var scaling = .30
var offset = Vector2(-30, 15)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# We want to redraw at each frame
	update()

func _draw():
	# Compute player position
	var playerMapPos = world_to_map(playerWorldPosition)
	
	# Draw all rocks
	for rockWorldPos in worldAssetsPos:
		# TODO Note that this could be computed once at startup
		var rockMapPos = world_to_map(rockWorldPos)
		
		# Compute a distance from player
		var mapDistSqr = rockMapPos.distance_squared_to(playerMapPos)
		var distCoeff = 100 / (mapDistSqr + 1)
		var color = rockColor
		color.a = distCoeff

		draw_rect(Rect2(rockMapPos, Vector2(2, 3)), color, true)

	# Draw player last (cleaner)
	draw_rect(Rect2(playerMapPos, Vector2(5, 5)), playerColor, true)


func world_to_map(pos : Vector3) -> Vector2:
	# Basic linear conversion
	var mpos = center + Vector2(pos.x, pos.z) * scaling + offset

	# Ensure we stay in the minimap
	var clamped = Vector2(clamp(mpos.x, 0, size.x), clamp(mpos.y, 0, size.y))
	return clamped

