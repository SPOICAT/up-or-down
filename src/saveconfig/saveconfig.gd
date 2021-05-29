extends Node2D

const file_name = "user://savegame.save"

var data = {}

onready var player = null

func start():
	apply_loaded_data()
	
func _exit_tree():
	save_data()
	#print(load_data())

func save_data():
	data["transform"] = player.transform
	var f = File.new()
	f.open(file_name, f.WRITE)
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
	if load_data().empty():
		data = {
			"transform": player.transform
		}
	else:
		data = load_data()
	player.transform = data["transform"]
	print(data["transform"])
