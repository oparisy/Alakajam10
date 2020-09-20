extends Control

onready var contents = $"Contents"

# Called once by main scene
func set_world_assets(arr):
	contents.worldAssetsPos = arr

# Called  by main scene at each frame
func set_player_position(pos):
	contents.playerWorldPosition = pos	
