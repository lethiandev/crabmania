extends Spatial

const Projectile = preload("./projectile.tscn")

var last_cursor: Vector2 = Vector2.ZERO

func _input(p_event: InputEvent) -> void:
	if p_event is InputEventMouseMotion:
		last_cursor = p_event.position

func _process(p_delta: float) -> void:
	var target = _cast_screen_ray(last_cursor)
	if target != Vector3.ZERO:
		_update_look_target(target)

func fire() -> void:
	var projectile = Projectile.instance()
	_add_projectile(projectile)
	
	projectile.caster = get_node("../..")
	projectile.global_transform = get_hotspot_xform()
	projectile.setup_velocity(8.0)

func _add_projectile(p_projectile: Node) -> void:
	var projectiles_bag = _get_projectiles_bag()
	projectiles_bag.add_child(p_projectile)

func _get_projectiles_bag() -> Node:
	return get_tree().get_nodes_in_group("projectiles")[0] as Node

func _cast_screen_ray(p_cursor: Vector2) -> Vector3:
	var camera = get_viewport().get_camera()
	var space = get_world().get_direct_space_state()
	var from = camera.project_ray_origin(p_cursor)
	var to = camera.project_ray_normal(p_cursor) * 100.0
	
	var result = space.intersect_ray(from, to, [])
	return Vector3.ZERO if result.empty() else result["position"] 

func _update_look_target(p_target: Vector3) -> void:
	$WaterGunSkin.target = p_target

func get_hotspot_xform() -> Transform:
	var hotspot = $WaterGunSkin/Armature/Skeleton/BoneAttachment/Position3D
	return hotspot.global_transform
