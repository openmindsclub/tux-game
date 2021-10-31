class_name PlayerStateMachine extends StateMachine

func _ready() -> void:
	add_state($Idle)
	add_state($Move)
	add_state($Jump)
	add_state($Fall)
	add_state($Slide)
	return
	add_state($Reload)
	add_state($Death)
