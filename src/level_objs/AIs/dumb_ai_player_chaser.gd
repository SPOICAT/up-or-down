extends KinematicBody2D

onready var player = null

var speed = 1200
var gravity = 4000

var vel = Vector2.ZERO
var snap
var dir = 0

onready var left_cast = $dir_detector/left
onready var right_cast = $dir_detector/right

func _ready():
	for casts in $dir_detector.get_children():
		casts.force_raycast_update()
		casts.add_exception(self)

func raycast_col_check(raycast, colliding_with):
	var value
	if raycast.is_colliding():
		if raycast.get_collider().name == colliding_with:
			 value = true
	else:
		value = false
	return value

func collision_check(colliding_with):
	for i in get_slide_count():
		var col = get_slide_collision(i)
		var value
		if col.collider.name == colliding_with:
			value = true
		else:
			value = false
		return value

export(float, 0,1) var acceleration = 0.25
export(float, 0,1) var friction = 0.1

func _physics_process(delta):
	
	if player:
		
		if collision_check(player.name):
			player.dead = true
		
		dir = 0
		if raycast_col_check(left_cast, player.name):
			dir -= 1
		elif raycast_col_check(right_cast, player.name):
			dir += 1
		if dir != 0:
			vel.x = lerp(vel.x, dir * speed, acceleration)
		else:
			vel.x = lerp(vel.x, 0, friction)
		
		
	vel.y += gravity * delta
	
	snap = Vector2.DOWN * 128
	
	vel = move_and_slide_with_snap(vel.rotated(rotation), snap, -transform.y, true, 4, PI/3)
	vel = vel.rotated(-rotation)
	
	if (not sign($Sprite.scale.x) == 0) and (not sign(vel.x) == 0):
		$Sprite.scale.x = sign(vel.x)
	
	if is_on_floor():
		rotation = get_floor_normal().angle() + PI/2


func _on_range_body_entered(body):
	if body.name == "PLAYER":
		player = body

func _on_range_body_exited(body):
	if body.name == "PLAYER":
		player = null
