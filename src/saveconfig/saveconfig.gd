extends Node2D

const file_name = "user://savegame.save"

var data = {}

signal saving_data

onready var player = null

func start():
	apply_loaded_data()

func save_data():
	if player.current_checkpoint != null:
		data["current_checkpoint"] = player.current_checkpoint.transform
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
			"current_checkpoint": player.current_checkpoint.transform
		}
	else:
		data = load_data()
	if data.has("current_checkpoint"):
		player.transform = data["current_checkpoint"]
	print(data)
