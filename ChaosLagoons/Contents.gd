extends Control

# Easier to tune in the GUI
export var playerColor := Color.greenyellow
export var rockColor:Color = Color("00f3ff")
export var scrollColor:Color = Color("ff0000")
export var gemColor:Color = Color("ff00ff")


# Set by root node
var playerWorldPosition = Vector3.ZERO

# Elements are [2D pos, revealed, kind, rank]
var worldAssets = []

# Keep track of picked scrolls
var picked := {}

# Drawing zone size
var size := Vector2(200, 200)
var center = size * 0.5

# Those help in finetuning minimap "filling"
var scaling = .25
var offset = Vector2(-30, 15)

# Gem-related informations
var gemRevealed = false
var gemMapPos = Vector2.ZERO

# Used for gem dot animation purpose
var elapsed = 0


func setWorldAssetsPos(arr, kind:String):
	var rank:int = 0
	for p in arr:
		var entry = [world_to_map(p), false, kind, rank]
		worldAssets.append(entry)
		rank += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	# We want to redraw at each frame
	update()

func _physics_process(delta):
	elapsed += delta

func _draw():
	# Compute player position
	var playerMapPos = world_to_map(playerWorldPosition)
	
	# Draw all static items
	for item in worldAssets:
		var itemMapPos = item[0]
		var revealed = item[1]
		var kind = item[2]
		var rank = item[3]

		# Compute dot color
		var color
		if kind == "rock":
			color = rockColor
			color.a = 1 if revealed else compute_dist_coef(itemMapPos, playerMapPos)
		if kind == "scroll":
			color = scrollColor
			color.a = 0 if picked.has(rank) else (1 if revealed else compute_dist_coef(itemMapPos, playerMapPos))

		draw_rect(Rect2(itemMapPos, Vector2(2, 3)), color, true)

	# Show the gem
	if gemRevealed:
		var pulse = sin(elapsed)
		var dim = Vector2(4,4)*(1+pulse)
		var pos = gemMapPos - dim*0.5
		draw_rect(Rect2(pos, dim), gemColor, true)

	# Draw player last (cleaner)
	draw_rect(Rect2(playerMapPos, Vector2(5, 5)), playerColor, true)


# Compute a distance from player related coefficient
func compute_dist_coef(itemMapPos, playerMapPos):
	var mapDistSqr = itemMapPos.distance_squared_to(playerMapPos)
	var distCoeff = 100 / (mapDistSqr + 1)
	return distCoeff


func world_to_map(pos : Vector3) -> Vector2:
	# Basic linear conversion
	var mpos = center + Vector2(pos.x, pos.z) * scaling + offset

	# Ensure we stay in the minimap
	var clamped = Vector2(clamp(mpos.x, 0, size.x), clamp(mpos.y, 0, size.y))
	return clamped

# Called when a map scroll is collected
func revealPiece(which:int):
	# Keep track of this scroll being picked
	picked[which] = true
	
	# Compute zone limits (in minimap coordinates)
	var x:int = which % 3
	var y:int = which / 3
	var minx = x * size.x / 3
	var maxx = (x+1) * size.x / 3
	var miny = y * size.y / 3
	var maxy = (y+1) * size.y / 3

	# Find items in this zone, update their visibility state
	for rock in worldAssets:
		var rx = rock[0].x
		var ry = rock[0].y
		var isIn = minx <= rx && rx < maxx && miny <= ry && ry < maxy
		rock[1] = rock[1] || isIn


# Called when the final gem is revealed
func revealGem(worldPos):
	gemRevealed = true
	gemMapPos = world_to_map(worldPos)
