extends Node2D
class_name FallingTilesContainer

export(NodePath) var player_path
onready var player = get_node(player_path)

var tile_default_positions = []

func _ready():
	for tiles in get_children():
		tile_default_positions += [tiles.global_transform.origin]
		
	player.connect("reloaded_checkpoint", self, "reset_all_tiles")
	

func reset_all_tiles():
	for tiles in get_children():
		tiles.reset()
