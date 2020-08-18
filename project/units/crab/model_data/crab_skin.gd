extends Spatial

func _process(p_delta: float) -> void:
	_update_ground()

func _update_ground() -> void:
	var n1 = _ground_normal(Vector3(0.163, 0.0, 0.121))
	var n2 = _ground_normal(Vector3(-0.163, 0.0, 0.121))
	var n3 = _ground_normal(Vector3(0.0, 0.0, -0.228))
	var n4 = _ground_normal(Vector3(0.0, 0.0, 0))
	
	var dir = (n1 + n2 + n3 + n4).normalized()
	var new_xform = Transform().looking_at(dir, Vector3.BACK)
	var rotated = Transform().rotated(Vector3(1.0, 0.0, 0.0), -PI * 0.5)
	transform = transform.interpolate_with(new_xform * rotated, 0.1)

func _ground_normal(p_offset: Vector3) -> Vector3:
	var space = get_world().direct_space_state
	var from = global_transform.origin + p_offset
	var to = from + Vector3(0.0, -0.5, 0.0)
	var result = space.intersect_ray(from, to, [get_parent()])
	
	if result.empty():
		return Vector3.UP
	
	return result["normal"]
