class_name Character extends KinematicBody2D

const GRAVITY: Vector2 = Vector2(0.0, 16.0)

export var max_health: int = 5      setget set_max_health
export var health: int = max_health setget set_health
export var speed: float = 98.0
export var jump_force: float = 288.0

var velocity: Vector2

onready var pivot: Position2D = $Pivot

func can_jump() -> bool:
	return is_on_floor()

func is_falling() -> bool:
	return velocity.y > 0.0 and not is_on_floor()

func set_max_health(value: int) -> void:
	max_health = int(max(0, value))
	# update health
	self.health = health

func set_health(value: int) -> void:
	health = int(clamp(value, 0, max_health))
	if health == 0:
		die()

func die() -> void:
	queue_free()

func _physics_process(_delta: float) -> void:
	if Engine.editor_hint:
		return
	
	velocity += GRAVITY
	
	velocity = move_and_slide(velocity, Vector2.UP)

	if not is_zero_approx(velocity.x):
		pivot.scale.x = sign(velocity.x)
