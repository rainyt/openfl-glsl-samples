package glsl;

import VectorMath;

class BitmapGLSL2 extends OpenFLShader{
    @:uniform public var time:Float;

	override function fragment() {
		super.fragment();
        color.r = color.r + 0.3;
        color.b = color.b + sin(time / 60);        
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
