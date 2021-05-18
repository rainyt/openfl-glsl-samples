package glsl;

import VectorMath;

/**
 * 圆角遮罩
 */
@:debug
class RoundMaskGLSL extends OpenFLShader {
	@:uniform public var px:Vec4;

	override function fragment() {
		super.fragment();
		// 左
		var xsize:Float = radians(px.x);
		// 右
		var ysize:Float = radians(px.y);
		// 左下
		var zsize:Float = radians(px.z);
		// 右下
		var wsize:Float = radians(px.w);
		if (distance(vec2(xsize, xsize), gl_openfl_TextureCoordv.xy) < xsize) {
			gl_FragColor = color;
		} else {
			if (distance(vec2(1 - ysize, ysize), gl_openfl_TextureCoordv.xy) < ysize) {
				gl_FragColor = color;
			} else {
				if (distance(vec2(zsize, 1 - zsize), gl_openfl_TextureCoordv.xy) < zsize) {
					gl_FragColor = color;
				} else {
					if (distance(vec2(1 - wsize, 1 - wsize), gl_openfl_TextureCoordv.xy) < wsize) {
						gl_FragColor = color;
					} else {
						gl_FragColor = vec4(0, 0, 0, 0);
					}
				}
			}
		}
		// 矩形补充
		// 左上角
		if (gl_openfl_TextureCoordv.x > xsize && gl_openfl_TextureCoordv.x < 0.5 && gl_openfl_TextureCoordv.y < 0.5) {
			gl_FragColor = color;
		} else if (gl_openfl_TextureCoordv.y > xsize && gl_openfl_TextureCoordv.x < 0.5 && gl_openfl_TextureCoordv.y < 0.5) {
			gl_FragColor = color;
		}
		if (gl_openfl_TextureCoordv.x < 1 - ysize && gl_openfl_TextureCoordv.x > 0.5 && gl_openfl_TextureCoordv.y < 0.5) {
			gl_FragColor = color;
		} else if (gl_openfl_TextureCoordv.y > ysize && gl_openfl_TextureCoordv.x > 0.5 && gl_openfl_TextureCoordv.y < 0.5) {
			gl_FragColor = color;
		}
		if (gl_openfl_TextureCoordv.x > zsize && gl_openfl_TextureCoordv.x < 0.5 && gl_openfl_TextureCoordv.y > 0.5) {
			gl_FragColor = color;
		} else if (gl_openfl_TextureCoordv.y < 1 - zsize && gl_openfl_TextureCoordv.x < 0.5 && gl_openfl_TextureCoordv.y > 0.5) {
			gl_FragColor = color;
		}
		if (gl_openfl_TextureCoordv.x < 1 - wsize && gl_openfl_TextureCoordv.x > 0.5 && gl_openfl_TextureCoordv.y > 0.5) {
			gl_FragColor = color;
		} else if (gl_openfl_TextureCoordv.y < 1 - wsize && gl_openfl_TextureCoordv.x > 0.5 && gl_openfl_TextureCoordv.y > 0.5) {
			gl_FragColor = color;
		}
	}

	/**
	 * 圆角遮罩
	 * @param lefttop 左上
	 * @param righttop 右上
	 * @param leftbottom 左下
	 * @param rightbottom 右下
	 */
	public function new(lefttop:Float = 8, righttop:Float = 8, leftbottom:Float = 8, rightbottom:Float = 8) {
		super();
		u_px.value = [lefttop, righttop, leftbottom, rightbottom];
	}
}
