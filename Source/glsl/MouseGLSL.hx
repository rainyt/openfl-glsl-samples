package glsl;

@:debug
class MouseGLSL extends OpenFLShader {
	@:uniform public var mouse:Vec2;

	override function fragment() {
		super.fragment();
		var m:Vec2 = mouse / gl_openfl_TextureSize;
		color.x = m.x;
		color.y = m.y;
		gl_FragColor = color;
	}
}
