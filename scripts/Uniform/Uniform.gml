///@func Uniform(name, type, input)
///@param {string} name - the name of the uniform
///@param {method} type - the shader_set_uniform_* function to use
///@param {real/method} input - the input to throw into the uniform
///@desc constructs a Uniform
function Uniform(_name, _type, _input) constructor {
	name = _name
	type = _type  // set_unfiorm funciton
	input = _input // function or real
	uniform = -1
	
	// overload set
	if (is_method(input)) { // input is a function
		///@func set()
		///@desc sets the input to the uniform
		set = function () {
			type(uniform, input())
		}
	} else { // input is a number
		///@func set()
		///@desc sets the input to the uniform
		set = function () {
			type(uniform, input)
		}
	}
	
	///@func bind(shader)
	///@param {shader} shader - the shader resource to bind to
	///@desc Binds the Uniform to the given shader
	static bind = function (shader) {
		if (type = texture_set_stage) {
			uniform = shader_get_sampler_index(shader, name)	
		} else {
			uniform = shader_get_uniform(shader, name)
		}
	}
}

