shader_type spatial;

varying float height;

void vertex() {
	vec4 world_vertex = WORLD_MATRIX * vec4(VERTEX, 1.0);
	height = world_vertex.y;
}

void fragment() {
	float factor = max(0.9, smoothstep(0.3, 0.4, height));
	ALBEDO = vec3(1.0, 0.78, 0.0) * factor;
}
