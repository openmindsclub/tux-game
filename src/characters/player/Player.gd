class_name Player extends Character

const SPRINT_BOOST: float = 2.0

func handle_movement(delta: float) -> void:
	var final_speed: float = self.speed
	if Input.is_action_just_pressed("sprint"):
		final_speed += SPRINT_BOOST
	
	var x_direction: int = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = lerp(self.velocity.x, x_direction * final_speed, 0.15)
	
	var jump = Input.is_action_just_pressed("jump")
	
	if jump == true and is_on_floor():
		self.velocity.y = -self.jump_force
	
	if (self.velocity.x < 0):
		$Body.scale.x = -1
	elif (self.velocity.x > 0):
		$Body.scale.x = 1
