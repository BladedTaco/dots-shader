///@func Bounds(x1, y1, x2, y2)
///@param {real} x1 - the left border of the bounds
function Bounds(_x1, _y1, _x2, _y2) constructor {
	left = min(_x1, _x2)
	right = max(_x1, _x2)
	top = min(_y1, _y2)
	bottom = max(_y1, _y2)
	
	width = right - left
	height = bottom - top
	
	centre_x = (left + right) / 2
	centre_y = (top + bottom) / 2
	
	image_blend = c_white
	line_width = 3
	
	static draw = function () {
		draw_set_colour(image_blend)
		
		for (var i = 0; i < line_width; i++) {
			draw_rectangle(left - i, top - i, right + i, bottom + i, true)
		}
	}
	
	static draw_back = function (_alpha) {
		draw_set_colour(image_blend)
		draw_set_alpha(_alpha)
		draw_rectangle(left, top, right, bottom, false)
		draw_set_alpha(1)
	}
	
	static move = function(_x, _y) {
		left	 += _x
		right	 += _x
		centre_x += _x
		
		top		 += _y
		bottom	 += _y
		centre_y += _y
	}
	
	static selected = function(_click) {
		if (mouse_check_button(_click)) {
			return point_in_rectangle(mouse_x, mouse_y, left, top, right, bottom)	
		}
		return false
	}
	static pressed = function(_click) {
		if (mouse_check_button_pressed(_click)) {
			return point_in_rectangle(mouse_x, mouse_y, left, top, right, bottom)	
		}
		return false
	}
}