package glsl;

import openfl.Lib;
import VectorMath;

@:debug
class BitmapGLSL3 extends OpenFLShader{
    @:uniform public var time:Float;

	override function fragment() {
		super.fragment();
        color.r += sin(gl_openfl_TextureCoordv.x * 90);
        color.r += cos(gl_openfl_TextureCoordv.y * 90);        
		gl_FragColor = color;
	}

	public function new() {
		super();
		this.u_time.value = [0];
		Lib.setInterval(update, 0);
	}

	public function update():Void {
		this.u_time.value[0]++;
	}
}
