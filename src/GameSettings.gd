extends Node

signal display_settings_update()

enum SCREEN_ASPECT_RATIO {
	ANY,
	FULL_SCREEN = 4/3,
	WIDE_SCREEN = 16/9
}

enum AUDIO_BUS {
	MASTER,
	MUSIC
}

const SETTINGS_SECTIONS: PoolStringArray = PoolStringArray(["display", "audio"])
const SETTINGS_FILE_PATH: String = "user://settings.ini"

const FULL_SCREEN_RESOLUTIONS: PoolVector2Array = PoolVector2Array([
	Vector2(800, 600),
	Vector2(960, 720),
	Vector2(1024, 768),
	Vector2(1280, 960),
	Vector2(1400, 1050),
	Vector2(1440, 1080),
	Vector2(1600, 1200),
	Vector2(1920, 1440),
	Vector2(2048, 1536),
])

const WIDE_SCREEN_RESOLUTIONS: PoolVector2Array = PoolVector2Array([
	Vector2(960, 540),
	Vector2(1024, 576),
	Vector2(1152, 648),
	Vector2(1280, 720),
	Vector2(1600, 900),
	Vector2(1920, 1080),
	Vector2(2560, 1440),
	Vector2(3840, 2160),
])

const OTHER_SCREEN_RESOLUTIONS: PoolVector2Array = PoolVector2Array([
	Vector2(1366, 768),
	Vector2(4096, 2560)
])

var window_resolution: Vector2

func _ready() -> void:
	# warning-ignore:return_value_discarded
	self.get_tree().connect("screen_resized", self, "_on_screen_resized")
	
	if (self.settings_file_exists()):
		self.load_from_file()
		self.save_settings()
	else:
		self.save_settings()

func load_from_file(path: String = SETTINGS_FILE_PATH) -> void:
	var config: ConfigFile = ConfigFile.new()
	var error: int = config.load(path)
	if (error != OK):
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
	
	var  recommended_window_size: Vector2 = self.get_recommneded_resolution()
	var window_size: Vector2 = Vector2(
		int(display_settings.get("window_width", recommended_window_size.x)),
		int(display_settings.get("window_height", recommended_window_size.y))
	)
	
	self.set_resolution(window_size)
	
	self.set_master_volume(audio_settings.get("master_volume", 1.0))
	self.set_music_volume(audio_settings.get("music_volume", 1.0))

func save_settings() -> void:
	var error: int = self.as_config_file().save(SETTINGS_FILE_PATH)
	if (error != OK):
		printerr("Could not save game settings !")

func settings_file_exists() -> bool:
	return File.new().file_exists(SETTINGS_FILE_PATH)

func as_dictionary() -> Dictionary:
	var window_size: Vector2 = self.get_resolution()
	return {
		"display": {
			"window_height": int(window_size.y),
			"window_width": int(window_size.x)
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

func get_resolution() -> Vector2:
	return self.window_resolution

func get_supported_resolutions(aspect_ratio: int = SCREEN_ASPECT_RATIO.ANY) -> PoolVector2Array:
	var resolutions: Array
	match aspect_ratio:
		SCREEN_ASPECT_RATIO.ANY:
			resolutions = Array(FULL_SCREEN_RESOLUTIONS + WIDE_SCREEN_RESOLUTIONS +OTHER_SCREEN_RESOLUTIONS)
		SCREEN_ASPECT_RATIO.FULL_SCREEN:
			resolutions = Array(FULL_SCREEN_RESOLUTIONS)
		SCREEN_ASPECT_RATIO.WIDE_SCREEN:
			resolutions = Array(WIDE_SCREEN_RESOLUTIONS)
	resolutions.sort()
	
	var supported_resolutions: PoolVector2Array = PoolVector2Array()
	for resolution in resolutions:
		if (resolution > OS.get_screen_size()):
			break
		supported_resolutions.append(resolution)

	return supported_resolutions

func get_recommneded_resolution() -> Vector2:
	return OS.get_screen_size()

func set_master_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(AUDIO_BUS.MASTER, linear2db(clamp(volume, 0, 1.0)))

func set_music_volume(volume: float) -> void:
	AudioServer.set_bus_volume_db(AUDIO_BUS.MUSIC, linear2db(clamp(volume, 0, 1.0)))

func set_resolution(resolution: Vector2) -> void:
	self.get_viewport().size = resolution
	window_resolution = resolution
	self.get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_KEEP, resolution)
	OS.center_window()
	self.emit_signal("display_settings_update")
#	OS.window_size = resolution

func _on_screen_resized() -> void:
	pass
