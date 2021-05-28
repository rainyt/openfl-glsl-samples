#pragma header
uniform float u_scale;
void main(void){
	#pragma body
	vec2 uv=openfl_TextureCoordv*openfl_TextureSize;
	vec2 centerUv=vec2(0.5)*openfl_TextureSize;
	float r=atan(uv.y-centerUv.y,uv.x-centerUv.x);
	r=r*(-180./3.14)+180.;
	if(r<360.*u_scale){
		float len=(openfl_TextureSize.x<openfl_TextureSize.y)? openfl_TextureSize.x : openfl_TextureSize.y;
		if(distance(vec2(0.5)*openfl_TextureSize,openfl_TextureCoordv.xy*openfl_TextureSize)<len*0.5){
			gl_FragColor=texture2D(openfl_Texture,openfl_TextureCoordv);
		}else{
			gl_FragColor=vec4(0.);
		}
	}else{
		gl_FragColor=vec4(0.);
	}
}