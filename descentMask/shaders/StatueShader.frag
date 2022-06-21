#pragma header
precision highp float;
uniform float u_offestY;
uniform sampler2D u_movemask;
void main(void){
	vec4 rootcolor = texture2D(openfl_Texture, openfl_TextureCoordv);
	vec4 color = texture2D(u_movemask, openfl_TextureCoordv);
	vec4 color3 = texture2D(u_movemask, openfl_TextureCoordv - vec2(0., u_offestY));
	color3 = color3 * color.a;
	gl_FragColor = rootcolor * (1. - color3.a) + color3;
}