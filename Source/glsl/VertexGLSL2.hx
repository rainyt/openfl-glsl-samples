package glsl;

import glsl.GLSL;
import VectorMath;

@:debug
class VertexGLSL2 extends OpenFLShader {
	@:uniform public var time:Float;

	/**
	 * 定义varying
	 */
	@:varying public var size:Float;

	/**
	 * 实现顶点着色器
	 */
	@:define("VALUE 0.5")
	override function vertex() {
		super.vertex();
		size = 5.;
	}

	/**
	 * 片段着色器
	 */
	override function fragment() {
		super.fragment();
		var px:Float = size / gl_openfl_TextureSize.x;
		var py:Float = size / gl_openfl_TextureSize.y;
		if (gl_openfl_TextureCoordv.x < px || gl_openfl_TextureCoordv.x > 1. - px || gl_openfl_TextureCoordv.y < py || gl_openfl_TextureCoordv.y > 1. - py) {
			gl_FragColor = vec4(1, 0, 0, 1);
		} else
			gl_FragColor = texture2D(gl_openfl_Texture, fract(gl_openfl_TextureCoordv * -1));
	}

	public function new() {
		super();
		this.u_time.value = [0];
		this.setFrameEvent(true);
	}

	override public function onFrame():Void {
		this.u_time.value[0] += 1 / 60;
	}
}
