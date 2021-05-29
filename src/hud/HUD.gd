extends CanvasLayer

onready var saveconfig = get_node("/root/saveconfig")

func _ready():
	saveconfig.connect("saving_data", self, "display_saving_data")

func display_saving_data():
	$save_status/AnimationPlayer.play("saving_data_ani")
