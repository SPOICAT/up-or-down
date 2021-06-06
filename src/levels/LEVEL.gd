extends Node2D

export(NodePath) var player_path
onready var player = get_node(player_path)

var starting_pos = Vector2(376, 252)

func _ready():
	player.starting_pos = starting_pos
	if saveconfig.will_reset_player_pos:
		saveconfig.reset_player_pos()
