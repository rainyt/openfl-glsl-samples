#pragma header
uniform float u_time;
void main(void){
	#pragma body
	vec2 coord = openfl_TextureCoordv;
	coord.x += sin(u_time / 60. * 0.5);
	coord.y += cos(u_time / 60. * 0.5);
	gl_FragColor = texture2D(openfl_Texture, fract(coord));
}