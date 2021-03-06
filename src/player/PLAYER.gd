extends KinematicBody2D

var starting_pos

var dead : bool = false

var current_checkpoint = null

var lives : int = 12

const init_speed = 1200
var speed = init_speed

const init_gravity = 4000
var gravity = init_gravity

const init_jump_speed = -1200
var jump_speed = init_jump_speed

export(float, 0,1) var acceleration = 0.25
export(float, 0,1) var friction = 0.1

onready var saveconfig = get_node("/root/saveconfig")

signal ready_for_saveconfig

func _ready():
	$CanvasLayer/SpeedPauseEffect.visible = false
	speed = init_speed
	gravity = init_gravity
	jump_speed = init_jump_speed
	Engine.time_scale = 1
	connect("ready_for_saveconfig", saveconfig, "start")
	saveconfig.player = get_node(".")
	emit_signal("ready_for_saveconfig")
	
var vel = Vector2.ZERO

var snap
var is_jumping : bool = false

var is_moving : bool = false

func get_input():
	is_moving = false
	var dir = 0
	if Input.is_action_pressed("move_left"):
		dir -= 1
		is_moving = true
	if Input.is_action_pressed("move_right"):
		dir += 1
		is_moving = true
	if dir != 0:
		$Sprite.scale.x = dir
		vel.x = lerp(vel.x, dir * speed, acceleration)
	else:
		vel.x =  lerp(vel.x, 0, friction)

signal reloaded_checkpoint

func reload_checkpoint():
	saveconfig.apply_loaded_data()
	$CanvasLayer/SpeedPauseEffect.visible = true
	Engine.time_scale = 1
	dead = false
	$revive_timer.start()
	gravity = init_gravity
	show()
	emit_signal("reloaded_checkpoint")

func KillerTilemap_check():
	for i in get_slide_count():
		var col = get_slide_collision(i)
		if col.collider.is_in_group("KillerTilemaps"):
			dead = true


func _physics_process(delta):
	
	KillerTilemap_check()
	
	if dead:
		
		$Trail.erase_trail()
		
		$SoundEffects/Hit.play()
		
		speed = 0
		gravity = 0
		jump_speed = 0
			
		hide()
		
		if lives > 0:
			reload_checkpoint()
			lives -= 1
		else:
			saveconfig.delete_data()
			get_tree().reload_current_scene()
			
	get_input()
		
	vel.y += gravity * delta
	
	snap = Vector2.DOWN * 128 if !is_jumping else Vector2.ZERO
	
	vel = move_and_slide_with_snap(vel.rotated(rotation), snap, -transform.y, true, 4, PI/3)
	vel = vel.rotated(-rotation)
	
	if is_on_floor():
		if $Trail.width < 100:
			$Trail.width += 1
		rotation = get_floor_normal().angle() + PI/2
		is_jumping = false
		if Input.is_action_just_pressed("jump"):
			is_jumping = true
			$SoundEffects/Jump.play()
			vel.y = jump_speed
	else:
		if $Trail.width > 75:
			$Trail.width -= 1
			
	if sign(vel.x) == 0:
		$Trail.erase_trail()


func _on_revive_timer_timeout():
	speed = init_speed
	jump_speed = init_jump_speed
	$CanvasLayer/SpeedPauseEffect.visible = false
