class_name PlayerSlide extends PlayerMotion

func enter() -> void:
	pass

func unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_released("slide"):
		if get_direction() != Vector2.ZERO:
			emit_signal("finished", "move")
		else:
			emit_signal("finished", "idle")
