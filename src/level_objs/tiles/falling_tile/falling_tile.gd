extends KinematicBody2D

signal start

export(Vector2) var fall_speed = Vector2(5,5)
export(float) var wait_time = 1
export(float) var friction = -0.1

export(bool) var fall = false

var the_timer = null

var starting_pos = global_transform.origin

func _ready():
	starting_pos = global_transform.origin
	connect("start", self, "start_timer")
	var timer = Timer.new()
	timer.wait_time = wait_time
	add_child(timer)
	timer.connect("timeout", self, "do_fall")
	the_timer = timer
	
func start_timer():
	the_timer.start()
	
func do_fall():
	fall = true

func reset():
	global_transform.origin = starting_pos
	fall = false
	the_timer.queue_free()
	var timer = Timer.new()
	timer.wait_time = wait_time
	add_child(timer)
	timer.connect("timeout", self, "do_fall")
	the_timer = timer

func _physics_process(delta):
	if fall:
		fall_speed = Vector2(fall_speed.x + sign(fall_speed.x) * friction, fall_speed.y + sign(fall_speed.y) * friction)
		global_transform.origin += fall_speed
