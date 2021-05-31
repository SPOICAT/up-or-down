extends "res://src/level_objs/collectables/Collectables.gd"

func _ready():
	connect("apply_effect", self, "lives_up")

func lives_up(by = 1):
	player.lives += by
