extends Camera2D

export (float, 0,1) var follow_speed = 0.1
export (NodePath) var player_path
onready var player = get_node(player_path)

export (float, 0,1) var acceleration
export (float, 0,1) var friction

var normal_zoom = 3
var max_zoom = 3.5
var min_zoom = 2.5
var cur_zoom = 3

func _ready():
	rotating = true
	cur_zoom = normal_zoom

func _physics_process(_delta):
	cur_zoom = clamp(cur_zoom, min_zoom, max_zoom)
	zoom = Vector2(cur_zoom, cur_zoom)
	
	transform = transform.interpolate_with(player.transform, follow_speed)
	
	if player.is_moving:
		cur_zoom += 0.01
	elif player.is_jumping:
		cur_zoom += 0.02
	else:
		cur_zoom -= 0.01
