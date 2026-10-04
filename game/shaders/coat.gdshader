shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform sampler2D side_tex : source_color, filter_linear_mipmap;
uniform sampler2D front_tex : source_color, filter_linear_mipmap;
uniform sampler2D coat_tex : source_color, filter_linear_mipmap, repeat_enable;
uniform vec3 chestnut : source_color = vec3(0.43, 0.21, 0.11);
uniform vec3 white_mark : source_color = vec3(0.93, 0.89, 0.82);
uniform vec3 pink_muzzle : source_color = vec3(0.86, 0.60, 0.54);
uniform float coat_scale = 4.2;
uniform float side_strength = 0.82;
uniform float front_strength = 0.9;

varying vec3 obj_pos;
varying vec3 obj_n;

void vertex() {
	obj_pos = VERTEX;
	obj_n = NORMAL;
}

void fragment() {
	vec3 n = normalize(obj_n);
	vec2 side_uv = vec2(
		clamp((obj_pos.z + 1.25) / 2.55, 0.02, 0.98),
		clamp(1.0 - (obj_pos.y + 0.02) / 1.72, 0.02, 0.98)
	);
	if (n.x < 0.0) {
		side_uv.x = 1.0 - side_uv.x;
	}
	vec4 side_s = texture(side_tex, side_uv);
	vec2 front_uv = vec2(
		clamp(obj_pos.x * 1.35 + 0.5, 0.0, 1.0),
		clamp(1.0 - (obj_pos.y - 0.55) / 1.05, 0.0, 1.0)
	);
	vec4 front_s = texture(front_tex, front_uv);
	vec3 tri = texture(coat_tex, obj_pos.zy * coat_scale).rgb;
	tri = mix(tri, texture(coat_tex, obj_pos.xy * coat_scale).rgb, abs(n.z));
	vec3 base = mix(chestnut, tri, 0.55);

	float side_mask = side_s.a;
	if (side_mask < 0.05) {
		side_mask = smoothstep(0.12, 0.28, length(side_s.rgb - vec3(0.47)));
	}
	vec3 col = mix(base, side_s.rgb, side_mask * side_strength);

	float front_w = smoothstep(0.15, 0.55, -n.z) * step(obj_pos.z, -0.55);
	float front_mask = front_s.a;
	if (front_mask < 0.05) {
		front_mask = smoothstep(0.12, 0.3, length(front_s.rgb - vec3(0.47)));
	}
	col = mix(col, front_s.rgb, front_w * front_mask * front_strength);

	// Vertex color: r = white, g = pink muzzle, b = dark points
	col = mix(col, white_mark, COLOR.r);
	col = mix(col, pink_muzzle, COLOR.g);
	col = mix(col, col * 0.35, COLOR.b);

	ALBEDO = col;
	ROUGHNESS = 0.42 + COLOR.g * 0.2;
	METALLIC = 0.0;
	SPECULAR = 0.35;
	RIM = 0.18 + COLOR.g * 0.25;
	RIM_TINT = 0.4;
}
