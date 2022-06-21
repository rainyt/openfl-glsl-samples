package glsl;

import openfl.Lib;
import VectorMath;

class LightEffect extends OpenFLShader {
	@:uniform public var time:Float;

	@:define("r openfl_TextureSize.xy")
	override function fragment() {
		super.fragment();

		// 设置为黑色
		color = vec4(0, 0, 0, 1);

		var c:Vec3 = vec3(0, 0, 0);
		var l:Float = time;
		var z:Float = time;
		for (i in 0...3) {
			var uv:Vec2 = gl_openfl_TextureCoordv;
			var p:Vec2 = uv;
			p -= .5;
			p.x *= r.x / r.y;
			z += 0.7;
			l = length(p);
			uv += p / l * (sin(z) + 1.) * abs(sin(l * 9. - z * 2.));
			c[i] = .01 / length(abs(mod(uv, 1.) - .5));
		}
		gl_FragColor = vec4(c / l, 1);
	}

	public function new() {
		super();
		this.u_time.value = [0];
		this.setFrameEvent(true);
	}

	override public function onFrame():Void {
		this.u_time.value[0] += 1 / 600;
	}
}
