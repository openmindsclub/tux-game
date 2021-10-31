tool
class_name Bullet extends KinematicBody2D

var meta: BulletMeta
var direction: Vector2
var sprite: Sprite = Sprite.new()

# warning-ignore:shadowed_variable
func _init(meta: BulletMeta) -> void:
	self.meta = meta

func _ready() -> void:
	sprite.texture = meta.texture
	self.add_child(sprite)

func _physics_process(_delta: float) -> void:
	var collision: KinematicCollision2D = self.move_and_collide(direction.normalized() * meta.speed)
	if (collision):
		self.destroy()

func destroy() -> void:
	self.free()
