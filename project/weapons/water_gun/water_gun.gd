extends Spatial

var last_cursor: Vector2 = Vector2.ZERO

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseMotion:
		last_cursor = p_event.position

func _process(p_delta: float) -> void:
	var target = _cast_screen_ray(last_cursor)
	if target != Vector3.ZERO:
		_update_look_target(target)

func _cast_screen_ray(p_cursor: Vector2) -> Vector3:
	var camera = get_viewport().get_camera()
	var space = get_world().get_direct_space_state()
	var from = camera.project_ray_origin(p_cursor)
	var to = camera.project_ray_normal(p_cursor) * 100.0
	
	var result = space.intersect_ray(from, to, [])
	return Vector3.ZERO if result.empty() else result["position"] 

func _update_look_target(p_target: Vector3) -> void:
	$WaterGunSkin.target = p_target
