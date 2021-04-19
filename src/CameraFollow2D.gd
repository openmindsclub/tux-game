class_name CameraFollow2D extends Camera2D

var follow_speed: float = 8.0
var follow: Node2D
var tween: Tween = Tween.new()

func _ready() -> void:
	self.add_child(tween)

func _physics_process(delta: float) -> void:
	if (follow):
		self.position = self.position.linear_interpolate(follow.position, delta * follow_speed)
