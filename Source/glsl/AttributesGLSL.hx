package glsl;

import VectorMath;

@:debug
class AttributesGLSL extends OpenFLShader {
    
    @:attribute public var g_alpha:Float;

    @:varying public var v_color:Vec4;

    override function vertex() {
        super.vertex();
        // Alpha support
        v_color = vec4(1,0,0,g_alpha);
    }

    override function fragment() {
        super.fragment();
        gl_FragColor = v_color;
    }

    public function new() {
        super();
        this.a_g_alpha.value = [1,1,1,0.5,0.5,0.5];
    }

}