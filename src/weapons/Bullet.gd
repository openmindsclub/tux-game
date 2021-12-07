tool
class_name Bullet extends KinematicBody2D

var direction: Vector2
var speed: float

onready var sprite: Sprite = $Sprite

func _physics_process(_delta: float) -> void:
	var collision: KinematicCollision2D = self.move_and_collide(direction.normalized() * speed)
	if collision:
		self.destroy()

func destroy() -> void:
	self.queue_free()
