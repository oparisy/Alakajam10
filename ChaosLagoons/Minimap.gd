extends Control

onready var contents = $"Contents"

# Called once by main scene
func set_world_assets(arr, kind:String):
	contents.setWorldAssetsPos(arr, kind)

# Called  by main scene at each frame
func set_player_position(pos):
	contents.playerWorldPosition = pos	

# Called when a map scroll is collected
func revealPiece(which:int):
	contents.revealPiece(which)

# Called when the gem is revealed
func revealGem(worldPos):
	contents.revealGem(worldPos)

