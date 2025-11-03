shader_type spatial;
//render_mode unshaded;

uniform vec3 baseColor: source_color;
uniform float t = 0.0;

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * (43758.5453 + t));
}

void fragment() {
	float c = rand(FRAGCOORD.xy);
	//ALBEDO = mix(vec3(c,c,c), baseColor, 0.5);
	ALBEDO = baseColor * c;
	EMISSION = baseColor * c * 10.0;
}
