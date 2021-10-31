extends Node

signal display_settings_update()

enum SCREEN_ASPECT_RATIO {
	ADAPT,
	FULL_SCREEN,
	WIDE_SCREEN
}

enum AUDIO_BUS {
	MASTER,
	MUSIC
}

const SETTINGS_SECTIONS: PoolStringArray = PoolStringArray(["display", "audio"])
const SETTINGS_FILE_PATH: String = "user://settings.ini"

const NATIVE_RESOLUTION: Vector2 = Vector2(480, 270)

func _ready() -> void:
	self.get_tree().set_script(GameLoop)
	
	if self.settings_file_exists():
		self.load_from_file()
	self.save_settings()

func load_from_file(path: String = SETTINGS_FILE_PATH) -> void:
	var config: ConfigFile = ConfigFile.new()
	var error: int = config.load(path)
	if error != OK:
		printerr("Could not load game settings !")
		return
	
	var settings: Dictionary = {}
	
	for section in SETTINGS_SECTIONS:
		settings[section] = {}
		if (not config.has_section(section)):
			continue
		for key in config.get_section_keys(section):
			settings[section][key] = config.get_value(section, key)
	
	self.load_from_dictionary(settings)

func load_from_dictionary(dict: Dictionary) -> void:
	var display_settings: Dictionary = dict["display"]
	var audio_settings: Dictionary = dict["audio"]
	
	# Display
	var aspect_ratio: int = display_settings.get("aspect_ratio", get_aspect_ratio())
	OS.window_fullscreen = display_settings.get("fullscreen", OS.window_fullscreen)
	self.set_viewport_size(get_resolution(aspect_ratio))
	
	
	# Audio
	self.set_master_volume(audio_settings.get("master_volume", 1.0))
	self.set_music_volume(audio_settings.get("music_volume", 1.0))

func save_settings() -> void:
	var error: int = self.as_config_file().save(SETTINGS_FILE_PATH)
	if error != OK:
		printerr("Could not save game settings !")

func settings_file_exists() -> bool:
	return File.new().file_exists(SETTINGS_FILE_PATH)

func as_dictionary() -> Dictionary:
	return {
		"display": {
			"aspect_ratio": self.get_aspect_ratio(),
			"fullscreen": OS.window_fullscreen
		},
		"audio": {
			"master_volume": self.get_master_volume(),
			"music_volume": self.get_music_volume()
		}
	}

func as_config_file() -> ConfigFile:
	var config: ConfigFile = ConfigFile.new()
	
	var settings: Dictionary = self.as_dictionary()
	
	for key in settings.keys():
		var parameter: Dictionary = settings[key]
		for parameter_key in parameter.keys():
			config.set_value(key, parameter_key, parameter[parameter_key])
	return config

func get_master_volume() -> float:
	return db2linear(AudioServer.get_bus_volume_db(AUDIO_BUS.MASTER))

func get_music_volume() -> float:
	return db2linear(AudioServer.get_bus_volume_db(AUDIO_BUS.MUSIC))

func get_viewport_size() -> Vector2:
	return get_viewport().get_size_override()

func get_aspect_ratio() -> int:
	var viewport_ratio: float = get_viewport_size().aspect()
	
	if is_equal_approx(viewport_ratio, 4.0/3.0):
		return SCREEN_ASPECT_RATIO.FULL_SCREEN
	if is_equal_approx(viewport_ratio, 16.0/9.0):
		return SCREEN_ASPECT_RATIO.WIDE_SCREEN

	return SCREEN_ASPECT_RATIO.ADAPT

func get_resolution(ratio: int) -> Vector2:
	match ratio:
		SCREEN_ASPECT_RATIO.FULL_SCREEN:
			return Vector2(4, 3) * 120
		SCREEN_ASPECT_RATIO.WIDE_SCREEN:
			return Vector2(16, 9) * 30
		_:
			return get_adaptive_resolution()

	

func set_master_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(AUDIO_BUS.MASTER, linear2db(clamp(volume, 0, 1.0)))

func set_music_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(AUDIO_BUS.MUSIC, linear2db(clamp(volume, 0, 1.0)))

func set_viewport_size(size: Vector2) -> void:
	self.get_tree().set_screen_stretch(
		SceneTree.STRETCH_MODE_2D,
		SceneTree.STRETCH_ASPECT_KEEP,
		size
	)
	self.emit_signal("display_settings_update")

func _input(_event):
	if Input.is_action_just_pressed("reset"):
		# warning-ignore:return_value_discarded
		self.get_tree().reload_current_scene()

static func get_adaptive_resolution() -> Vector2:
	var base_resolution: Vector2 = OS.get_screen_size()
	# warning-ignore:narrowing_conversion
	var scale_factor: int = ceil(base_resolution.x / NATIVE_RESOLUTION.x)
	return base_resolution / scale_factor
