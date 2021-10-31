class_name State extends Node

# warning-ignore:unused_signal
signal finished(next_state)

var enabled: bool
var previous_state: String

func _ready() -> void:
	disable()

func enable() -> void:
	enabled = true
	set_process(true)
	set_physics_process(true)
	set_process_input(true)
	set_process_unhandled_input(true)
	set_process_unhandled_key_input(true)

func disable() -> void:
	enabled = false
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)

func enter() -> void:
	pass

func update(_delta: float) -> void:
	pass

func unhandled_input(_event: InputEvent) -> void:
	pass

func unhandled_key_input(_event: InputEventKey) -> void:
	pass

func exit() -> void:
	pass

func _physics_process(delta: float) -> void:
	update(delta)

func _unhandled_input(event: InputEvent) -> void:
	unhandled_input(event)

func _unhandled_key_input(event: InputEventKey) -> void:
	unhandled_key_input(event)
