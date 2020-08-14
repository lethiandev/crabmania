extends KinematicBody

var linear_velocity: Vector3 = Vector3.ZERO
var motion_direction: Vector3 = Vector3.ZERO

func _process(delta):
	var xform = global_transform
	
	motion_direction = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		motion_direction -= xform.basis.z
	if Input.is_action_pressed("ui_down"):
		motion_direction += xform.basis.z
	if Input.is_action_pressed("ui_right"):
		motion_direction -= xform.basis.x
	if Input.is_action_pressed("ui_left"):
		motion_direction += xform.basis.x

func _physics_process(p_delta: float) -> void:
	var motion = Vector3(motion_direction.x, 0.0, motion_direction.z).normalized()
	linear_velocity.x = motion.x * 100.0 * p_delta
	linear_velocity.z = motion.z * 100.0 * p_delta
	
	linear_velocity += Vector3.DOWN * 2.0 * p_delta
	linear_velocity = move_and_slide_with_snap(linear_velocity, Vector3.DOWN, Vector3.UP, true, 4, deg2rad(70))
