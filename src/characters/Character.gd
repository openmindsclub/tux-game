# Base class for every character in the game
class_name Character extends KinematicBody2D

signal died()

const GRAVITY: float = 980.0
const FRICTION: float = 0.25

# Animation stuff (will explain later)
export(NodePath) var animation_player_nodepath: NodePath
var _animatipn_player: AnimationPlayer

# Basic character properties
export(float) var max_health: float = 10.0 setget set_max_health, get_max_health
export(float) var health: float = max_health setget set_health, get_health
export(float) var acceleration: float = 512.0
export(float) var speed: float = 120.0
export(float) var jump_force: float = 360.0
export(bool) var can_move: float = true

var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Check if the node path provied is of type AnimationPlayer
	var node: Node = self.get_node_or_null(animation_player_nodepath)
	if (node is AnimationPlayer):
		_animatipn_player = node as AnimationPlayer

func set_max_health(value: float) -> void:
	max_health = max(0, value)

func set_health(value: float) -> void:
	health = clamp(value, 0, max_health)
	if (health <= 0):
		kill()

func get_max_health() -> float:
	return max_health

func get_health() -> float:
	return health

func kill() -> void:
	if (_animatipn_player and _animatipn_player.has_animation("die")):
		_animatipn_player.play("die")
		yield(_animatipn_player, "animation_finished")
	self.emit_signal("died")
	self.queue_free()

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	#velocity.y = min(GRAVITY * 20, velocity.y)
	if (can_move):
		handle_movement(delta)
	velocity.y = move_and_slide(velocity, Vector2.UP, true).y
	handle_animation()

func handle_animation() -> void:
	if (not _animatipn_player):
		return

	if (velocity.y <= 0 and _animatipn_player.has_animation("jump")):
		print("play")
		_animatipn_player.play("jump")

	elif (velocity.y > jump_force and _animatipn_player.has_animation("fall")):
		_animatipn_player.play("fall")
	
	elif (abs(velocity.x) > speed * 0.2 and _animatipn_player.has_animation("move")):
		_animatipn_player.play("move")
	
	elif (_animatipn_player.has_animation("idle")):
		if (_animatipn_player.current_animation != "idle"):
			_animatipn_player.stop(true)
		_animatipn_player.play("idle")

# Abstract method
# This method should be overriden in the Player sublcass to handle movement (Sonia's task)
# delta value is passed in case that you need it
# The returned value is a Vector2 of calculation results of user inputs
func handle_movement(_delta: float) -> void:
	# Example;
	# var x_direction: int = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	# velocity.x = lerp(velocity.x, x_direction * speed, 0.2)
	return
