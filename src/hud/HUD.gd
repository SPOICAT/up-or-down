extends CanvasLayer

export(NodePath) var player_path
onready var player = get_node(player_path)

onready var saveconfig = get_node("/root/saveconfig")

func reset_all_effects():
	off_slow_motion_effect()

func _ready():
	saveconfig.connect("saving_data", self, "display_saving_data")
	player.connect("reloaded_checkpoint", self, "reset_all_effects")

func display_saving_data():
	$save_status/AnimationPlayer.play("saving_data_ani")

func _physics_process(_delta):
	display_lives()

func display_lives():
	$lives.text = str("LIVES: ", player.lives)

func trigger_slow_motion_effect():
	$VISUAL_EFFECTS/slow_motion_effect/AnimationPlayer.play("trigger")

func off_slow_motion_effect():
	$VISUAL_EFFECTS/slow_motion_effect/AnimationPlayer.play("off")
