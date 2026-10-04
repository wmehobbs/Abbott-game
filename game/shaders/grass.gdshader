shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform sampler2D albedo_tex : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform float uv_scale = 0.08;
uniform vec3 tint : source_color = vec3(0.55, 0.68, 0.38);
uniform vec3 shade : source_color = vec3(0.28, 0.40, 0.20);
uniform vec2 arena_half = vec2(15.24, 38.1);
uniform float apron = 4.4;

varying vec3 world_p;

void vertex() {
	world_p = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}

void fragment() {
	// Grass must not draw under the ring or the apron. That is the
	// green that used to punch through the sand and the kickboards.
	if (abs(world_p.x) < arena_half.x + apron + 2.18 && abs(world_p.z) < arena_half.y + apron + 2.18) {
		discard;
	}
	vec3 a = texture(albedo_tex, world_p.xz * uv_scale).rgb;
	vec3 b = texture(albedo_tex, world_p.xz * uv_scale * 0.37 + vec2(0.22, 0.61)).rgb;
	vec3 c = texture(albedo_tex, world_p.xz * uv_scale * 1.85 + vec2(0.71, 0.13)).rgb;
	vec3 col = mix(mix(a, b, 0.45), c, 0.18);
	float mottling = sin(world_p.x * 0.11) * sin(world_p.z * 0.09);
	float patch = sin(world_p.x * 0.27 + world_p.z * 0.19) * 0.5 + 0.5;
	float dry = sin(world_p.x * 0.07 + 1.7) * sin(world_p.z * 0.06 + 0.4) * 0.5 + 0.5;
	float clover = sin(world_p.x * 0.41 + world_p.z * 0.33) * 0.5 + 0.5;
	col = mix(col * tint, col * shade, clamp(0.30 + mottling * 0.32, 0.0, 0.76));
	col = mix(col, col * vec3(0.74, 0.94, 0.52), patch * 0.24);
	col = mix(col, col * vec3(0.82, 0.58, 0.28), dry * 0.62);
	col = mix(col, col * vec3(0.58, 0.88, 0.46), clover * 0.06);
	float far = clamp(length(world_p.xz) / 160.0, 0.0, 1.0);
	col = mix(col, col * vec3(0.90, 0.86, 0.70), far * 0.32);
	ALBEDO = col;
	ROUGHNESS = 0.92;
	METALLIC = 0.0;
}
