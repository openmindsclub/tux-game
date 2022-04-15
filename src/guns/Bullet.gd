class_name Bullet extends KinematicBody2D

export var speed: float = 3.0
export var direction: Vector2

func _physics_process(_delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(direction * speed)
	if collision:
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
