class_name Player extends Character

extends KinematicBody2D
var vel=Vector2()
var speed
var speed_default=4
const GRAVITY=1000
#const up=Vector2(0,-1)
const acceleration=5
var sprint_speed=14
var sprinting=false
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	
	vel.y +=GRAVITY*delta
	movement_loop()
	
	move_and_slide(vel,Vector2.UP)

func movement_loop():
	speed=speed_default
	
	var right= Input.is_action_pressed("move_right")
	var left= Input.is_action_pressed("move_left")
	var dirx=int(right)-int(left)
	if(dirx==-1):
		vel.x -= speed
	elif(dirx==1):
		vel.x += speed
	else:
		vel.x=lerp(vel.x,0,0.15) 
	var jump=Input.is_action_just_pressed("jump")
	if(jump==true)and is_on_floor():
		vel.y=-700
	if Input.is_action_just_pressed("sprint") and sprinting:
		sprinting=true
	elif Input.is_action_just_pressed("sprint") and sprinting:
		sprinting=false
	if sprinting:
		speed=sprint_speed

# Override
func handle_movement(delta: float) -> void:
	# handle movement here
	return
