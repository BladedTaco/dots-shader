
// draw the shader effect
shader.set()

draw_set_colour(image_blend)
draw_rectangle(0, 0, room_width, room_height, false)

shader.reset()

// draw each of the tokens
for (var i = 0; i < array_length(tokens); i++) {
	tokens[i].update();
	tokens[i].draw();	
}