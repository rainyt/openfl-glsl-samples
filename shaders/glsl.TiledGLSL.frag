#pragma header
uniform float u_time;
uniform vec2 u_size;
void main(void){
	#pragma body
	vec2 uv=openfl_TextureCoordv*vec2(8.,8.)*(u_size/openfl_TextureSize)/openfl_TextureSize;
	vec2 v=fract(vec2(uv.x,uv.y)+u_time);
	gl_FragColor=texture2D(openfl_Texture,v);
}