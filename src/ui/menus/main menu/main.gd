extends Control

export(float) var background_animation_speed: float = 0.01
export(float) var  background_zoom_level: float = 0.1

onready var background: TextureRect = $Background

func _ready() -> void:
	$MarginContainer/VBoxContainer/MarginContainer/VBoxContainer/StartButton.grab_focus()

func _physics_process(_delta: float) -> void:
	var scale: float = sin(deg2rad(OS.get_ticks_msec()) * background_animation_speed)
	self.background.rect_rotation = scale
	self.background.rect_scale = Vector2.ONE * (1 + background_zoom_level * abs(scale))

func _on_start_pressed() -> void:
	pass


func _on_options_pressed() -> void:
	SettingsMenu.popup_centered()

func _on_credits_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	self.get_tree().quit()


