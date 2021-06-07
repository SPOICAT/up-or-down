extends Node2D
class_name MobileInput

func _ready():
	print(OSconfig.os)
	visible = OSconfig.os == "Mobile"
