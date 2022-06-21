package glsl;

import openfl.display.Stage;
import glsl.GLSL;
import VectorMath;

class GPUParticle extends OpenFLShader {
	@:uniform public var time:Float;

	public function new(stage:Stage) {
		super();
		u_time.value = [0];
		this.setFrameEvent(true);
	}

	/**
	 * 旋转实现
	 * @return Mat4
	 */
	@:glsl public function rotaion(degrees:Float):Mat4 {
		var tx:Float = gl_openfl_TextureSize.x * 0.5;
		var ty:Float = gl_openfl_TextureSize.y * 0.5;
		var tz:Float = 0;

		var radian:Float = degrees * 3.14 / 180;
		var c:Float = cos(radian);
		var s:Float = sin(radian);
		var x:Float = 0;
		var y:Float = 0;
		var z:Float = 1;
		var x2:Float = x * x;
		var y2:Float = y * y;
		var z2:Float = z * z;
		var ls:Float = x2 + y2 + z2;
		if (ls != 0) {
			var l:Float = 1;
			x /= l;
			y /= l;
			z /= l;
			x2 /= ls;
			y2 /= ls;
			z2 /= ls;
		}
		var ccos:Float = 1 - c;
		var d:Mat4 = gl_openfl_Matrix;
		d[0].x = x2 + (y2 + z2) * c;
		d[0].y = x * y * ccos + z * s;
		d[0].z = x * z * ccos - y * s;
		d[1].x = x * y * ccos - z * s;
		d[1].y = y2 + (x2 + z2) * c;
		d[1].z = y * z * ccos + x * s;
		d[2].x = x * z * ccos + y * s;
		d[2].y = y * z * ccos - x * s;
		d[2].z = z2 + (x2 + y2) * c;
		d[3].x = (tx * (y2 + z2) - x * (ty * y + tz * z)) * ccos + (ty * z - tz * y) * s;
		d[3].y = (ty * (x2 + z2) - y * (tx * x + tz * z)) * ccos + (tz * x - tx * z) * s;
		d[3].z = (tz * (x2 + y2) - z * (tx * x + ty * y)) * ccos + (tx * y - ty * x) * s;
		return d;
	}

	/**
	 * 比例缩放
	 * @param scaleX 
	 * @param scaleY 
	 */
	@:glsl public function scale(xScale:Float, yScale:Float):Mat4 {
		return mat4(xScale, 0.0, 0.0, 0.0, 0.0, yScale, 0.0, 0.0, 0.0, 0.0, 1, 0.0, 0.0, 0.0, 0.0, 1.0);
	}

	/**
	 * 平移
	 * @param x 
	 * @param y 
	 */
	@:glsl public function translation(x:Float, y:Float):Mat4 {
		return mat4(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, x, y, 0, 0);
	}

	override function vertex() {
		super.vertex();

		// 角度
		var d:Mat4 = rotaion(360 * sin(time));

		// 缩放
		var s:Mat4 = scale(1, 1);

		// 平移
		// var uv:Vec2 = gl_openfl_TextureCoord / gl_openfl_TextureSize;
		var t:Mat4 = translation(1, -1);

		// 位移
		this.gl_Position = (gl_openfl_Matrix + t) * d * s * gl_openfl_Position;
	}

	override function onFrame() {
		super.onFrame();
		u_time.value[0] += 1 / 60;
	}
}
