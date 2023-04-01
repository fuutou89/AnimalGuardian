shader_type spatial;
uniform sampler2D wind_noise_sampler;
uniform sampler2D albedo_sampler : source_color;
void vertex() {
	float wind_value = texture(wind_noise_sampler, (UV.y) + VERTEX.y + NODE_POSITION_WORLD.xz + vec2(0.0, (TIME * 0.2))).x;
	VERTEX.xz += (wind_value) * 0.05 * UV.y;
}

void fragment() {
	// Place fragment code here.
	vec4 albedo = texture(albedo_sampler, UV);
	ALBEDO = albedo.rgb;
	ALPHA = albedo.a;
	ALPHA_SCISSOR_THRESHOLD = 1.0;
}
