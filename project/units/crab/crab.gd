extends KinematicBody

var linear_velocity: Vector3 = Vector3.ZERO
var motion_direction: Vector3 = Vector3.ZERO

func _process(delta):
	motion_direction = _get_input_direction()
	$CrabSkin.motion_direction = motion_direction
	
	if Input.is_action_just_pressed("fire"):
		$GunSlot/WaterGun.fire()

func _physics_process(p_delta: float) -> void:
	var motion = motion_direction.normalized()
	linear_velocity.x = motion.x * 160.0 * p_delta
	linear_velocity.z = motion.z * 160.0 * p_delta
	
	linear_velocity += Vector3.DOWN * 70.0 * p_delta
	linear_velocity = move_and_slide_with_snap(linear_velocity, Vector3.DOWN, Vector3.UP, true, 4, deg2rad(70))

func _get_input_direction() -> Vector3:
	var xform = get_viewport().get_camera().global_transform
	
	var xasix = _get_input_x_axis()
	var yaxis = _get_input_y_axis()
	
	var input_direction = Vector3.ZERO
	input_direction += _normalize_xz(xform.basis.x) * xasix
	input_direction += _normalize_xz(xform.basis.z) * yaxis
	
	return input_direction.normalized()

func _get_input_x_axis() -> float:
	var r = Input.get_action_strength("move_right")
	var l = Input.get_action_strength("move_left")
	return r - l

func _get_input_y_axis() -> float:
	var d = Input.get_action_strength("move_down")
	var u = Input.get_action_strength("move_up")
	return d - u

func _normalize_xz(p_vector: Vector3) -> Vector3:
	return Vector3(p_vector.x, 0.0, p_vector.z).normalized()
