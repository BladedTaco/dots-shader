
tex_surf.update()


draw_set_colour(image_blend)

if !(keyboard_check(vk_shift)) {
	shader.set()
	alt_surf.set()

	draw_rectangle(1, 1, tex_surf.width - 2, tex_surf.height - 2, false)

	alt_surf.reset()
	shader.reset()
	
	//update
	tex_surf.set()
	alt_surf.draw() 
	tex_surf.reset()
	
}

tex_surf.draw();

var _scl = max(1, tokens[1].y / 50)
if (_scl > 1) {
	tex_surf.draw_scaled(_scl, -_scl*tokens[0].x, -_scl*tokens[0].y);	
}


//tex_surf.draw()

//draw_set_colour(c_white)
//draw_text(100, 100, tokens[0].x/20)
//draw_text(100, 150, tokens[0].y/20)

// draw each of the tokens
for (var i = 0; i < array_length(tokens); i++) {
	tokens[i].update();
	tokens[i].draw();	
}

//surface_set_target(tex_surf)

//draw_surface(application_surface, 0, 0)

//surface_reset_target()

game_set_speed(5 + tokens[2].x, gamespeed_fps)
