extends Control

var resolutions: PoolVector2Array

onready var option_button: OptionButton = $ResolutionSetting/ResolutionOption

func _ready() -> void:
	self.resolutions = GameSettings.get_supported_resolutions()
	var current_resolution: Vector2 = GameSettings.get_resolution()
	for i in range(len(resolutions)):
		var resolution: Vector2 = self.resolutions[i]
		self.option_button.add_item(stringify_resolution(resolution), i)
		if (current_resolution == resolution):
			self.option_button.select(i)
	self.option_button.text = stringify_resolution(GameSettings.get_resolution())

func _on_resolution_selected(index: int) -> void:
	GameSettings.set_resolution(self.resolutions[index])

static func stringify_resolution(resolution: Vector2) -> String:
	return "%dx%d" % [resolution.x, resolution.y]

