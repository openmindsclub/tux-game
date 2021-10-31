# Base class for every character in the game
class_name Character extends KinematicBody2D

signal died()

const GRAVITY: float = 9.8 * 1.0
const FRICTION: float = 0.25

# Basic character properties
export(float) var max_health: float = 10.0 setget set_max_health
export(float) var health: float = max_health setget set_health
export(float) var acceleration: float = 512.0
export(float) var speed: float = 120.0
export(float) var jump_force: float = 300.0
export(bool) var apply_gravity: bool = true

var velocity: Vector2 = Vector2.ZERO

onready var body: Node2D = $Body
onready var state_machine: StateMachine = $StateMachine
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var animation_tree: AnimationTree = $AnimationTree
onready var play_back: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

func set_max_health(value: float) -> void:
	max_health = max(0, value)
	self.health = health # force update health value to stay in range

func set_health(value: float) -> void:
	health = clamp(value, 0, max_health)
	if health == 0:
		kill()

func kill() -> void:
	self.emit_signal("died")
	self.queue_free()

func _physics_process(delta: float) -> void:
	if apply_gravity:
		velocity.y += GRAVITY
	
	velocity.y = move_and_slide(velocity, Vector2.UP, true).y
