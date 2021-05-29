extends Camera2D

export (float, 0,1) var follow_speed = 0.1
export (NodePath) var player_path
onready var player = get_node(player_path)

func _ready():
	rotating = true

func _physics_process(_delta):
	transform = transform.interpolate_with(player.transform, follow_speed)
	if player.is_jumping and zoom < Vector2(3,3):
		zoom += Vector2(0.01, 0.01)
	elif zoom > Vector2(2, 2):
		zoom -= Vector2(0.01, 0.01)
