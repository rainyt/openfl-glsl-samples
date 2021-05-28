 #pragma header
 uniform float u_time;
 varying vec2 textureCoords[4];
 void main(void){
	 #pragma body
	 gl_FragColor = vec4(textureCoords[0], sin(u_time), 1);
 }