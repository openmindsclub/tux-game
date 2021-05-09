tool
class_name Bullet extends KinematicBody2D

const TYPE: Dictionary = {
	SNOWBALL= preload("res://src/weapons/snowball gun/snowball.png")
}

var speed: int
var sprite: Sprite = Sprite.new()
var direction: Vector2

# warning-ignore:shadowed_variable
# warning-ignore:shadowed_variable
func _init(speed: int, direction: Vector2, texture: Texture) -> void:
	self.speed = speed
	self.direction = direction
	self.sprite.texture = texture

func _ready() -> void:
	self.add_child(sprite)

func _process(delta: float) -> void:
	self.move_and_slide(direction.normalized() * speed)
