///@func Surface(width, height)
///@param {real} width - the width of the surface
///@param {real} height - the height of the surface
///@desc constructs a Surface
function Surface(_width, _height) constructor {
	width = _width
	height = _height
	
	surface = -1
	bounds = new Bounds(0, 0, _width, _height)
	
	static sanity_check = function() {
		if (surface_exists(surface)) {
			return true
		} else {
			create()
			return false
		}
	}
	
	static set_redraw = function (_func) {
		redraw = method(other, _func)
		return self
	}
	
	static set_update = function (_func) {
		update_draw = method(other, _func)
		return self
	}
	
	redraw = function () {
		set()
		draw_clear(c_black)
		reset()
	}
	
	update_draw = function () {
		draw_text(width/2, height/2, "use set_draw to give a draw event")	
	}
	
	static update = function () {
		set()
		update_draw()
		reset()
	}
	
	static draw = function (_x, _y) {
		_x = is_undefined(_x) ? 0 : _x
		_y = is_undefined(_y) ? 0 : _y
		sanity_check()
		draw_surface(surface, _x, _y)
	}
	
	static draw_scaled = function (_scl, _x, _y) {
		_x = is_undefined(_x) ? 0 : _x
		_y = is_undefined(_y) ? 0 : _y
		sanity_check()
		draw_surface_ext(surface, _x, _y, _scl, _scl, 0, c_white, 1)
	}
	
	static create = function () {
		surface = surface_create(width, height)
		redraw();
	}
	
	static set = function () {
		sanity_check()
		surface_set_target(surface)
	}
	
	static reset = function () {
		surface_reset_target()	
	}
	
	static get_texture = function () {
		sanity_check()
		return surface_get_texture(surface)	
	}
	
	create()
}