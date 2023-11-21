draw_set_font(fnt_main)


// define the uniform editors
tokens = [
	new Token(800, 600),//.bound(0, 0, room_width, room_height).set_kinematic().set_text("Stop"), 
	new Token(400, 300),//.bound(0, 0, room_width, room_height).set_kinematic().set_text("Start"), 
	new Token(room_width - 50, 100),//.bound(room_width - 50, 0, room_width - 50, room_height).set_kinematic().set_text("Size"),
	new Token(200, 200)//.bound(room_width - 100, 0, room_width - 100, room_height).set_kinematic().set_text("Speed")
];

tokens[0].bound(0, 0, room_width, room_height).set_kinematic().set_text("Stop");
tokens[1].bound(0, 0, room_width, room_height).set_kinematic().set_text("Start"); 
tokens[2].bound(room_width - 50, 0, room_width - 50, room_height).set_kinematic().set_text("Size");
tokens[3].bound(room_width - 100, 0, room_width - 100, room_height).set_kinematic().set_text("Speed");

// define the shader
shader = new Shader(shd_dot, [
	// vec2 centre point
	new Uniform(
		"u_centre",
		shader_set_uniform_f_array, 
		function () { return [tokens[0].x, tokens[0].y] } 
	),  
	// vec2 [dir, len]
	new Uniform(
		"u_vec",		
		shader_set_uniform_f_array, 
		function () { return [
			degtorad(point_direction(tokens[0].x, tokens[0].y, tokens[1].x, tokens[1].y)),
			point_distance(tokens[0].x, tokens[0].y, tokens[1].x, tokens[1].y)
		] } 
	), 
	// vec4 colourtop
	new Uniform(
		"u_col",		
		shader_set_uniform_f_array, 
		[1.0, 0.2, 0.4, 1.0] 
	),   
	// vec4 colourbottom
	new Uniform(
		"u_altcol",		
		shader_set_uniform_f_array, 
		[0.0, 0.2, 0.4, 1.0] 
	),   
	// float size
	new Uniform(
		"u_size",		
		shader_set_uniform_f, 
		function () { return 1 + tokens[2].y/25 }
	),
	// float time
	new Uniform(
		"u_time",
		shader_set_uniform_f,
		//function () { static time = 0; return floor(tokens[3].y/100)*(++time % 60)/60 }
		function () {
			static time = 0; 
			time = frac(time + tokens[3].y/100/60);
			return time;
			//return floor(tokens[3].y/100)*(++time % 60)/60 
		}
	)
]);

//get a random colour
image_blend = make_colour_hsv(random(255), 155 + random(100), random(200) + 30)