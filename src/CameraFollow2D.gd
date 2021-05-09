class_name CameraFollow2D extends Camera2D

export(Vector2) var position_offset: Vector2
export(bool) var pixel_perfect: bool
export(float) var follow_speed: float = 8.0

var follow: Node2D
var tween: Tween = Tween.new()

func _ready() -> void:
	self.add_child(tween)

func _physics_process(delta: float) -> void:
	if (follow):
		self.position = self.position.linear_interpolate(follow.position + position_offset, delta * follow_speed).round()
		if (pixel_perfect):
			self.position = self.position.round()
