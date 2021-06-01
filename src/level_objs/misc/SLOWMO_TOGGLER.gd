extends Area2D

onready var player = get_parent().get_node(get_parent().player_path)

export(float) var slow_motion = 0.25
export(float) var slow_speed = 0.25
export(float) var slow_gravity = 1
export(float) var slow_jump_speed = 0.25

func _on_SLOWMO_TOGGLER_body_entered(body):
	print(player)
	if body.name == "PLAYER" and Engine.time_scale == 1:
		Engine.time_scale = slow_motion
		player.speed = player.speed / slow_motion
		player.gravity = player.gravity / slow_gravity
		player.jump_speed = player.jump_speed / slow_jump_speed
	elif body.name == "PLAYER" and Engine.time_scale == 0.5:
		Engine.time_scale = 1
		player.speed = player.init_speed
		player.gravity = player.init_gravity
		player.jump_speed = player.init_jump_speed

