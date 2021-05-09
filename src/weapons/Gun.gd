tool
class_name Gun extends Weapon

export(int) var max_bullets: int setget set_max_bullets
export(int) var bullets: int setget set_bullets
var bullet_speed: int
var bullet_type

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

func use() -> void:
	if (self.bullets > 0):
		self.bullets -= 1
		var bullet: Bullet = Bullet.new(bullet_speed, self._get_shot_direction(), bullet_type)
		bullet.position = get_node(bullet_position).position
		self.get_parent().call_deferred("add_child", bullet)

func _get_shot_direction() -> Vector2:
	return Vector2.ZERO

func _get_configuration_warning() -> String:
	var warnnigs: PoolStringArray = PoolStringArray()
	if (not bullet_position):
		warnnigs.append("'bullet_position' property is not set")
	elif not (self.get_node_or_null(bullet_position) is Position2D):
		warnnigs.append("bullet Position must beo f type: 'Position2D'")
	return warnnigs.join("\n")
