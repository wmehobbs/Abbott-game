shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform sampler2D albedo_tex : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform sampler2D normal_tex : hint_normal, filter_linear_mipmap_anisotropic, repeat_enable;
uniform float uv_scale = 0.18;
uniform vec3 tint : source_color = vec3(0.86, 0.78, 0.62);
uniform vec2 arena_half = vec2(15.24, 38.1);

varying vec3 world_p;
varying vec3 world_n;

void vertex() {
	world_p = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	world_n = MODEL_NORMAL_MATRIX * NORMAL;
}

void fragment() {
	vec2 uv = world_p.xz * uv_scale;
	vec3 col = texture(albedo_tex, uv).rgb;
	col = mix(col, texture(albedo_tex, uv * 2.7 + vec2(0.17, 0.41)).rgb, 0.35);
	col = mix(col, texture(albedo_tex, uv * 0.55 + vec2(0.61, 0.19)).rgb, 0.18);
	float tracks = sin(world_p.x * 1.9 + world_p.z * 0.35) * 0.5 + 0.5;
	tracks *= sin(world_p.z * 2.4) * 0.5 + 0.5;
	float tracks2 = sin(world_p.x * 0.7 + world_p.z * 3.1) * 0.5 + 0.5;
	col *= mix(0.86, 1.10, tracks * 0.72 + tracks2 * 0.28);
	float rake = sin(world_p.z * 7.2 + world_p.x * 0.18) * 0.5 + 0.5;
	col *= mix(0.94, 1.04, rake);
	float hoop = sin(world_p.x * 4.2) * sin(world_p.z * 3.6);
	col *= mix(0.98, 1.02, hoop * 0.5 + 0.5);
	float edge_x = smoothstep(arena_half.x - 1.8, arena_half.x, abs(world_p.x));
	float edge_z = smoothstep(arena_half.y - 1.8, arena_half.y, abs(world_p.z));
	float edge = max(edge_x, edge_z);
	col = mix(col, col * vec3(0.70, 0.62, 0.48), edge * 0.50);
	float oval = clamp(length(world_p.xz / arena_half), 0.0, 1.0);
	float center = 1.0 - oval;
	// Worked middle of the ring is a shade darker and a little wetter.
	col = mix(col, col * vec3(0.78, 0.70, 0.55), center * 0.36);
	float track = 1.0 - clamp(abs(oval - 0.58) * 1.7, 0.0, 1.0);
	col = mix(col, col * vec3(0.72, 0.64, 0.48), track * 0.40);
	float rake2 = sin(world_p.z * 6.2 + world_p.x * 0.22) * 0.5 + 0.5;
	col *= mix(0.97, 1.03, rake2 * track);
	ALBEDO = col * tint;
	ROUGHNESS = mix(0.82, 0.96, 1.0 - center * 0.28 - track * 0.16);
	METALLIC = 0.0;
	SPECULAR = 0.10 + center * 0.08;
	NORMAL_MAP = texture(normal_tex, uv * 1.15).rgb;
	NORMAL_MAP_DEPTH = 0.72;
}
