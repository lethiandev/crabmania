tool
extends Spatial

signal projectile_hit(projectile)

export(float) var pole_height: float = 0.5 \
	setget set_pole_height, get_pole_height

func set_pole_height(p_height: float) -> void:
	$Target.transform.origin.y = p_height
	$Pole.transform.basis = _get_pole_scale(p_height)
	pole_height = p_height

func get_pole_height() -> float:
	return pole_height

func _get_pole_scale(p_height: float) -> Basis:
	var scale_basis = Basis()
	scale_basis.y *= (p_height - 0.25) / 0.25;
	return scale_basis
