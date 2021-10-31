extends Popup

func _ready() -> void:
	self.call_deferred("raise")
	# warning-ignore:return_value_discarded
	GameSettings.connect("display_settings_update", self,"_on_display_settings_update")

func change_visibility(visible: bool) -> void:
	self.visible = visible
	self.get_tree().paused = visible

func _on_display_settings_update() -> void:
	if self.visible:
		self.popup_centered()

func _on_save_button_pressed() -> void:
	print(get_viewport().get_size_override())
	GameSettings.save_settings()
