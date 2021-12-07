tool
class_name Gun extends Weapon

signal shoot(bullet)

const BULLET_SCENE: PackedScene = preload("res://src/weapons/Bullet.tscn")

export(Texture) var bullet_texture: Texture
export(int) var max_bullets: int setget set_max_bullets
export(int) var bullets: int setget set_bullets
export(float) var bullet_speed: int

export(NodePath) var bullet_position: NodePath

func set_max_bullets(value: int) -> void:
	# warning-ignore:narrowing_conversion
	max_bullets = max(0, value)
	self.set_bullets(bullets)

func set_bullets(value: int) -> void:
	# warning-ignore:narrowing_conversion
	bullets = clamp(value, 0, max_bullets)
	sprite.frame = int((_get_animation_frames() - 1) * get_load_ratio())

func get_load_ratio() -> float:
	if (max_bullets == 0):
		return NAN
	return float(bullets) / max_bullets

func use(direction: Vector2 = Vector2.ZERO) -> void:
	if can_use and bullets > 0:
		bullets -= 1
		
		var bullet: Bullet = BULLET_SCENE.instance()
		bullet.direction = direction
		bullet.speed = bullet_speed
		bullet.call_deferred("set_indexed", "sprite:texture", bullet_texture)
		bullet.global_position = get_node(bullet_position).global_position
		emit_signal("shoot", bullet)
		attack_cooldown()

func _get_configuration_warning() -> String:
	var warnnigs: PoolStringArray = PoolStringArray()
	if (not bullet_position):
		warnnigs.append("'bullet_position' property is not set")
	elif not (self.get_node_or_null(bullet_position) is Position2D):
		warnnigs.append("bullet Position must beo f type: 'Position2D'")
	return warnnigs.join("\n")
