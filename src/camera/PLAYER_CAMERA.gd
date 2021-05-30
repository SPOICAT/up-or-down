extends Camera2D

export (float, 0,1) var follow_speed = 0.1
export (NodePath) var player_path
onready var player = get_node(player_path)

func _ready():
	rotating = true
	zoom = Vector2(3,3)

func _physics_process(_delta):
	transform = transform.interpolate_with(player.transform, follow_speed)
	if player.is_jumping and zoom < Vector2(3.5,3.5):
		zoom += Vector2(0.02, 0.02)
	elif zoom > Vector2(3, 3):
		zoom -= Vector2(0.02, 0.02)
