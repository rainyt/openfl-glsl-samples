package glsl;

import openfl.Lib;
import VectorMath;

@:debug
class BitmapGLSL5 extends OpenFLShader {
	@:uniform public var time:Float;

	override function fragment() {
		super.fragment();
		color.w = sin(floor(gl_openfl_TextureCoordv.x * 6.0) - time / 600 * 9.0);
		gl_FragColor = color;
	}

	public function new() {
		super();
		this.u_time.value = [0];
		Lib.setInterval(update, 0);
	}

	public function update():Void {
		this.u_time.value[0]++;
	}
}