package glsl;

import VectorMath;

class BitmapGLSL3 extends OpenFLShader{
    @:uniform public var time:Float;

	override function fragment() {
		super.fragment();
        color.r = color.r + sin(gl_openfl_TextureCoordv.x * 90);
        color.r = color.r + cos(gl_openfl_TextureCoordv.y * 90);        
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
