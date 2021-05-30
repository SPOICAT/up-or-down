extends Line2D

export(NodePath) var player_path
onready var player = get_node(player_path)

func _ready():
	set_as_toplevel(true)
	player.connect("go_trail", self, 'create_trails')
	player.connect("stop_trail", self, "clear_trails")

func create_trails():
	add_point(player.global_transform.origin)

func clear_trails():
	clear_points()

func _physics_process(delta):
	
	if points.size() > 5:
		clear_points()
	
