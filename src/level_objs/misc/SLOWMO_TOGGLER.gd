extends Area2D

onready var player = get_parent().get_node(get_parent().player_path)

export(float) var slow_motion = 0.25

func _on_SLOWMO_TOGGLER_body_entered(body):
	print(player)
	if body.name == "PLAYER" and Engine.time_scale == 1:
		Engine.time_scale = slow_motion
		player.speed = player.speed / slow_motion
	elif body.name == "PLAYER" and Engine.time_scale == 0.5:
		Engine.time_scale = 1
		player.speed = player.speed * slow_motion

