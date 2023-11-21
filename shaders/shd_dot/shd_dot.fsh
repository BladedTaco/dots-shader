//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;

uniform vec2 u_centre;
uniform vec2 u_vec;
uniform vec4 u_col;
uniform vec4 u_altcol;
uniform float u_size;
uniform float u_time;

///@func point_in_squircle(float px, float py, float cx, float cy, float rad, float power)
///@desc returns 1.0 or 0.0 depending on whether the point is in the squircle
float point_in_squircle(float px, float py, float cx, float cy, float rad, float power) {
	return float(pow(abs(px - cx)/rad, power) + pow(abs(py - cy)/rad, power) < 1.0);
}


void main() {
	//get rotated coordinates
	vec2 r_pos = vec2(0.0, 0.0);
	vec2 pos = vec2(v_vPosition.x - u_centre.x, v_vPosition.y - u_centre.y);
	float _dir = u_vec.x;
	//rotate coordinates
	r_pos.x = (pos.x)*cos(_dir) - (pos.y)*sin(_dir);
	r_pos.y = (pos.x)*sin(_dir) + (pos.y)*cos(_dir);
		
	//get scale
	float scale = r_pos.x/u_vec.y; // from 0.0 to 0.5 for each colour, 0.0 to 1.0 at this point
	
	//get time scaling
	r_pos.x += u_time*u_size*4.0;
	//r_pos.y += u_time*u_size*4.0 - float(mod(r_pos.x + u_size*0.0, u_size*4.0) < 2.0*u_size)*u_time*u_size*8.0;
	
	//non-branching conditionals
	float test = float(scale > 0.5);
	
	//handle side of midpoint
	vec4 outcol = mix(u_col, u_altcol, test);
	vec4 altcol = mix(u_altcol, u_col, test);
	r_pos.x += 2.0*u_size*test;
	scale = test*(1.0 - scale) + (1.0 - test)*scale;
	
	//check if in squircle
	test = float(point_in_squircle(
		mod(r_pos.x, 4.0*u_size),  //px
		mod(r_pos.y, 2.0*u_size),  //py
		u_size + 2.0*u_size*float(mod(r_pos.y, 4.0*u_size) < 2.0*u_size), //cx
		u_size, //cy
		scale*u_size*2.0, // radius
		2.0 + pow(0.9995*2.0*scale, 50.0)*1000.0) > 0.5 // power (squircliness)
	);
	
	//blend between circle and square
	outcol = mix(outcol, altcol, test);

	//output colour
    gl_FragColor = outcol;
}
