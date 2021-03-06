package glsl;

import VectorMath;

function float(a:Dynamic):Dynamic{
	return a;
}

/**
 * 使用Haxe转换为GLSL，通过fragmentSource和vertexSource进行访问
 */
class Haxe2GLSL extends BaseGLSL {
	@:attribute public var a:Vec2;

	@:define("TEXT 1")
	public function fragment():Void {
		time++;
		--time;
		if (!(time > 10 || time < 30 && time != 0)) {
			this.gl_FragColor = vec4(float(TEXT), 1., 0., 1.);
		} else if (time == 0) {
			gl_FragColor = vec4(1, 1, 0.5, 1);
		} else {
			gl_FragColor = vec4(1, 1, 1, 1);
		}
		var w:Float = 0;
		while (w < 100) {
			for (i in 0...10) {
				w++;
			}
		}
		// Int
		var w2 = 1;
		// Float
		var w3 = 1.;
		w3 += abc;
	}

	public function vertex():Void {
		this.gl_Position = vec4(1, 1, 1, 1);
	}
}

@:autoBuild(glsl.macro.GLSLCompileMacro.build("glsl"))
class BaseGLSL {
	@:uniform public var time:Float;

	@:uniform public var mouse:Vec2;

	@:uniform public var resolution:Vec2;

	@:glsl public var abc:Float;

	@:glsl public var b:Bool;

	/**
	 * 最终值输出
	 */
	public var gl_FragColor:Vec4;

	/**
	 * 最终顶点坐标输出
	 */
	public var gl_Position:Vec4;
}
