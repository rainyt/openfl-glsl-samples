package glsl;

import glsl.GLSL.texture2D;
import VectorMath;

/**
 * 九宫格图渲染支持
 */
class S9GLSL extends OpenFLShader {
	/**
	 * 九宫格数据
	 */
	@:uniform public var s9d:Vec4;

	/**
	 * 显示对象尺寸
	 */
	@:uniform public var size:Vec2;

	/**
	 * 获取指定位置的UV图
	 * @param x 
	 * @param y 
	 * @return Vec2
	 */
	@:glsl public function getUv(x:Float, y:Float):Vec2 {
		return vec2(x / gl_openfl_TextureSize.x, y / gl_openfl_TextureSize.y);
	}

	override function fragment() {
		super.fragment();
		var uv:Vec2 = gl_openfl_TextureCoordv * size;
		var centerWidth:Float = size.x - s9d.x - s9d.y; // 中间宽度
		var centerHeight:Float = size.y - s9d.z - s9d.w; // 中间高度
		var centerSliceWidth:Float = gl_openfl_TextureSize.x - s9d.x - s9d.y; // 中间原图宽度
		var centerSliceHeight:Float = gl_openfl_TextureSize.y - s9d.z - s9d.w; // 中间原图高度
		gl_FragColor = vec4(0);
		if (uv.x < s9d.x && uv.y < s9d.z) {
			// 左上(ok)
			gl_FragColor = texture2D(gl_openfl_Texture, getUv(uv.x, uv.y));
		} else if (uv.x > size.x - s9d.y && uv.y < s9d.z) {
			// 右上(ok)
			gl_FragColor = texture2D(gl_openfl_Texture, getUv(s9d.x + centerSliceWidth + uv.x - (size.x - s9d.y), uv.y));
		} else if (uv.x < s9d.x && uv.y > size.y - s9d.w) {
			// 左下
			gl_FragColor = texture2D(gl_openfl_Texture, getUv(uv.x, centerSliceHeight + s9d.z + uv.y - (size.y - s9d.w)));
		} else if (uv.x > size.x - s9d.y && uv.y > size.y - s9d.w) {
			// 右下
			gl_FragColor = texture2D(gl_openfl_Texture,
				getUv(s9d.x + centerSliceWidth + uv.x - (size.x - s9d.y), centerSliceHeight + s9d.z + uv.y - (size.y - s9d.w)));
		} else if (uv.y < s9d.z) {
			// 上
			gl_FragColor = texture2D(gl_openfl_Texture, getUv(s9d.x + (uv.x - s9d.z) / centerWidth * centerSliceWidth, uv.y));
		} else if (uv.y > size.y - s9d.w) {
			// 下
			gl_FragColor = texture2D(gl_openfl_Texture,
				getUv(s9d.x + (uv.x - s9d.z) / centerWidth * centerSliceWidth, centerSliceHeight + s9d.z + uv.y - (size.y - s9d.w)));
		} else if (uv.x <= s9d.x) {
			// 左(ok)
			gl_FragColor = texture2D(gl_openfl_Texture, getUv(uv.x, s9d.z + (uv.y - s9d.z) / centerHeight * centerSliceHeight));
		} else if (uv.x > size.x - s9d.y) {
			// 右(ok)
			gl_FragColor = texture2D(gl_openfl_Texture,
				getUv(centerSliceWidth + s9d.x + uv.x - (size.x - s9d.y), s9d.z + (uv.y - s9d.z) / centerHeight * centerSliceHeight));
		} else {
			// 中间
			gl_FragColor = texture2D(gl_openfl_Texture,
				getUv(s9d.x + (uv.x - s9d.z) / centerWidth * centerSliceWidth, s9d.z + (uv.y - s9d.z) / centerHeight * centerSliceHeight));
		}
	}

	/**
	 * @param left 左间距
	 * @param top 上间距
	 * @param right 右间距
	 * @param bottom 下间距
	 */
	public function new(left:Float, top:Float, bottom:Float, right:Float, width:Float, height:Float) {
		super();
		// left/right/top/bottom
		u_s9d.value = [left, right, top, bottom];
		u_size.value = [width, height];
	}
}
