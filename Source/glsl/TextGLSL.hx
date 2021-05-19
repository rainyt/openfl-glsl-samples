package glsl;

import VectorMath.vec2;
import glsl.GLSL;
import VectorMath;

/**
 * 文本描边渲染支持
 */
@:debug
class TextGLSL extends OpenFLShader {
	@:uniform public var storksize:Float;

	/**
	 * 检测当前这个点的偏移位置是否包含透明度
	 * @param v2 
	 * @param offestX 
	 * @param offestY 
	 * @return Bool
	 */
	@:glsl public function inAlpha(v2:Vec2, offestX:Float, offestY:Float):Bool {
		return texture2D(gl_openfl_Texture, v2 + vec2(offestX, offestY)).a > 0;
	}

	/**
	 * 每个点都做一次圆检测
	 * @param v2 
	 * @return Bool
	 */
	@:glsl public function circleCheck(v2:Vec2, len:Float):Bool {
		var setpX:Float = 1 / gl_openfl_TextureSize.x * len;
		var setpY:Float = 1 / gl_openfl_TextureSize.y * len;
		var checkTimes = 36.;
		var setp:Float = 3.14 / checkTimes;
		for (i in 0...36) {
			var r:Float = setp * float(i);
			if (inAlpha(v2, setpX * sin(r), setpY * cos(r)) || inAlpha(v2, setpX * -sin(r), setpY * -cos(r)))
				return true;
		}
		return false;
	}

	override function fragment() {
		super.fragment();
		for (i in 0...5) {
			if (float(i) > storksize)
				break;
			if (circleCheck(gl_openfl_TextureCoordv, float(i))) {
				gl_FragColor = vec4(1., 1., 0., 1.);
				if (color.a > 0.) {
					gl_FragColor = color;
					gl_FragColor.w = 1.;
				}
			}
		}
	}

	public function new(size:Float = 1.5) {
		super();
		u_storksize.value = [size];
	}
}
