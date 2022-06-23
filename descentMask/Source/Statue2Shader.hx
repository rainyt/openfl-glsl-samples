package;

import VectorMath;
import glsl.GLSL;
import glsl.Sampler2D;
import glsl.OpenFLShader;

/**
 * 下降遮罩的Shader
 */
class Statue2Shader extends OpenFLShader {
	/**
	 * 上下偏移值
	 */
	@:uniform public var offestY:Float;

	/**
	 * 偏移的纹理
	 */
	@:uniform public var movebmd:Sampler2D;

	/**
	 * 偏移的遮罩
	 */
	@:uniform public var movemask:Sampler2D;

	/**
	 * 关门纹理
	 */
	@:uniform public var closebmd:Sampler2D;

	public function new() {
		super();
		this.u_offestY.value = [0];
	}

	@:precision("highp float")
	override function fragment() {
		// 偏移遮罩
		// 获取原图的颜色
		var rootcolor:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv);
		// 关门颜色
		var closecolor:Vec4 = texture2D(closebmd, gl_openfl_TextureCoordv);
		// 获取偏移的关门颜色
		// 判断左右开门
		// var leftright:Float = (gl_openfl_TextureCoordv.x - 0.5) * 2;
		var closeCoord:Vec2 = gl_openfl_TextureCoordv + vec2(0, -1.1 + offestY);
		var offestclosecolor:Vec4 = texture2D(closebmd, closeCoord);
		offestclosecolor *= closecolor.a;
		// 遮罩的颜色
		var color:Vec4 = texture2D(movemask, gl_openfl_TextureCoordv);
		// 获取Y轴偏移的颜色
		var v:Vec2 = gl_openfl_TextureCoordv - vec2(0, offestY);
		var alpha:Float = step(0., v.y);
		var color3:Vec4 = texture2D(movebmd, v);
		// 将偏移的颜色 * 原来未偏移的透明度
		color3 = color3 * color.a * alpha;
		// 将原始颜色 + 下降物件颜色
		rootcolor = rootcolor * (1 - color3.a) + color3;
		// 关门动画实现
		rootcolor = rootcolor * (1 - offestclosecolor.a) + offestclosecolor;
		gl_FragColor = rootcolor;
	}
}
