shader_type spatial;
render_mode unshaded;

uniform bool enable_pixelation = false;
uniform bool enable_fog = false;
uniform bool enable_quantization = false;

uniform float pixel_size = 4; //resolution must be divisible by pixel_size
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_linear_mipmap;
uniform sampler2D DEPTH_TEXTURE: source_color, hint_depth_texture;

uniform vec3 fog_color: source_color;
uniform float fog_start = 25.0;    // Distance where fog begins
uniform float fog_end = 300.0;     // Distance where fog becomes fully opaque
uniform float colors = 16.0;


void fragment() {
	vec2 fragcoord = FRAGCOORD.xy;
	vec2 pixel_screen_size = 1.0 / VIEWPORT_SIZE;
	vec2 pixel_coord;
	if (enable_pixelation){
		pixel_coord = round(fragcoord / pixel_size) * pixel_size;
	}else{
		pixel_coord = fragcoord;
	}

	float depth = texture(DEPTH_TEXTURE, pixel_coord * pixel_screen_size).x;
	vec3 ndc = vec3(pixel_coord * pixel_screen_size * 2.0 - 1.0, depth);
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = -view.z;

	 // Sample screen texture with NEAREST filtering for crisp pixels
    vec3 original_color = textureLod(SCREEN_TEXTURE, pixel_coord * pixel_screen_size, 0.0).rgb;

	//get the fog
	float fog_factor = clamp((linear_depth - fog_start) / (fog_end - fog_start), 0.0, 1.0);

	//vec3 quantized = quantized_color(original_color);
	vec3 final_color = mix(original_color, fog_color, fog_factor * float(enable_fog));

	vec3 quantized_color;
	if (enable_quantization){
		quantized_color = round(final_color * colors) / colors;
	}else{
		quantized_color = final_color;
	}
	ALBEDO = quantized_color;
}