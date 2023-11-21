///@func String(x, y, string)
///@param {real} x - the x position of the string
///@param {real} y - the y position of the string
///@param {string} string - the content of the string
///@desc constructs a String
function String(_x, _y, _str) constructor {
	x = _x
	y = _y
	content = _str
	aligned = false
	alignment = [fa_middle, fa_center]
	scl = 1
	font = fnt_body
	
	static move = function(_x, _y) {
		x += _x
		y += _y
		return self
	}
	
	static align = function(_hori, _vert) {
		alignment = [_hori, _vert]
		aligned = true
		return self
	}
	
	static set_font = function(_font) {
		font = _font
		return self
	}
	
	static draw = function () {
		if (aligned) {
			draw_set_halign(alignment[0])
			draw_set_halign(alignment[1])
		}
		draw_set_font(font)
		draw_text(x, y, string(content))
		draw_set_font(fnt_body)

		
	}
}