extends Control

const GAME_SCENE: PackedScene = preload("res://src/Game.tscn")

onready var start_button = $MarginContainer/VBoxContainer/VBoxContainer/StartButton
onready var options_button = $MarginContainer/VBoxContainer/VBoxContainer/OptionsButton
onready var credits_button = $MarginContainer/VBoxContainer/VBoxContainer/CreditsButton
onready var exit_button = $MarginContainer/VBoxContainer/VBoxContainer/ExitButton

func _ready() -> void:
	$MarginContainer/VBoxContainer/VBoxContainer/StartButton.grab_focus()

func _on_start_pressed() -> void:
	start_button.disabled = true
	options_button.disabled = true
	credits_button.disabled = true
	exit_button.disabled = true
	
	$Tween.interpolate_property(
		$CanvasModulate,
		@"color",
		$CanvasModulate.color,
		Color.black, 1.0
	)
	$Tween.interpolate_property(
		$AudioStreamPlayer,
		@"volume_db",
		$AudioStreamPlayer.volume_db,
		-60, 1.0
	)
	$Tween.start()
	yield(get_tree().create_timer(1.5), "timeout")
	get_tree().change_scene_to(GAME_SCENE)

func _on_options_pressed() -> void:
	GuiManager.settings_menu.popup_centered()

func _on_credits_pressed() -> void:
	pass # Replace with function body.

func _on_exit_pressed() -> void:
	self.get_tree().quit()
