extends Node

func _ready() -> void:
	$CanvasModulate.visible = true
	$Tween.interpolate_property(
		$CanvasModulate,
		@"color",
		$CanvasModulate.color,
		Color.white, 1.0
	)
	$Tween.start()
