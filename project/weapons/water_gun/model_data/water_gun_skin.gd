extends Spatial

var target: Vector3 = Vector3.ZERO

func _process(p_delta: float) -> void:
	_update_rotation(target)

func _update_rotation(p_target: Vector3) -> void:
	var look_normal = (global_transform.origin - p_target).normalized()
	var bone_basis = Transform().looking_at(look_normal, Vector3.UP).basis
	
	# Clamp rotation
	var euler = bone_basis.get_euler()
	euler.x = clamp(euler.x, -deg2rad(45), deg2rad(10))
	bone_basis = Basis(euler)
	
	# Fix gun orientation
	bone_basis *= Basis(Vector3.RIGHT, PI * 0.5)
	
	_update_bone_rotation("arm", bone_basis)

func _update_bone_rotation(p_bone: String, p_basis: Basis) -> void:
	var bone_idx = $Armature/Skeleton.find_bone(p_bone)
	var bone_xform = $Armature/Skeleton.get_bone_global_pose(bone_idx)
	bone_xform.basis = bone_xform.basis.slerp(p_basis, 0.1)
	
	$Armature/Skeleton.set_bone_global_pose_override(bone_idx, bone_xform, 1.0)
