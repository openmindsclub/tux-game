class_name GameLoop extends SceneTree

var loader
var wait_frames
var time_max = 100 # msec

#func change_scene(path: String) -> int:
#	var scene: PackedScene = yield(LoadingScreen.load_resource(path), "completed") as PackedScene
#	return change_scene_to(scene)
#
#func change_scene_to(scene: PackedScene) -> int:
#	var error: int = .change_scene_to(scene)
#	return error
