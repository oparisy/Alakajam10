extends Control

onready var contents = $"Background/Contents"

# Called  by main scene
func set_player_position(pos):
	contents.playerWorldPosition = pos	
