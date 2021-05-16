package glsl;

import openfl.Lib;
import VectorMath;

@:debug
class BitmapGLSL6 extends OpenFLShader {
	@:uniform public var time:Float;

	@:glsl public var amount:Float = 6;

	@:glsl public function random2d(v2:Vec2):Float {
		return fract(sin(dot(v2, vec2(12.9898, 78.233))) * 43758.5496);
	}

	override function fragment() {
		super.fragment();
		color.rgb += (random2d(gl_openfl_TextureCoordv) - 0.5) * amount;
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
