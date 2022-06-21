package glsl;

import glsl.GLSL;
import VectorMath;

class BitmapGLSL extends OpenFLShader {
	@:uniform public var time:Float;

	override function fragment() {
		super.fragment();
		var coord:Vec2 = gl_openfl_TextureCoordv;
		coord.x += sin(time / 60 * 0.5);
		coord.y += cos(time / 60 * 0.5);
		gl_FragColor = texture2D(gl_openfl_Texture, fract(coord));
	}

	public function new() {
		super();
		this.u_time.value = [0];
		this.setFrameEvent(true);
	}

	override public function onFrame():Void {
		this.u_time.value[0]++;
	}
}
