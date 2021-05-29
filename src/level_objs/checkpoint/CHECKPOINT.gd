extends Area2D

onready var saveconfig = get_node("/root/saveconfig")

onready var player_loc = get_parent().player_path
onready var player = get_parent().get_node(player_loc)

func _on_CHECKPOINT_body_entered(body):
	if body.name == "PLAYER":
		player.current_checkpoint = self
		saveconfig.save_data()
	
func _on_CHECKPOINT_body_exited(body):
	if body.name == "PLAYER":
		player.current_checkpoint = null
