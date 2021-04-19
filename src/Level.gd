extends Node

const PLAYER_SCENE: PackedScene = preload("res://src/characters/player/Player.tscn")

export(NodePath) var player_node_path: NodePath
export(NodePath) var camera_node_path: NodePath

var _player: Player
var _camera: CameraFollow2D

func _ready() -> void:
	var player_node: Node = self.get_node_or_null(player_node_path)
	if (player_node is Player):
		self._player = player_node as Player
		self._player.connect("died", self, "_on_player_death")
	
	var camera_node: Node = self.get_node_or_null(camera_node_path)
	if (camera_node is CameraFollow2D):
		_camera = camera_node as CameraFollow2D
		if (self._player):
			_camera.follow = self. _player

func _on_player_death() -> void:
	self._player = PLAYER_SCENE.instance()
	self._player.connect("died", self, "_on_player_death")
	self._player.position = $SpawnPoint.position
	$FrontTiles.call_deferred("add_child",self._player)
	self._camera.follow = self._player
