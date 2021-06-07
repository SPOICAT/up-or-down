extends Node

var debugging : bool = false
var debugging_os = "Mobile"

var os

func _ready():
	if not debugging:
		if not OS.get_name() == "Windows":
			os = "Mobile"
		else:
			os = "PC"
	else:
		os = debugging_os
