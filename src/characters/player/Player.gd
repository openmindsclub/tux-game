class_name Player extends Character

var vel=Vector2()

const current_speed=4
const GRAVITY=1000
#const up=Vector2(0,-1)
const acceleration=5
const sprint_speed=14
var sprinting=false

func movement_loop():
	speed=current_speed
	
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


