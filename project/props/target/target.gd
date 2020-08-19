tool
extends Spatial

export(float) var pole_height: float = 0.5 \
	setget set_pole_height, get_pole_height

var wibble_time = 0.0

func _ready() -> void:
	$TargetModel.connect("projectile_hit", self, "_on_projectile_hit")

func _process(p_delta: float) -> void:
	wibble_time = max(0.0, wibble_time - p_delta)
	_update_wibble_effect(wibble_time)

func set_pole_height(p_height: float) -> void:
	$TargetModel.pole_height = p_height

func get_pole_height() -> float:
	return $TargetModel.pole_height

func _on_projectile_hit(p_projectile: Spatial) -> void:
	wibble_time = min(2.0, wibble_time + 1.2)

func _update_wibble_effect(p_remaining: float) -> void:
	var new_basis = Basis()
	
	if p_remaining > 0.0:
		var factor = sin(p_remaining * 10.0)
		var angle = factor * p_remaining * 0.02
		new_basis *= Basis(Vector3.RIGHT, angle)
	
	$TargetModel.transform.basis = new_basis
