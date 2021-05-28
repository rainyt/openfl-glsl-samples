 #pragma header
 uniform vec2 u_mouse;
 void main(void){
	 #pragma body
	 vec2 m = u_mouse / openfl_TextureSize;
	 color.x = m.x;
	 color.y = m.y;
	 gl_FragColor = color;
 }