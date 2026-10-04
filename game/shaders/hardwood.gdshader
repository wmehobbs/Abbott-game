shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform vec3 leaf : source_color = vec3(0.48, 0.26, 0.08);
uniform vec3 sun_leaf : source_color = vec3(0.78, 0.38, 0.10);
uniform vec3 shade : source_color = vec3(0.18, 0.12, 0.05);

varying vec3 world_p;
varying vec3 world_n;

void vertex() {
	world_p = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	world_n = MODEL_NORMAL_MATRIX * NORMAL;
}

void fragment() {
	float up = clamp(normalize(world_n).y * 0.5 + 0.5, 0.0, 1.0);
	float patch = sin(world_p.x * 0.85 + world_p.z * 0.62) * sin(world_p.y * 0.55);
	float speckle = sin(world_p.x * 3.4 + world_p.z * 2.8) * 0.5 + 0.5;
	float rust = sin(world_p.x * 0.21 + world_p.z * 0.17) * 0.5 + 0.5;
	float rust2 = sin(world_p.x * 0.09 + world_p.z * 0.13 + 1.4) * 0.5 + 0.5;
	vec3 col = mix(shade, leaf, up);
	col = mix(col, sun_leaf, clamp(up * 0.48 + patch * 0.16, 0.0, 1.0));
	col = mix(col, col * vec3(0.92, 0.62, 0.28), speckle * 0.20);
	col = mix(col, col * vec3(0.98, 0.32, 0.07), rust * 0.92);
	col = mix(col, col * vec3(0.82, 0.18, 0.05), rust2 * 0.70);
	ALBEDO = col;
	ROUGHNESS = mix(0.93, 0.76, up);
	METALLIC = 0.0;
}
