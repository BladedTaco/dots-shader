///@func Token(x, y)
///@param {real} x - the x position to start at
///@param {real} y - the y position to start at
///@desc constructs a Token
function Token(_x, _y) constructor {
	x = _x;
	y = _y;
	image_blend = make_colour_hsv(random(255), 155 + random(100), random(150) + 30);
	selected = false;
	bounded = false;
	bounds = [];
	kinematic = false;
	last_x = 0;
	last_y = 0;
	text = "";
	
	///@func update()
	///@desc handles all the step code of the Token
	static update = function () {
		if (selected) { // being moved
			//check for release
			if (mouse_check_button_released(mb_left)) {
				selected = false	
				last_x = x - last_x
				last_y = y - last_y
				update();
			} else {
				//update last position
				last_x = x
				last_y = y
				
				//move with mouse
				x = window_mouse_get_x()
				y = window_mouse_get_y()
				
				//make sure it remains in boundaries if they exist
				if (bounded) {
					x = clamp(x, bounds[0], bounds[2])
					y = clamp(y, bounds[1], bounds[3])
				}
			}
		} else { // not being moved
			// check if it should be
			if (mouse_check_button_pressed(mb_left)) {
				if (point_in_circle(window_mouse_get_x(), window_mouse_get_y(), x, y, 20)) {
					// move with mouse
					selected = true
					update();
				}
			} else if kinematic {
				//move
				x += last_x
				y += last_y
				
				//make sure it remains in boundaries if they exist
				if (bounded) {
					if x != clamp(x, bounds[0], bounds[2]) {
						last_x *= -1
					}
					if y != clamp(y, bounds[1], bounds[3]) {
						last_y *= -1	
					}
					x = clamp(x, bounds[0], bounds[2])
					y = clamp(y, bounds[1], bounds[3])
				}
				
				last_x *= 0.99
				last_y *= 0.99
			}
		}
	}

	///@func draw()
	///@desc draws the Token
	static draw = function () {
		draw_set_colour(image_blend)
		draw_circle(x, y, 20, false)
		if (text != "") {
			draw_set_font(fnt_body);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_colour(c_white);
			draw_text(x, y, text);	
		}
	}
	
	///@func bound(x1, y1, x2, y2)
	///@param {real} x1 - the left bound
	///@param {real} y1 - the top bound
	///@param {real} x2 - the right bound
	///@param {real} y2 - the bottom bound
	///@desc bounds the Token to within the defined area
	static bound = function (_x1, _y1, _x2, _y2) {
		bounded = true;
		bounds = [min(_x1, _x2), min(_y1, _y2), max(_x1, _x2), max(_y1, _y2)]
		return self
	}
	
	///@func set_kinematic()
	///@desc sets the token to be kinematic
	///@retn self
	static set_kinematic = function () {
		kinematic = true;
		return self
	}
	
	///@func set_text()
	///@desc sets the text shown on the token
	///@param {string} text - The text to set
	///@retn self
	static set_text = function (_text) {
		text = _text;
		return self
	}
}