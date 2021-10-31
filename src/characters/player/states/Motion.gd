class_name PlayerMotion extends State

const FALL_SPEED: float = 400.0

var check_falling: bool = true

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		0
	)

func can_jump() -> bool:
	return Input.is_action_pressed("jump") and owner.is_on_floor()
