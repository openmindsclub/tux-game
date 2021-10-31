class_name PlayerJump extends PlayerAir

func enter() -> void:
	owner.play_back.travel("jump")
	owner.velocity.y -= owner.jump_force

func update(delta: float) -> void:
	.update(delta)
	var y_veolocity: float = owner.velocity.y
	if Input.is_action_just_released("jump") and y_veolocity < -owner.jump_force / 4:
		owner.velocity.y = y_veolocity / 2
