extends KinematicBody2D

onready var player = null

var speed = 1200
var gravity = 4000

var vel = Vector2.ZERO
var snap
var dir = 0

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
	
	#print(collision_check("player"))
	
	if player:
		
		if collision_check(player.name):
			player.dead = true
		
		dir = 0
		if player.position.x < position.x:
			dir -= 1 * sign(-rotation)
		elif player.position.x > position.x:
			dir += 1 * sign(-rotation)
		if dir != 0:
			$Sprite.scale.x = dir
			vel.x = lerp(vel.x, dir * speed, acceleration)
		else:
			vel.x = lerp(vel.x, 0, friction)
		
		
	vel.y += gravity * delta
	
	snap = Vector2.DOWN * 128
	
	vel = move_and_slide_with_snap(vel.rotated(rotation), snap, -transform.y, true, 4, PI/3)
	vel = vel.rotated(-rotation)
	
	if is_on_floor():
		rotation = get_floor_normal().angle() + PI/2


func _on_range_body_entered(body):
	if body.name == "PLAYER":
		player = body

func _on_range_body_exited(body):
	if body.name == "PLAYER":
		player = null
