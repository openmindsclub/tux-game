extends ParallaxBackground

export(float) var scroll_speed: float = 100.0

func _ready() -> void:
	# warning-ignore:return_value_discarded
	GameSettings.connect("display_settings_update", self, "_align_parallax")

func _process(delta: float) -> void:
	scroll_offset.x += delta * scroll_speed

func _align_parallax() -> void:
	return
	var base_rect: Rect2 = get_viewport().get_visible_rect()
	var y_offset: float = get_viewport().get_size_override().y - base_rect.size.y
	for child in get_children():
		if child is ParallaxLayer:
			child.propagate_call("set_indexed", [@"position:y", y_offset])
 
