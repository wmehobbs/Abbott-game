shader_type spatial;
render_mode cull_back, diffuse_burley, specular_schlick_ggx;

uniform sampler2D front_tex : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D side_tex : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D back_tex : source_color, filter_linear_mipmap_anisotropic;
uniform vec4 tint : source_color = vec4(1.0);
uniform vec2 v_range = vec2(0.0, 1.0);
uniform vec2 y_range = vec2(0.0, 1.0);
uniform vec2 u_range = vec2(0.32, 0.68);
uniform vec2 side_u_range = vec2(0.42, 0.60);
uniform float width_scale = 3.3;
uniform float depth_scale = 3.6;
uniform vec3 fallback_color : source_color = vec3(0.18, 0.14, 0.11);
uniform float key_sat = 0.055;
uniform float key_luma_min = 0.38;
uniform float key_luma_max = 0.62;

varying vec3 obj_pos;
varying vec3 obj_n;

void vertex() {
	obj_pos = VERTEX;
	obj_n = NORMAL;
}

bool is_studio(vec3 c) {
	float luma = dot(c, vec3(0.30, 0.59, 0.11));
	float sat = max(c.r, max(c.g, c.b)) - min(c.r, min(c.g, c.b));
	return sat < key_sat && luma > key_luma_min && luma < key_luma_max;
}

void fragment() {
	float y01 = clamp((obj_pos.y - y_range.x) / max(y_range.y - y_range.x, 0.001), 0.0, 1.0);
	float v = mix(v_range.x, v_range.y, 1.0 - y01);
	float u01 = clamp(obj_pos.x * width_scale + 0.5, 0.0, 1.0);
	float s01 = clamp(-obj_pos.z * depth_scale + 0.5, 0.0, 1.0);
	vec2 uv_f = vec2(mix(u_range.x, u_range.y, u01), clamp(v, 0.0, 1.0));
	vec2 uv_s = vec2(mix(side_u_range.x, side_u_range.y, s01), clamp(v, 0.0, 1.0));
	vec2 uv_b = vec2(mix(u_range.y, u_range.x, u01), clamp(v, 0.0, 1.0));
	vec3 f = texture(front_tex, uv_f).rgb;
	vec3 s = texture(side_tex, uv_s).rgb;
	vec3 b = texture(back_tex, uv_b).rgb;
	if (is_studio(f)) {
		f = fallback_color;
	}
	if (is_studio(s)) {
		s = fallback_color;
	}
	if (is_studio(b)) {
		b = fallback_color;
	}
	vec3 n = normalize(obj_n);
	float fw = pow(max(-n.z, 0.0), 1.25);
	float bw = pow(max(n.z, 0.0), 1.25);
	float sw = pow(abs(n.x), 1.25);
	float sum = fw + bw + sw + 0.0001;
	vec3 col = (f * fw + b * bw + s * sw) / sum;
	float weave = sin(obj_pos.x * 380.0) * sin(obj_pos.y * 310.0);
	float twill = sin(obj_pos.x * 210.0 + obj_pos.y * 210.0);
	col *= mix(0.70, 1.10, weave * 0.5 + 0.5);
	col *= mix(0.76, 1.08, twill * 0.5 + 0.5);
	ALBEDO = col * tint.rgb;
	ROUGHNESS = 0.98;
	SPECULAR = 0.012;
}
