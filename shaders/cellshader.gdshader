shader_type spatial;

uniform sampler2D tex : source_color;
uniform vec3 shadow_color: source_color;
uniform float threshold = 0.01;

void fragment() {
	ALBEDO = texture(tex, UV).rgb;
}

void light() {
	float dotproduct = max(dot(NORMAL, LIGHT), 0.0); 
	float band = step(threshold, dotproduct); 
	vec3 toon_color = mix(shadow_color, ALBEDO, band); 
	DIFFUSE_LIGHT += toon_color * LIGHT_COLOR ;
}