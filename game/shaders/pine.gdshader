shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform vec3 needle : source_color = vec3(0.10, 0.16, 0.08);
uniform vec3 sun_leaf : source_color = vec3(0.28, 0.24, 0.10);

varying vec3 world_p;
varying vec3 world_n;

void vertex() {
	world_p = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	world_n = MODEL_NORMAL_MATRIX * NORMAL;
}

void fragment() {
	float up = clamp(normalize(world_n).y * 0.5 + 0.5, 0.0, 1.0);
	float mottling = sin(world_p.x * 0.7 + world_p.y * 0.4) * 0.5 + 0.5;
	float cool = sin(world_p.z * 0.35) * 0.5 + 0.5;
	float needles = sin(world_p.x * 4.2 + world_p.y * 3.1) * sin(world_p.z * 3.6);
	float needles2 = sin(world_p.x * 7.8 + world_p.z * 6.1) * 0.5 + 0.5;
	vec3 col = mix(needle, sun_leaf, up * 0.42 + mottling * 0.12);
	col = mix(col, col * vec3(0.70, 0.78, 0.72), cool * 0.10);
	col = mix(col, col * vec3(0.62, 0.70, 0.48), needles * 0.5 + 0.5);
	col = mix(col, col * vec3(0.52, 0.58, 0.36), needles2 * 0.22);
	float tip = sin(world_p.x * 0.19 + world_p.z * 0.14) * 0.5 + 0.5;
	col = mix(col, col * vec3(0.78, 0.74, 0.52), tip * 0.22);
	col = mix(col * vec3(0.22, 0.26, 0.16), col, up);
	ALBEDO = col;
	ROUGHNESS = mix(0.96, 0.80, up);
	METALLIC = 0.0;
}
