extends Area2D

func _ready():
	connect("body_entered", self, "req_end_game")
	
func req_end_game(body):
	if body.name == "PLAYER":
		GameEndC.game_ended = true
		GameEndC.end_game_check()
		saveconfig.save_data()
