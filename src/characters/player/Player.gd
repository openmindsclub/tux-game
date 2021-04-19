class_name Player extends Character

const SLIDE_BOOST: float = 3.0

var is_sliding: bool

func handle_movement(delta: float) -> void:
	var final_speed: float = self.speed
	var final_friction: float = FRICTION
	var x_direction: int = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	if (is_sliding):
		final_friction /= 10

	if (x_direction != 0 and !is_sliding):
		velocity.x += x_direction * self.acceleration * delta
		velocity.x = clamp(velocity.x, -final_speed, final_speed)
	else:
		velocity.x = lerp(self.velocity.x, 0, final_friction)
	
	if Input.is_action_pressed("jump") and is_on_floor() and !is_sliding:
		self.velocity.y = -self.jump_force
	
	if (self.velocity.x < 0):
		$Body.scale.x = -1
	elif (self.velocity.x > 0):
		$Body.scale.x = 1

func handle_animation() -> void:
	if (is_sliding):
		$AnimationPlayer.play("slide")
		return
	.handle_animation()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("slide") and !event.is_echo()):
		self.is_sliding = true
		self.velocity.x *= SLIDE_BOOST
		if (abs(self.velocity.x) >= self.speed * SLIDE_BOOST):
			$Body/DashParticles.emitting = true
	elif (event.is_action_released("slide") and !event.is_echo()):
		self.is_sliding = false

func _on_exited_screen() -> void:
	self.kill()
