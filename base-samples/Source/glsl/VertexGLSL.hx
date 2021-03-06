package glsl;

import VectorMath;

class VertexGLSL extends OpenFLShader {
	@:uniform public var time:Float;

	/**
	 * 定义varying
	 */
	@:varying public var textureCoords:Array<Vec2>;

	/**
	 * 实现顶点着色器
	 */
	@:define("VALUE 0.5")
	override function vertex() {
		super.vertex();
		textureCoords[0] = vec2(VALUE, sin(time));
		textureCoords[1] = vec2(VALUE, sin(time));
		textureCoords[2] = vec2(VALUE, sin(time));
		textureCoords[3] = vec2(VALUE, sin(time));
	}

	/**
	 * 片段着色器
	 */
	override function fragment() {
		super.fragment();
		gl_FragColor = vec4(textureCoords[0], sin(time), 1);
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
