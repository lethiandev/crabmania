extends Area

var caster: Node = null
var linear_velocity: Vector3 = Vector3.FORWARD

func _ready():
	connect("body_entered", self, "_on_body_entered")

func _physics_process(p_delta: float) -> void:
	linear_velocity += Vector3.DOWN * 15.0 * p_delta
	global_translate(linear_velocity * p_delta)

func _on_body_entered(p_body: Node) -> void:
	if caster != p_body and has_node("CPUParticles"):
		var emitter = $CPUParticles
		remove_child(emitter)
		get_parent().add_child(emitter)
		emitter.global_transform = global_transform
		emitter.emitting = true
		queue_free()

func setup_velocity(p_speed: float) -> void:
	var xform_basis = global_transform.basis
	linear_velocity = xform_basis.z * p_speed
