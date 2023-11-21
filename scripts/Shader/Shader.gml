///@func Shader(shader, uniforms)
///@param {shader} shader - the shader
///@param {array<Uniform>} uniforms - an array of uniforms to apply to the shader
///@desc constructs a Shader
function Shader(_shader, _uniforms) constructor {
	shader = _shader
	uniforms = _uniforms
	uniform_map = ds_map_create()
	
	///@func get_uniform_map()
	///@desc creates a map to get the indexes of the unforms
	static get_uniform_map = function () {
		//populate uniform map
		for (var i = 0; i < array_length(uniforms); i++) {
			ds_map_add(uniform_map, uniforms[i].name, i)
		}
	}
	
	///@func set()
	///@desc sets the shader with all uniforms
	static set = function () {
		shader_set(shader)
		for (var i = 0; i < array_length(uniforms); i++) {
			uniforms[i].set()	
		}
	}
	
	///@func reset()
	///@desc calls shader_reset(), must have one for every set()
	static reset = function () {
		shader_reset()
	}
	
	///@func bind()
	///@desc binds all the uniforms to the shader
	static bind = function () {
		// for every Uniform
		for (var i = 0; i < array_length(uniforms); i++) {
			// binds input to the calling object if it is a method
			if (is_method(uniforms[i].input)) {
				uniforms[i].input = method(other, uniforms[i].input)
			}
			// bind the uniform to the shader
			uniforms[i].bind(shader)	
		}
	}
	
	///@func change(uniform)
	///@param {Uniform} uniform - the uniform to add to the shader
	///@desc adds the uniform to the shader, or overrides the previous uniform
	static change = function (_uniform) {
		//get index of uniform
		var i = uniform_map[? _uniform.name]
		//if it exists, change the Uniform
		if !(is_undefined(i)) {
			uniforms[i] = _uniform
			_uniform.bind(shader)
		}
		
		//iterative alternative
		//for (var i = 0; i < array_length(uniforms); i++) {
		//	if (_uniform.name == uniforms[i].name) {
		//		uniforms[i] = _uniform
		//		_uniform.bind(shader)
		//		break
		//	}
		//}
	}
	
	///@func update(name, input)
	///@param {string} name - the name of the uniform
	///@param {real/method} input - the Uniform parameter input
	///@desc updates the Uniform pass in values
	static update = function (_name, _input) {
		//get index of uniform
		var i = uniform_map[? _name]
		//if it exists, change the Uniform input
		if !(is_undefined(i)) {
			uniforms[i].input = _input
		}
		
		//iterative alternative
		//for (var i = 0; i < array_length(uniforms); i++) {
		//	if (_name == uniforms[i].name) {
		//		uniforms[i].input = _value
		//		break
		//	}
		//}
	}
	
	///@func destroy()
	///@desc cleans up all used data structures
	static destroy = function () {
		ds_map_destroy(uniform_map)	
	}
	
	//call init functions
	get_uniform_map()
	bind()
}