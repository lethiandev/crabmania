shader_type spatial;
render_mode depth_draw_never, depth_test_disable, shadows_disabled;

uniform sampler2D noise_texture;
varying float wave_height;

void vertex() {
	// Make mesh waving like sea waves
	vec2 wave_uv = UV * vec2(1.6, 0.5) + vec2(TIME) * vec2(0.01, 0.02);
	float height = texture(noise_texture, wave_uv).r - 0.5;
	
	VERTEX.y += height;
	wave_height = height;
}

void fragment() {
	// Sea basic colour
	ALBEDO = vec3(0.2, 0.5, 1.0);
	
	// Read data from depth texture
	float depth = textureLod(DEPTH_TEXTURE, SCREEN_UV, 0.0).r;
	vec4 upos = INV_PROJECTION_MATRIX * vec4(SCREEN_UV * 2.0 - 1.0, depth * 2.0 - 1.0, 1.0);
	vec3 pixel_position = upos.xyz / upos.w;
	float pixel_depth = VERTEX.z - pixel_position.z;
	
	// Apply alpha on sea surface
	ALPHA_SCISSOR = 0.05;
	ALPHA = smoothstep(0.0, 0.01, pixel_depth) * 0.9;
	
	// Apply surface edges colouring
	float mix_value = smoothstep(0.075, 0.09, pixel_depth);
	mix_value -= smoothstep(0.1, 0.101, wave_height);
	ALBEDO = mix(vec3(0.75, 0.9, 1.0), ALBEDO, clamp(mix_value, 0.0, 1.0));
}
