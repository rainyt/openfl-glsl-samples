package glsl;

import openfl.Lib;
import VectorMath;

@:debug
class VertexGLSL extends OpenFLShader {
	@:uniform public var time:Float;

	/**
	 * 定义varying
	 */
	@:varying public var textureCoords:Vec2;

	/**
	 * 实现顶点着色器
	 */
	@:define("VALUE 0.5")
	override function vertex() {
		super.vertex();
		textureCoords = vec2(VALUE, sin(time));
	}

	/**
	 * 片段着色器
	 */
	override function fragment() {
		super.fragment();
		gl_FragColor = vec4(textureCoords, sin(time), 1);
	}

	public function new() {
		super();
		this.u_time.value = [0];
		this.setFrameEvent(true);
	}

	override public function onFrame():Void {
		this.u_time.value[0] += 1 / 1000;
	}
}
