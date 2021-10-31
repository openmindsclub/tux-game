extends Node

signal loading_completed(resource)

var loader: ResourceInteractiveLoader
var wait_frames: int
var time_max: int = 100 # msec

onready var popup: Popup = $Popup
onready var progress_bar: ProgressBar = $Popup/PanelContainer/MarginContainer/VSplitContainer/ProgressBar
onready var tween: Tween = $Tween


func _ready() -> void:
	self.set_process(false)

func load_resource(path: String) -> Resource:
	loader = ResourceLoader.load_interactive(path)
	if not loader:
		push_error("couldn't initialize an interactive loader")
		return
	set_process(true)
	wait_frames = 1
	self.popup.popup()
	var resource: Resource = yield(self, "loading_completed")
	self.hide()
	return resource

func _process(_delta) -> void:
	if (wait_frames > 0):
		wait_frames -= 1
		return
	
	var t = OS.get_ticks_msec()
	while (OS.get_ticks_msec() < t + time_max):
		var error = loader.poll()
	
		if (error == ERR_FILE_EOF):
			self.emit_signal("loading_completed", loader.get_resource())
			self.set_process(false)
			loader = null
			break
		elif (error == OK):
			self.update_progress(float(loader.get_stage()) / loader.get_stage_count())
		else:
			push_error("Error %d" % error)
			loader = null
			break

func popup(rect: Rect2 = Rect2(0, 0, 0, 0)) -> void:
	self.tween.stop_all()
	.popup()

func hide() -> void:
	self.tween.interpolate_property(
		self.popup,
		@"modulate",
		self.popup.modulate,
		Color(255, 255, 255, 0),
		1.0
	)
	self.tween.start()
	yield(self.tween, "tween_completed")
	self.popup.hide()

func update_progress(value: float) -> void:
	progress_bar.value = value

