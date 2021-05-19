package glsl;

import glsl.GLSL.texture2D;
import VectorMath;

/**
 * 圆形遮罩
 */
class CircleMaskGLSL extends OpenFLShader {
	@:uniform public var scale:Float;

	override function fragment() {
		super.fragment();
		if (distance(vec2(0.5), gl_openfl_TextureCoordv.xy) < scale * 0.5) {
			gl_FragColor = texture2D(gl_openfl_Texture, gl_openfl_TextureCoordv);
		} else {
			gl_FragColor = vec4(0);
		}
	}

	/**
	 * 圆形遮罩，设置比例来覆盖圆形的范围。
	 * @param circleScale 
	 */
	public function new(circleScale:Float = 1) {
		super();
		u_scale.value = [circleScale];
	}
}