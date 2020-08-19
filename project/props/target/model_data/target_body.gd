extends StaticBody

func projectile_hit(p_projectile: Spatial) -> void:
	var root_parent = get_node("../..")
	root_parent.emit_signal("projectile_hit", p_projectile)
