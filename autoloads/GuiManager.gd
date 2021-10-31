extends CanvasLayer

const BUTTON_PRESSED: AudioStream = preload("res://assets/sounds/ui/button_pressed.wav")
const BUTTON_FOCUSED: AudioStream = preload("res://assets/sounds/ui/button_focused.wav")
const SETTINGS_MENU_SCENE: PackedScene = preload("res://src/menus/settings menu/SettingsMenu.tscn")

const SOUND_VOLUME: float = 0.15

var settings_menu: Control

var audio_player: AudioStreamPlayer = AudioStreamPlayer.new()

func _ready() -> void:
	self.pause_mode = PAUSE_MODE_PROCESS
	
	settings_menu = SETTINGS_MENU_SCENE.instance()
	self.add_child(settings_menu)
	
	self.audio_player.volume_db = linear2db(SOUND_VOLUME)
	self.add_child(audio_player)
	
	var tree: SceneTree = self.get_tree()
	# warning-ignore:return_value_discarded
	tree.connect("node_added", self, "_on_node_added")
	self.connect_node(tree.root)

func connect_node(node: Node) -> void:
	for child in CommonUtil.get_all_children(node) + [node]:
		if child is Button:
			if not child.is_connected("pressed", self, "_button_pressed"):
				child.connect("pressed", self, "_button_pressed", [child])
			if not child.is_connected("focus_entered", self, "_button_focused"):
				child.connect("focus_entered", self, "_button_focused", [child])
				

func _on_node_added(node: Node) -> void:
	self.connect_node(node)

func _button_pressed(_button: Button) -> void:
	self.audio_player.stream = BUTTON_PRESSED
	self.audio_player.play()

func _button_focused(_button: Button) -> void:
	if not (_button.get_draw_mode() in [BaseButton.DRAW_HOVER, BaseButton.DRAW_HOVER_PRESSED]):
		self.audio_player.stream = BUTTON_FOCUSED
		self.audio_player.play()
	
