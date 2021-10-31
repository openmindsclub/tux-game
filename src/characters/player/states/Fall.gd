class_name PlayerFall extends PlayerAir

func _init() -> void:
	check_falling = false

func enter() -> void:
	owner.play_back.travel("fall")
