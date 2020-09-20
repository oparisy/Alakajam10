extends Spatial

# Instanciate rocks on startup
# See https://www.youtube.com/watch?v=0WOqJy3lot4
onready var rockModel = preload("res://RockModel.tscn")

# Insertion point for rock instances
onready var baseNode = get_node("FakeStaticScene")

# Used to communicate with minimap
onready var minimap = get_node("Minimap")

# Used to get player informations
onready var playerBody = get_node("PlayerBody")

# Used to get static assets informations
onready var worldAssets = get_node("WorldAssets")

# Array of 2D coords (taken from handplaced nodes inspector)
var coords = [] # [[4.671, -16.02], [-12.748, -9.396], [12.842, -3.447]]

# Called when the node enters the scene tree for the first time.
func _ready():
	# Not used anymore
	for coord in coords:
		var rock = rockModel.instance()
		rock.translation = Vector3(coord[0], 0, coord[1])
		add_child_below_node(baseNode, rock)
		
	# Send fixed assets coordinates once to minimap
	minimap.set_world_assets(worldAssets.get_assets_positions())

func _process(_delta):
	# Fetch player position, send it to minimap
	# TODO Use a signal instead maybe
	var playerPos = playerBody.get_position()
	minimap.set_player_position(playerPos)
