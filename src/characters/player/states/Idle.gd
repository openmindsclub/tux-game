class_name PlayerIdle extends PlayerMotion

func enter() -> void:
	owner.play_back.travel("idle")
	owner.velocity.x = 0

func update(_delta: float) -> void:
	if owner.velocity.y >= FALL_SPEED:
		emit_signal("finished", "fall")

func unhandled_key_input(_event: InputEventKey) -> void:
	if can_jump():
		emit_signal("finished", "jump")
	
	elif get_direction() != Vector2.ZERO:
		emit_signal("finished", "move")
