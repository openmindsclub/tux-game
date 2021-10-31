class_name PlayerAir extends PlayerMove


func update(delta) -> void:
	.update(delta)
	if owner.is_on_floor():
		if get_direction() != Vector2.ZERO:
			emit_signal("finished", "move")
		else:
			emit_signal("finished", "idle")

func unhandled_key_input(_event: InputEventKey) -> void:
	pass
