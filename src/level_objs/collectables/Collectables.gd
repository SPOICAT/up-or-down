extends Area2D

onready var saveconfig = get_node("/root/saveconfig")

signal apply_effect
var applied : bool = false

onready var player = get_parent().get_node(get_parent().player_path)

func _ready():
	connect("body_entered", self, "vanish_collectable")

func vanish_collectable(body):
	if body.name == player.name and !applied:
		hide()
		emit_signal("apply_effect")
		applied = true
		saveconfig.save_data()
