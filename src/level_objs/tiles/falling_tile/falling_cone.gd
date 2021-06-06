extends "res://src/level_objs/tiles/falling_tile/falling_tile.gd"

func _on_trigger_body_entered(body):
	if body.name == "PLAYER":
		emit_signal("start")
