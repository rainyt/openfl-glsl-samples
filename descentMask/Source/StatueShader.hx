package;

import VectorMath;
import glsl.GLSL;
import glsl.Sampler2D;
import glsl.OpenFLShader;

/**
 * 下降遮罩的Shader
 */
class StatueShader extends OpenFLShader {

	/**
	 * 上下偏移值
	 */
	@:uniform public var offestY:Float;

	/**
	 * 偏移的纹理
	 */
	@:uniform public var movemask:Sampler2D;

	public function new() {
		super();
		this.u_offestY.value = [0];
	}

	@:precision("highp float")
	override function fragment() {
		// 偏移遮罩
		// 获取原图的颜色
		var rootcolor:Vec4 = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv);
		var color:Vec4 = texture2D(movemask, gl_openfl_TextureCoordv);
		// 获取Y轴偏移的颜色
		var color3:Vec4 = texture2D(movemask, gl_openfl_TextureCoordv - vec2(0, offestY));
		// 将偏移的颜色 * 原来未偏移的透明度
		color3 = color3 * color.a;
		// 将原始颜色 + 下降物件颜色
		gl_FragColor = rootcolor * (1 - color3.a) + color3;
	}
}
