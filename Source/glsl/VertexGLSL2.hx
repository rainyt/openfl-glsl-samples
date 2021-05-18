package glsl;

import glsl.GLSL;
import openfl.Lib;
import VectorMath;
import glsl.GLSL;

@:debug
class VertexGLSL2 extends OpenFLShader {
	@:uniform public var time:Float;

	/**
	 * 定义varying
	 */
	@:varying public var texcolor:Vec4;

	/**
	 * 实现顶点着色器
	 */
	@:define("VALUE 0.5")
	override function vertex() {
		super.vertex();
		// texcolor = vec4(gl_openfl_TextureCoordv,1., 1.);
		// texcolor = vec4(gl_openfl_Position.x / gl_openfl_TextureSize.x,0.,0., 1.);
	}

	/**
	 * 片段着色器
	 */
	override function fragment() {
		super.fragment();
		// gl_FragColor = 
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
