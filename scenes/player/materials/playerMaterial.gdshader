shader_type spatial;
render_mode unshaded;

uniform vec3 baseColor: source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}


void fragment() {
	float c = rand(FRAGCOORD.xy);
	ALBEDO = mix(vec3(c,c,c), baseColor, 0.5);
}
