extends Area2D

onready var saveconfig = get_node("/root/saveconfig")

signal apply_effect
var applied : bool = false

onready var applied_collectables = get_node("/root/AppliedCollectables")

onready var player = get_parent().get_node(get_parent().player_path)

func _ready():
	if applied_collectables.nodes.has(self.name):
		applied = true
	connect("body_entered", self, "vanish_collectable")
	
	if applied: hide()

func vanish_collectable(body):
	if body.name == player.name and !applied:
		hide()
		emit_signal("apply_effect")
		applied = true
		applied_collectables.nodes.append(self.name)
		saveconfig.save_data()
