extends Control

var resolutions: PoolVector2Array

onready var ratio_options: OptionButton = $VBoxContainer/RatioSetting/RatioOptions
onready var fullscreen_check: CheckBox = $VBoxContainer/FullScreenCheckBox

func _ready() -> void:
	self.ratio_options.add_item("Adapt", GameSettings.SCREEN_ASPECT_RATIO.ADAPT)
	self.ratio_options.add_item("4:3", GameSettings.SCREEN_ASPECT_RATIO.FULL_SCREEN)
	self.ratio_options.add_item("16:9", GameSettings.SCREEN_ASPECT_RATIO.WIDE_SCREEN)
	self.ratio_options.select(GameSettings.get_aspect_ratio())

	fullscreen_check.pressed = OS.window_fullscreen

func _on_aspect_selected(index: int) -> void:
	var resolution: Vector2 = GameSettings.get_resolution(index)
	GameSettings.set_viewport_size(resolution)

func _on_fullscreen_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed
