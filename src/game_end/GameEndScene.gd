extends Control

onready var level = preload("res://src/levels/LEVEL.tscn")

func _on_ExitGameButton_button_down():
	get_tree().quit()

func _on_RestartButton_button_down():
	GameEndC.game_ended = false
	var dir = Directory.new()
	dir.remove(saveconfig.file_name)
	get_tree().change_scene_to(level)
	saveconfig.will_reset_player_pos = true
