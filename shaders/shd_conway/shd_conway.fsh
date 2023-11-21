//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform sampler2D s_base;
uniform vec2 u_base;

vec4 get_pixel(float x_pos, float y_pos) {
	return texture2D(s_base, vec2(x_pos, y_pos)/u_base);
}

//vec4 get_pixel(vec2 pos) {
//	return texture2D(s_base, pos/u_base);
//}

float pixel_filled(vec4 pix) {
	return float((pix.r + pix.g + pix.b) * pix.a > 0.05);
}

float get_neighbours(float x_pos, float y_pos) {
	return  pixel_filled(get_pixel(x_pos + 1.0, y_pos - 1.0))	+	
			pixel_filled(get_pixel(x_pos + 1.0, y_pos	   ))	+
			pixel_filled(get_pixel(x_pos + 1.0, y_pos + 1.0))	+
			pixel_filled(get_pixel(x_pos - 1.0, y_pos - 1.0))	+
			pixel_filled(get_pixel(x_pos - 1.0, y_pos	   ))	+
			pixel_filled(get_pixel(x_pos - 1.0, y_pos + 1.0))	+
			pixel_filled(get_pixel(x_pos      , y_pos - 1.0))	+
			pixel_filled(get_pixel(x_pos      , y_pos + 1.0));	
}

void main()
{
	
	vec4 col = get_pixel(v_vPosition.x, v_vPosition.y);
	float neighbours = get_neighbours(v_vPosition.x, v_vPosition.y);
	float living = pixel_filled(col);

	col.a = float(neighbours > 1.5) * float(neighbours < 3.5) * living;	
	col.a += float(neighbours > 2.5) * float(neighbours < 3.5) * (1.0 - living);
	
	col.r = col.a;
	col.g = col.a;
	col.b = col.a;
	col.a = 1.0;
	
    gl_FragColor = col;
}
