class_name PlayerMove extends PlayerMotion

func enter() -> void:
	if owner.attacking:
		owner.play_back.travel("move_no_wings")
	else:
		owner.play_back.travel("move")

func update(_delta) -> void:
	if owner.is_on_floor():
		if owner.attacking:
			owner.play_back.travel("move_no_wings")
		else:
			owner.play_back.travel("move")
	
	var direction: Vector2 = get_direction()
	if direction.x > 0:
		owner.body.scale.x = 1
	
	elif direction.x < 0:
		owner.body.scale.x = -1
	
	owner.velocity.x = direction.x * owner.speed
	
	if check_falling and owner.velocity.y >= FALL_SPEED:
		emit_signal("finished", "fall")

func unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("slide"):
		emit_signal("finished", "slide")
		return
	
	if can_jump():
		emit_signal("finished", "jump")

	if get_direction() == Vector2.ZERO:
		emit_signal("finished", "idle")
