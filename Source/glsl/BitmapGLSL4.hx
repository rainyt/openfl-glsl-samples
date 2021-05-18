package glsl;

import VectorMath;

class BitmapGLSL4 extends OpenFLShader {
	@:uniform public var time:Float;

	/**
	 * 获取随机值
	 * @param v2 
	 * @return Float
	 */
	@:glsl public function random2d(v2:Vec2):Float {
		return fract(sin(dot(v2, vec2(12.9898, 78.233))) * 43758.5496);
	}

	override function fragment() {
		super.fragment();
		color.rbg = vec3(random2d(sin(gl_openfl_TextureCoordv / 900) * time));
		gl_FragColor = color;
	}

	public function new() {
		super();
		this.u_time.value = [0];
		this.setFrameEvent(true);
	}

	override public function onFrame():Void {
		this.u_time.value[0]++;
	}
}
