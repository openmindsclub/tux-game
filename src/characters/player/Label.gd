extends Label


func _on_StateMachine_state_update(new_state) -> void:
	text = new_state.name
