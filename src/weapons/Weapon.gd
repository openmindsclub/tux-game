tool
class_name Weapon extends Node2D

export(Texture) var texture: Texture setget set_texture, get_texture
export(float) var cooldown: float
var can_use: bool = true

var sprite: Sprite = Sprite.new()

func _ready() -> void:
	sprite.centered = false
	self.add_child(sprite)

func set_texture(_texture: Texture) -> void:
	sprite.texture = _texture

func get_texture() -> Texture:
	return sprite.texture

func attack_cooldown() -> void:
	can_use = false
	yield(get_tree().create_timer(cooldown), "timeout")
	can_use = true

func use() -> void:
	pass

func _get_animation_frames() -> int:
	return sprite.hframes * sprite.vframes
