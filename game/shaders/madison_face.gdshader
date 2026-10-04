shader_type spatial;
render_mode cull_back, diffuse_burley, specular_schlick_ggx;

// Dedicated face plates (brows→chin). Spherical yaw keeps the eyes on the front.
uniform sampler2D front_tex : source_color, filter_linear_mipmap_anisotropic;
uniform sampler2D side_tex : source_color, filter_linear_mipmap_anisotropic;
uniform vec4 front_win = vec4(0.20, 0.26, 0.56, 0.50);
uniform vec4 side_win = vec4(0.10, 0.24, 0.46, 0.50);
uniform vec2 y_span = vec2(-0.068, 0.038);
uniform vec3 fallback_color : source_color = vec3(0.86, 0.72, 0.60);
uniform vec3 hair_color : source_color = vec3(0.62, 0.48, 0.32);

varying vec3 obj_pos;
varying vec3 obj_n;

void vertex() {
	obj_pos = VERTEX;
	obj_n = NORMAL;
}

bool is_reject(vec3 c) {
	float luma = dot(c, vec3(0.30, 0.59, 0.11));
	float sat = max(c.r, max(c.g, c.b)) - min(c.r, min(c.g, c.b));
	bool studio = sat < 0.055 && luma > 0.34 && luma < 0.66;
	bool helmet = luma < 0.14 && sat < 0.10;
	bool stock = luma > 0.86 && sat < 0.08;
	return studio || helmet || stock;
}

void fragment() {
	float yaw = atan(obj_pos.x, max(-obj_pos.z, 0.012));
	float u = clamp(yaw / 1.02 + 0.5, 0.0, 1.0);
	float v = clamp(1.0 - (obj_pos.y - y_span.x) / max(y_span.y - y_span.x, 0.001), 0.0, 1.0);
	vec2 uv_f = front_win.xy + front_win.zw * vec2(u, v);
	float su = clamp((obj_pos.z + 0.078) / 0.128, 0.0, 1.0);
	vec2 uv_s = side_win.xy + side_win.zw * vec2(su, v);
	vec3 f = texture(front_tex, uv_f).rgb;
	vec3 s = texture(side_tex, uv_s).rgb;
	if (is_reject(f)) {
		f = fallback_color;
	}
	if (is_reject(s)) {
		s = fallback_color;
	}
	vec3 n = normalize(obj_n);
	float fw = pow(max(-n.z, 0.0), 0.95);
	float sw = pow(abs(n.x), 1.18);
	float bw = pow(max(n.z, 0.0), 1.40);
	float sum = fw + sw + 0.10;
	vec3 col = (f * fw + s * sw) / sum;
	if (bw > 0.52 && fw < 0.22) {
		col = mix(col, hair_color, 0.78);
	} else if (abs(n.x) > 0.38 && fw > 0.18) {
		col = mix(col, fallback_color, 0.14);
	}
	float wrap = clamp(dot(n, vec3(0.10, 0.38, -0.94)) * 0.74 + 0.40, 0.0, 1.0);
	col *= mix(0.76, 1.16, wrap);
	float cheek = pow(max(-n.z, 0.0), 1.08) * (1.0 - abs(n.x) * 0.64);
	col = mix(col, col * vec3(1.22, 0.84, 0.78), cheek * 0.56);
	float jaw = pow(max(-n.y, 0.0), 1.28);
	col *= mix(1.0, 0.88, jaw * 0.42);
	ALBEDO = col;
	ROUGHNESS = 0.64;
	SPECULAR = 0.08;
}
