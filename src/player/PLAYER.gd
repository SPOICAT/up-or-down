extends KinematicBody2D

var dead : bool = false

var current_checkpoint = null

export var speed = 1200
var backed_speed = null
export var gravity = 4000
var backed_gravity = null
export var jump_speed = -1200
var backed_jump_speed = null

export(float, 0,1) var acceleration = 0.25
export(float, 0,1) var friction = 0.1

onready var saveconfig = get_node("/root/saveconfig")

signal ready_for_saveconfig

func _ready():
	connect("ready_for_saveconfig", saveconfig, "start")
	saveconfig.player = get_node(".")
	emit_signal("ready_for_saveconfig")

var vel = Vector2.ZERO

var snap
var is_jumping : bool = false

func get_input():
	var dir = 0
	if Input.is_action_pressed("move_left"):
		dir -= 1
	if Input.is_action_pressed("move_right"):
		dir += 1
	if dir != 0:
		$Sprite.scale.x = dir
		vel.x = lerp(vel.x, dir * speed, acceleration)
	else:
		vel.x =  lerp(vel.x, 0, friction)

func reload_checkpoint():
	saveconfig.apply_loaded_data()
	dead = false
	speed = backed_speed
	gravity = backed_gravity
	jump_speed = backed_jump_speed
	show()

func KillerTilemap_check():
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider.is_in_group("KillerTilemaps"):
			dead = true


func _physics_process(delta):
	
	KillerTilemap_check()
	
	if dead:
		if backed_speed == null:
			backed_speed = speed
		else:
			speed = 0
		if backed_gravity == null:
			backed_gravity = gravity
		else:
			gravity = 0
		if backed_jump_speed == null:
			backed_jump_speed = jump_speed
		else:
			jump_speed = 0
			
		hide()
		
		reload_checkpoint()


	
	get_input()
	
	vel.y += gravity * delta
	
	snap = Vector2.DOWN * 128 if !is_jumping else Vector2.ZERO
	
	vel = move_and_slide_with_snap(vel.rotated(rotation), snap, -transform.y, true, 4, PI/3)
	vel = vel.rotated(-rotation)
	
	if is_on_floor():
		rotation = get_floor_normal().angle() + PI/2
		is_jumping = false
		if Input.is_action_just_pressed("jump"):
			is_jumping = true
			vel.y = jump_speed
