extends Spatial

func _process(p_delta: float) -> void:
	var bone_idx = $Armature/Skeleton.find_bone("arm")
	var xform = $Armature/Skeleton.get_bone_pose(bone_idx)
	var new_xform = xform.rotated(Vector3.FORWARD, p_delta)
	
	$Armature/Skeleton.set_bone_pose(bone_idx, new_xform)
