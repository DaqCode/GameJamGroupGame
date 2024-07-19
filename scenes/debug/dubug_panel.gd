extends Control


func _ready() -> void:
	if not ready:
		await ready
		
	%GPUDriverLabel.text = str(RenderingServer.get_video_adapter_vendor())
	%OSLabel.text = OS.get_name()
	%BuildLabel.text = str(OS.is_debug_build())
	%ProcessorLabel.text = OS.get_processor_name()
	%ScreenCountLabel.text = str(DisplayServer.get_screen_count())
	%ScreenSizeLabel.text = str(DisplayServer.screen_get_size())


func _process(_delta: float) -> void:
	%FPSLabel.text = str(Engine.get_frames_per_second())
	if Input.is_action_just_pressed("show_debug"):
		%Stats.visible = !%Stats.visible
