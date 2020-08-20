extends Label

func _process(p_delta: float) -> void:
	var fps = Engine.get_frames_per_second()
	var ms = floor(p_delta * 1000.0)
	
	text = "FPS: %d (%dms)" % [fps, ms]
