package glsl;

import VectorMath;
import glsl.GLSL.texture2D;

/**
 * 瓦片平铺GLSL
 */
class TiledGLSL extends OpenFLShader {
	@:uniform public var time:Float;
	@:uniform public var size:Vec2;

	override function vertex() {
		super.vertex();
	}

	override function fragment() {
		super.fragment();
		// 计算平铺位置，但这里的(8,8)需要根据比例计算，才能得到图片的正常尺寸
		var uv:Vec2 = gl_openfl_TextureCoordv * vec2(8, 8) * (size / gl_openfl_TextureSize) / gl_openfl_TextureSize;
		var v:Vec2 = fract(vec2(uv.x, uv.y) + time);
		gl_FragColor = texture2D(gl_openfl_Texture, v);
	}

	/**
	 * 
	 * @param w 画布宽度
	 * @param h 画布高度
	 */
	public function new(w:Float, h:Float) {
		super();
		this.setFrameEvent(true);
		this.u_size.value = [w, h];
	}

	override function onFrame() {
		super.onFrame();
		if (u_time.value == null)
			u_time.value = [0];
		u_time.value[0] += 1 / 1000;
	}
}
