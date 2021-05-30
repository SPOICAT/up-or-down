extends CanvasLayer

export(NodePath) var player_path
onready var player = get_node(player_path)

onready var saveconfig = get_node("/root/saveconfig")

func _ready():
	saveconfig.connect("saving_data", self, "display_saving_data")

func display_saving_data():
	$save_status/AnimationPlayer.play("saving_data_ani")

func _physics_process(_delta):
	display_lives()

func display_lives():
	$lives.text = str("LIVES: ", player.lives)
