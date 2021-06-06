extends Control

onready var level = preload("res://src/levels/LEVEL.tscn")

func _on_ExitGameButton_button_down():
	get_tree().quit()


func _on_RestartButton_button_down():
	GameEndC.game_ended = false
	saveconfig.delete_data()
	saveconfig.save_data()
	get_tree().change_scene_to(level)
