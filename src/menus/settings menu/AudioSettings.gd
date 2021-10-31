extends Control

onready var master_volume_slider: Slider = $VBoxContainer/MasterVolumeSetting/Slider
onready var music_volume_slider: Slider = $VBoxContainer/MusicVolumeSetting/Slider

func _ready() -> void:
	self.master_volume_slider.value = GameSettings.get_master_volume()
	self.music_volume_slider.value = GameSettings.get_music_volume()

func _on_master_volume_changed(value: float) -> void:
	GameSettings.set_master_volume(value)


func _on_music_volume_changed(value: float) -> void:
	GameSettings.set_music_volume(value)
