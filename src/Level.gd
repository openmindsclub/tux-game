tool
extends Node2D

const GAME_ICON: Texture = preload("res://icons/icon.png")
const PLAYER_SCENE: PackedScene = preload("res://src/characters/player/Player.tscn")

export(NodePath) var camera_node_path: NodePath
export(NodePath) var spawn_position: NodePath

var _player: Player
var _camera: CameraFollow2D

func _ready() -> void:
	if (Engine.editor_hint):
		return
	self.set_process(false)
	self._setup()

func _setup() -> void:
	self._player = PLAYER_SCENE.instance()
	var camera_node: Node = self.get_node_or_null(camera_node_path)
	self._player.connect("died", self, "_on_player_death")
	self._player.position = $SpawnPoint.position
	$World.call_deferred("add_child",self._player)
	camera_node.following = self._player

func _on_player_death() -> void:
	self._setup()

func _process(_delta: float) -> void:
	self.update()

func _draw() -> void:
	if (not Engine.editor_hint):
		return
	var position_node: Node = self.get_node_or_null(spawn_position)
	if (not position_node):
		return
	var rect: Rect2 = Rect2(
		Vector2(-1, 0),
		Vector2(1, 1)
	).grow(8.0)
	rect.position = position_node.global_position
	rect.position.x -= rect.size.x / 2
	rect.position.y -= rect.size.y + 10 + sin(deg2rad(OS.get_ticks_msec() / 5)) * 5
	self.draw_texture_rect(GAME_ICON, rect, false)
