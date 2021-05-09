tool
class_name SnowBallGun extends Gun

func _init() -> void:
	self.texture = preload("res://src/weapons/snowball_gun/snowball_gun.png")
	self.sprite.hframes = 5
	self.bullet_speed = 250
	self.bullet_type = Bullet.TYPE.SNOWBALL

func _get_shot_direction() -> Vector2:
	return Vector2(self.global_scale.x, 0)
