class_name Player extends Character


# Override
func handle_movement(delta: float) -> void:
	var x_direction: int = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if (Input.is_action_pressed("jump") && is_on_floor()):
		self.velocity.y = -self.jump_force
	self.velocity.x = lerp(velocity.x, x_direction * speed, 0.2)
	
	# flip sprites
	if (self.velocity.x < 0):
		$Body.scale.x = -1
	elif (self.velocity.x > 0):
		$Body.scale.x = 1
	
