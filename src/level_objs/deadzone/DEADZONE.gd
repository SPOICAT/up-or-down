extends Area2D

func _on_DEADZONE_body_entered(body):
	if body.name == "PLAYER":
		body.dead = true
