tool
class_name Weapon extends Node2D

export(Texture) var texture: Texture setget set_texture, get_texture

var sprite: Sprite = Sprite.new()

func _ready() -> void:
	sprite.centered = false
	self.add_child(sprite)

func set_texture(_texture: Texture) -> void:
	sprite.texture = _texture

func get_texture() -> Texture:
	return sprite.texture

func use() -> void:
	pass

func _get_animation_frames() -> int:
	return sprite.hframes * sprite.vframes
