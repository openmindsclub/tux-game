class_name Player extends Character

onready var animation_tree: AnimationTree = $AnimationTree
onready var playback: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")
onready var sleep_timer: Timer = $SleepTimer
onready var gun: Gun = $Pivot/GunPosition/Gun

var sleepy: bool

func is_going_to_jump() -> bool:
	return can_jump() and Input.is_action_pressed("jump")

func _physics_process(_delta: float) -> void:
	var horizontal_direction: float = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
	)
	
	var horizontal_velocity: float = horizontal_direction * speed
	
	velocity.x = lerp(velocity.x, horizontal_velocity, 0.24)
	
	if is_going_to_jump():
		velocity.y -= jump_force
		playback.travel("jump")
	
	var on_floor: bool = is_on_floor() and not is_going_to_jump()
	var shooting: bool = false
	if Input.is_action_pressed("shoot") and on_floor:
		gun.shoot(Vector2(pivot.scale.x, 0))
		shooting = true
	
	gun.visible = shooting
	
	var is_moving: bool = not is_zero_approx(horizontal_direction) and is_on_floor()
	
	sleepy = sleepy and not is_moving and not shooting and is_on_floor()
	
	animation_tree.set("parameters/conditions/is_moving", is_moving)
	animation_tree.set("parameters/conditions/move_end", not is_moving)
	animation_tree.set("parameters/conditions/on_floor", on_floor)
	animation_tree.set("parameters/conditions/falling", velocity.y > GRAVITY.y * 16)
	animation_tree.set("parameters/conditions/sleepy", sleepy)
	animation_tree.set("parameters/conditions/active", not sleepy)
	animation_tree.set("parameters/conditions/shooting", shooting)
	animation_tree.set("parameters/conditions/not_shooting", not shooting)
	

func _on_sleep_timer_timeout() -> void:
	sleepy = true

func _on_gun_shoot(bullet: Bullet) -> void:
	get_parent().add_child(bullet)
