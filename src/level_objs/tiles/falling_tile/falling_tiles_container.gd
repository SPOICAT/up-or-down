extends Node2D
class_name FallingTilesContainer

export(NodePath) var player_path
onready var player = get_node(player_path)

func _ready():
	player.connect("reloaded_checkpoint", self, "reset_all_tiles")
	

func reset_all_tiles():
	for tiles in get_children():
		tiles.reset()
