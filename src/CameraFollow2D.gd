class_name CameraFollow2D extends Camera2D

export(float) var follow_speed: float = 8.0

var following: Node2D

func _process(delta: float) -> void:
	if following:
		self.position = self.following.position
