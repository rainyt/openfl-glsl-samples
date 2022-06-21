package glsl;

import glsl.GLSL.texture2D;
import VectorMath;

@:debug
class AttributesGLSL extends OpenFLGraphicsShader {
	@:attribute public var g_alpha:Float;

	@:attribute public var g_blendmode:Float;

	@:varying public var v_color:Vec4;

	override function vertex() {
		super.vertex();
		// Alpha support
		v_color.w += v_color.r + 0.5;
		v_color = vec4(g_alpha, 0, 0, g_blendmode);
	}

	override function fragment() {
		super.fragment();
		var c:Vec4 = texture2D(gl_bitmap, gl_openfl_TextureCoordv);
		gl_FragColor = c * v_color;
	}

	public function new() {
		super();
		this.a_g_alpha.value = [1, 1, 1, 0.5, 0.5, 0.5];
		this.a_g_blendmode.value = [1, 1, 1, 0, 0, 0];
	}
}
