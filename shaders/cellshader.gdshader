shader_type spatial;

uniform sampler2D tex : source_color;
uniform vec3 shadow_color: source_color;
uniform float threshold = 0.01;
uniform vec4 car_color : source_color = vec4(1.0, 0.929, 0.384, 1.0);
uniform vec4 car_color_dark : source_color = vec4(0.871, 0.737, 0.373, 1.0);

void fragment() {
    vec4 texture_color = texture(tex, UV);
    
    float tolerance = 0.1;
    
    // #FFEC62 (main yellow)
    vec3 target_light = vec3(1.0, 0.9255, 0.3843);
    float diff_light = length(texture_color.rgb - target_light);
    vec3 final_color = mix(texture_color.rgb, car_color.rgb, step(diff_light, tolerance));
    
    // #DEBC5F (dark yellow)
    vec3 target_dark = vec3(0.871, 0.737, 0.373);
    float diff_dark = length(final_color - target_dark);
    final_color = mix(final_color, car_color_dark.rgb, step(diff_dark, tolerance));
    
    ALBEDO = final_color;
}

void light() {
	float dotproduct = max(dot(NORMAL, LIGHT), 0.0); 
	float band = smoothstep(threshold, threshold+0.1, dotproduct); 
	vec3 toon_color = mix(shadow_color, ALBEDO, band); 
	DIFFUSE_LIGHT += toon_color * LIGHT_COLOR ;
}