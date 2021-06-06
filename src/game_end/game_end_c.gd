extends Node

onready var game_end_scene = preload("res://src/game_end/GameEndScene.tscn")

var game_ended : bool = false

func _process(_delta):
	end_game_check()

func end_game_check():
	if game_ended:
		get_tree().change_scene_to(game_end_scene)
