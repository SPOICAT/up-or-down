extends Area2D

var applied : bool = false

onready var hud = get_parent().get_node(get_parent().hud)
onready var player = get_parent().get_node(get_parent().player_path)

export(float) var slow_motion = 0.25
export(float) var slow_speed = 0.25
export(float) var slow_gravity = 1
export(float) var slow_jump_speed = 0.25

func reset():
	applied = false

func _ready():
	player.connect("reloaded_checkpoint", self, "reset")

func _on_SLOWMO_TOGGLER_body_entered(body):
	if body.name == "PLAYER" and !applied:
		if Engine.time_scale == 1:
			print(0)
			Engine.time_scale = slow_motion
			player.speed = player.speed / slow_motion
			player.gravity = player.gravity / slow_gravity
			player.jump_speed = player.jump_speed / slow_jump_speed
			hud.trigger_slow_motion_effect()
		elif Engine.time_scale == slow_motion:
			print(1)
			Engine.time_scale = 1
			player.speed = player.init_speed
			player.gravity = player.init_gravity
			player.jump_speed = player.init_jump_speed
			hud.off_slow_motion_effect()
		applied = true

