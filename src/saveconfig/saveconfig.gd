extends Node2D

const file_name = "user://savegame.save"

var data = {}

signal saving_data

onready var player = null
onready var applied_collectables = get_node("../AppliedCollectables")

func start():
	if load_data().has("lives"):
		if load_data()["lives"] > 0:
			apply_loaded_data()
		
func delete_data():
	data = {}
	applied_collectables.nodes.clear()
	save_data()

func save_data():
	if player != null:
		if player.current_checkpoint != null:
			data["current_checkpoint"] = player.current_checkpoint.transform
		if player.lives != null:
			data["lives"] = player.lives
	data["applied_collectables"] = applied_collectables.nodes
	data["game_ended"] = GameEndC.game_ended
	
	var f = File.new()
	f.open(file_name, f.WRITE)
	emit_signal("saving_data")
	f.store_var(data)
	f.close()
	
func load_data():
	var f = File.new()
	if f.file_exists(file_name):
		f.open(file_name, f.READ)
		var loaded_data = f.get_var()
		return loaded_data
		f.close()
	else:
		save_data()
		return data
	
func apply_loaded_data():
	if load_data().empty() and player.current_checkpoint != null:
		data = {
			"current_checkpoint": player.current_checkpoint.transform,
			"lives": player.lives,
			"applied_collectables": []
		}
	else:
		data = load_data()
	if data.has("current_checkpoint"):
		player.transform = data["current_checkpoint"]
	if data.has("lives"):
		player.lives = data["lives"]
	if data.has("applied_collectables"):
		applied_collectables.nodes = data["applied_collectables"]
	if data.has("game_ended"):
		GameEndC.game_ended = data["game_ended"]
