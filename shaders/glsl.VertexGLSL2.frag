#pragma header
uniform float u_time;
varying float size;
void main(void){
	#pragma body
	float px=size/openfl_TextureSize.x;
	float py=size/openfl_TextureSize.y;
	if(openfl_TextureCoordv.x<px || openfl_TextureCoordv.x>1.-px || openfl_TextureCoordv.y<py || openfl_TextureCoordv.y>1.-py){
		gl_FragColor=vec4(1.,0.,0.,1.);
	}else{
		gl_FragColor=texture2D(openfl_Texture,fract(openfl_TextureCoordv*-1.));
	}
}