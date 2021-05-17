package glsl;

import glsl.OpenFLShader.float;
import VectorMath.vec4;

/**
 * 使用Haxe转换为GLSL，通过fragmentSource和vertexSource进行访问
 */
@:debug
class Haxe2GLSL extends BaseGLSL {
	@:define("TEXT 1")
	public function fragment():Void {
		this.gl_FragColor = vec4(float(TEXT), 1., 0., 1.);
	}

	public function vertex():Void {
		this.gl_Position = vec4(1, 1, 1, 1);
	}
}

@:autoBuild(glsl.macro.GLSLCompileMacro.build("glsl"))
class BaseGLSL {
	/**
	 * 最终值输出
	 */
	public var gl_FragColor:Vec4;

	/**
	 * 最终顶点坐标输出
	 */
	public var gl_Position:Vec4;
}
