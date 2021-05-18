package glsl;

import glsl.OpenFLShader.float;
import openfl.Lib;
import VectorMath;

class LightPointRotation extends OpenFLShader {
	@:uniform public var time:Float;

	override function fragment() {
		super.fragment();

		color = vec4(0, 0, 0, 1);

		for (i in 0...7) {
			var t:Float = radians(float(i) * 200 / 7);
			t += time / 100 * (1 + float(i) / 7);
			// 坐标居中显示
			var p:Vec2 = vec2(cos(t), sin(t)) * 0.3 + 0.5;
			var d:Float = max(distance(gl_openfl_TextureCoordv, p) * 50, 1);
			color.rgb += step(0.5, fract(vec3(float(i) / 4, float(i) / 8, float(i) / 2))) / (d * d);
		}

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
