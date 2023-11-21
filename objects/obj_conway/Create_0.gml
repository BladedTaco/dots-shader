gpu_set_tex_filter(false)

tex_surf = new Surface(room_width, room_height).set_update( function () {
	var _scl = max(1, tokens[1].y / 50)
	var _x = (mouse_x - _scl + _scl*tokens[0].x)/_scl
	var _y = (mouse_y - _scl + _scl*tokens[0].y)/_scl
	
	if (tex_surf.bounds.selected(mb_left)) {
		draw_set_color(image_blend)
		draw_point(_x, _y)	
	}
	if (tex_surf.bounds.pressed(mb_right)) {
		draw_set_colour(c_black)
		draw_point(_x, _y)	
	}
	if (keyboard_check_pressed(ord("G"))) {
		draw_sprite(spr_glidergun, 0, _x, _y)
	}
	if (keyboard_check_pressed(ord("H"))) {
		draw_sprite_ext(spr_glidergun, 0, _x, _y, -1, 1, 0, c_white, 1)
	}
})

alt_surf = new Surface(room_width, room_height)

// define the shader
shader = new Shader(shd_conway, [
	// sampler2D s_base
	new Uniform(
		"s_base",
		texture_set_stage, 
		tex_surf.get_texture()
	),
	// vec2 u_base
	new Uniform(
		"u_base",
		shader_set_uniform_f_array,
		[tex_surf.width, tex_surf.height]
	)
])

// define the uniform editors
tokens = [
	new Token(0, 0).bound(0, 0, room_width, room_height),
	new Token(0, 0).bound(0, 0, 0, room_height),
	new Token(0, 0).bound(0, room_height, room_width, room_height)
]

//get a random colour
//image_blend = make_colour_hsv(random(255), 155 + random(100), random(200) + 30)
image_blend = c_white

game_set_speed(10 + tokens[2].x/10, gamespeed_fps)