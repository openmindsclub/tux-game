extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/VBoxContainer/StartButton.grab_focus()

func _on_start_pressed() -> void:
	pass

func _on_options_pressed() -> void:
	GuiManager.settings_menu.popup_centered()

func _on_credits_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	self.get_tree().quit()
