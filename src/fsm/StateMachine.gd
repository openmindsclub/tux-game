class_name StateMachine extends Node

signal state_update(new_state)

var states: Dictionary
var current_state: State setget set_state
var previous_state: State

export(NodePath) var default_state_path: NodePath

func _ready() -> void:
	set_deferred("current_state", get_default_state())

func add_state(state: State) -> void:
	# warning-ignore:return_value_discarded
	state.connect("finished", self, "_change_state")
	states[state.name.to_lower()] = state

func get_default_state() -> State:
	return get_node(default_state_path) as State

func set_state(state: State) -> void:
	if not state:
		state = get_default_state()
	
	previous_state = current_state
	current_state = state
	
	if previous_state:
		previous_state.disable()
		previous_state.exit()
		current_state.previous_state = previous_state.name.to_lower()
	
	current_state.enable()
	current_state.enter()
	emit_signal("state_update", current_state)

func _change_state(state_name: String = "") -> void:
	if state_name.empty():
		self.current_state = previous_state
		return
	self.current_state = states[state_name]
