shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

// WhiteHorse bind verts after import: X = width, Y = length (muzzle negative),
// Z = height (hooves ~0, ears ~2.18). bind_s is (mesh AABB z) / 0.048239.
// Divide by (bind_s / 46.64) so these meter thresholds survive import changes.

uniform sampler2D face_tex : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D stall_tex : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D coat_tex : source_color, filter_linear_mipmap_anisotropic, repeat_enable;
uniform int part = 0;
uniform float bind_s = 1.0;

varying vec3 p;

void vertex() {
	p = VERTEX;
}

vec3 meters(vec3 v) {
	float meter = max(bind_s / 46.64, 0.0001);
	return v / meter;
}

vec3 sample_coat(vec3 m) {
	vec2 uv = vec2(m.x * 1.45 + m.y * 0.22, m.z * 1.22 + m.y * 0.14);
	vec3 tile = texture(coat_tex, uv).rgb;
	vec3 copper = vec3(0.38, 0.12, 0.045);
	vec3 dark = vec3(0.09, 0.035, 0.018);
	float shade = clamp(0.22 + m.z * 0.28 - abs(m.x) * 0.30, 0.0, 1.0);
	vec3 base = mix(dark, copper, shade);
	if (m.z < 0.88 && abs(m.x) < 0.28) {
		base = mix(base, vec3(0.22, 0.08, 0.04), 0.28);
	}
	return mix(base, tile * vec3(0.48, 0.22, 0.10), 0.10);
}

vec3 sample_face(vec3 m) {
	// Map only the horse's face in the stall photo — not the boards.
	float u = clamp((m.x + 0.20) / 0.40, 0.0, 1.0);
	float v = clamp((-m.y - 0.88) / 0.92, 0.0, 1.0);
	return texture(face_tex, vec2(0.30 + u * 0.40, 0.14 + v * 0.82)).rgb;
}

bool face_is_wood(vec3 face) {
	float luma = dot(face, vec3(0.30, 0.59, 0.11));
	float mx = max(face.r, max(face.g, face.b));
	float mn = min(face.r, min(face.g, face.b));
	float sat = mx - mn;
	// Stall wood is dull mid-brown. Do not reject dark chestnut or the blaze.
	return luma > 0.16 && luma < 0.42 && sat < 0.10 && face.r < face.g + 0.06;
}

void fragment() {
	vec3 m = meters(p);
	vec3 coat = sample_coat(m);
	vec3 face = sample_face(m);
	vec3 flax = vec3(0.96, 0.90, 0.76);
	vec3 flax_deep = vec3(0.82, 0.68, 0.44);
	vec3 dark_hair = vec3(0.10, 0.06, 0.04);
	vec3 ear_dark = vec3(0.09, 0.05, 0.03);
	vec3 pink = vec3(0.90, 0.72, 0.64);
	vec3 white = vec3(0.94, 0.91, 0.86);
	vec3 hoofc = vec3(0.12, 0.07, 0.04);
	vec3 eye = vec3(0.04, 0.025, 0.02);
	bool on_head = m.y < -0.86 && m.z > 1.10 && abs(m.x) < 0.30;
	bool left_hind = m.x > 0.07 && m.y > 0.10 && m.z < 0.58;
	bool right_fore = m.x < -0.07 && m.y < -0.55 && m.z < 0.50;
	bool dorsal = abs(m.x) < 0.042 && m.z > 0.95 && m.z < 1.55 && m.y > -0.55 && m.y < 0.65;
	bool lower_leg = m.z < 0.48 && abs(m.y) > 0.35;
	bool ear = part == 1 && m.z > 1.68 && abs(m.x) > 0.028 && m.y < -1.04;
	bool forelock = part == 1 && m.y < -1.06 && m.z > 1.40 && abs(m.x) < 0.14;
	bool mane = part == 1 && m.z > 1.40 && abs(m.x) < 0.085 && m.y > -1.12 && m.y < 0.58;
	bool tail = part == 1 && m.y > 0.52 && m.z > 0.72;

	vec3 col = coat;
	float rough = 0.52;
	float spec = 0.28;

	if (part == 4 || part == 5) {
		col = eye;
		rough = 0.16;
		spec = 0.55;
	} else if (part == 3) {
		col = hoofc;
		rough = 0.62;
	} else if (part == 1) {
		if (ear) {
			col = ear_dark;
		} else if (forelock) {
			col = mix(flax, white, 0.86);
		} else if (mane || tail) {
			float streak = 0.5 + 0.5 * sin(m.y * 28.0 + m.x * 42.0);
			col = mix(flax, white, clamp((m.z - 1.18) * 1.2, 0.35, 0.98) * mix(0.70, 1.08, streak));
		} else {
			col = mix(dark_hair, flax_deep, 0.16);
		}
		rough = 0.80;
		spec = 0.10;
	} else if (part == 2) {
		col = mix(pink, face, 0.40);
		rough = 0.48;
	} else if (on_head) {
		float u = clamp((m.x + 0.20) / 0.40, 0.0, 1.0);
		float v = clamp((-m.y - 0.88) / 0.92, 0.0, 1.0);
		float edge = max(abs(u - 0.5) * 2.0, abs(v - 0.5) * 2.0);
		if (face_is_wood(face) || edge > 0.96) {
			col = mix(coat, face, 0.10);
		} else {
			col = face;
		}
		float blaze = 1.0 - smoothstep(0.006, 0.118, abs(m.x));
		float star = 1.0 - smoothstep(0.018, 0.14, length(vec2(m.x, m.z - 1.52)));
		float snip = 1.0 - smoothstep(0.02, 0.10, length(vec2(m.x, m.y + 1.42)));
		col = mix(col, white, clamp(blaze * 1.15 + star * 0.92 + snip * 0.55, 0.0, 1.0));
		rough = 0.48;
	} else if (left_hind || right_fore) {
		col = mix(white, coat, 0.05);
		rough = 0.56;
	} else {
		if (dorsal) {
			col *= vec3(0.62, 0.52, 0.42);
		}
		if (lower_leg) {
			col *= vec3(0.68, 0.64, 0.60);
		}
		float dapple = sin(m.x * 8.0 + m.y * 5.0) * sin(m.z * 6.5 + m.y * 3.5);
		col *= mix(0.95, 1.04, dapple * 0.5 + 0.5);
		float sheen = pow(clamp(1.0 - abs(dot(NORMAL, VIEW)), 0.0, 1.0), 2.4);
		rough = mix(0.46, 0.64, 1.0 - sheen * 0.40);
		spec = 0.20 + sheen * 0.16;
	}

	ALBEDO = col;
	ROUGHNESS = rough;
	METALLIC = 0.0;
	SPECULAR = spec;
}
