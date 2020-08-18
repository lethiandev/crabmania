extends Spatial

var motion_direction: Vector3 = Vector3.ZERO
var last_rotation_basis: Basis = Basis.IDENTITY

func _process(p_delta: float) -> void:
	var ground_normal = _get_ground_normal()
	var ground_basis = _get_ground_normal_basis(ground_normal)
	
	if motion_direction != Vector3.ZERO:
		var new_basis = _get_rotation_basis(motion_direction)
		last_rotation_basis = last_rotation_basis.slerp(new_basis, 0.1)
	
	var result = ground_basis * last_rotation_basis
	global_transform.basis = global_transform.basis.slerp(result, 0.1)

func _get_rotation_basis(p_direction: Vector3) -> Basis:
	var lookat_xform = Transform().looking_at(-motion_direction, Vector3.UP)
	var lookat_basis = lookat_xform.basis
	
	# Fix rotation to make crab strafe-walking
	lookat_basis *= Basis(Vector3.UP, PI * 1.5)
	
	return lookat_basis

func _get_ground_normal_basis(p_normal: Vector3) -> Basis:
	var ground_xform = Transform().looking_at(p_normal, Vector3.FORWARD)
	var ground_basis = ground_xform.basis
	
	# Fix crab orientation on ground normal
	ground_basis *= Basis(Vector3.RIGHT, -PI * 0.5)
	
	return ground_basis

func _get_ground_normal() -> Vector3:
	var n1 = _ray_cast_ground_normal(Vector3(0.16, 0.0, 0.0))
	var n2 = _ray_cast_ground_normal(Vector3(0.0, 0.0, 0.16))
	var n3 = _ray_cast_ground_normal(Vector3(0.0, 0.0, -0.16))
	var n4 = _ray_cast_ground_normal(Vector3(-0.16, 0.0, 0.0))
	
	return (n1 + n2 + n3 + n4).normalized()

func _ray_cast_ground_normal(p_offset: Vector3) -> Vector3:
	var space = get_world().direct_space_state
	var from = global_transform.origin + p_offset
	var to = from + Vector3(0.0, -0.5, 0.0)
	var result = space.intersect_ray(from, to, [get_parent()])
	
	if result.empty():
		return Vector3.UP
	
	return result["normal"]
