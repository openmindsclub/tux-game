class_name Gun extends Sprite

const BULLET: PackedScene = preload("res://src/guns/Bullet.tscn")

signal shoot(bullet)

export var bullets: int
export(float, 0.0, 1.0) var precesion: float = 0.84

onready var fire_point: Position2D = $FirePoint
onready var animation: AnimationPlayer = $AnimationPlayer
onready var cool_down: Timer = $CoolDownTimer

func shoot(direction: Vector2, bullet_count: int = 1):
	if bullet_count > 0 and bullets >= bullet_count and cool_down.is_stopped():	
		bullets -= bullet_count
		for i in bullet_count:
			var bullet: Bullet = BULLET.instance()
			direction = direction.rotated((1.0 - precesion) * PI / 6 * rand_range(-1.0, 1.0))
			bullet.direction = direction
			bullet.global_position = fire_point.global_position
			emit_signal("shoot", bullet)
		
		animation.play("shoot", -1, 1 / cool_down.wait_time)
		cool_down.start()
