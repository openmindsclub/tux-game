# Base class for every character in the game
class_name Character extends KinematicBody2D

const GRAVITY: float = 100.0

# Animation stuff (will explain later)
export(NodePath) var animation_player_nodepath: NodePath
var _animatipn_player: AnimationPlayer

# Basic character properties
export(float)    var max_health: float = 10.0
export(float)    var health:     float = max_health setget set_health, get_health
export(float)    var speed:      float = 200.0
export(float)    var jump_force: float = 1200.0
export(bool)     var can_move:   float = true

var velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	# Ensure that max_health is a positive value
	max_health = max(0, max_health)
	# Ensure that health is a positive value and equal or below max_health
	health = clamp(health, 0, max_health)
	
	# Check if the node path provied is of type AnimationPlayer
	var node: Node = self.get_node(animation_player_nodepath)
	if !(node is AnimationPlayer):
		_animatipn_player = node as AnimationPlayer

func set_health(value: float) -> void:
	health = value
	if (health <= 0):
		kill()

func get_health() -> float:
	return health

func kill() -> void:
	if (_animatipn_player and _animatipn_player.has_animation("die")):
		_animatipn_player.play("die")
	yield(_animatipn_player, "animation_finished")
	self.queue_free()

func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY
	if (can_move):
		handle_movement(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
	handle_animation()

func handle_animation() -> void:
	if (!_animatipn_player):
		return
	
	if (velocity.y > 0 and _animatipn_player.has_animation("fall")):
		_animatipn_player.play("fall")
	
	elif (velocity.y <= 0 and _animatipn_player.has_animation("jump")):
		_animatipn_player.play("jump")
	
	elif !(is_equal_approx(velocity.x, 0) and _animatipn_player.has_animation("move")):
		_animatipn_player.play("move")
	
# Abstract method
# This method should be overriden in the Player sublcass to handle movement (Sonia's task)
# delta value is passed in case that you need it
# The returned value is a Vector2 of calculation results of user inputs
func handle_movement(delta: float) -> void:
	# Example;
	# var x_direction: int = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	# velocity.x = lerp(velocity.x, x_direction * speed, 0.2)
	return
