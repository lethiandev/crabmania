tool
extends Spatial

const COLOR_PRESETS = [
	preload("./model_data/bucket_blue.material.tres"),
	preload("./model_data/bucket_red.material.tres"),
	preload("./model_data/bucket_green.material.tres"),
]

export(int, "Blue", "Red", "Green") var color_preset \
	setget set_color_preset, get_color_preset

export(float) var handle_rotation = 0.0 \
	setget set_handle_rotation, get_handle_rotation

func set_color_preset(p_preset: int) -> void:
	color_preset = p_preset
	_update_color_preset()

func get_color_preset() -> int:
	return color_preset

func set_handle_rotation(p_rotation: float) -> void:
	$BucketModel/Handle.rotation.x = p_rotation

func get_handle_rotation() -> float:
	return $BucketModel/Handle.rotation.x

func _update_color_preset() -> void:
	var preset_material = COLOR_PRESETS[color_preset]
	$BucketModel/Bucket.material_override = preset_material
