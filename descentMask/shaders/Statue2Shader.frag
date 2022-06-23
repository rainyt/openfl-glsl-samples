#pragma header
precision highp float;
uniform float u_offestY;
uniform sampler2D u_movemask;
uniform sampler2D u_movebmd;
uniform sampler2D u_closebmd;
void main(void){
	vec4 rootcolor = texture2D(openfl_Texture, openfl_TextureCoordv);
	vec4 closecolor = texture2D(u_closebmd, openfl_TextureCoordv);
	vec2 closeCoord = openfl_TextureCoordv + vec2(0.,- 1.1 + u_offestY);
	vec4 offestclosecolor = texture2D(u_closebmd, closeCoord);
	offestclosecolor *= closecolor.a;
	vec4 color = texture2D(u_movemask, openfl_TextureCoordv);
	vec2 v = openfl_TextureCoordv - vec2(0., u_offestY);
	float alpha = step(0., v.y);
	vec4 color3 = texture2D(u_movebmd, v);
	color3 = color3 * color.a * alpha;
	rootcolor = rootcolor * (1. - color3.a) + color3;
	rootcolor = rootcolor * (1. - offestclosecolor.a) + offestclosecolor;
	gl_FragColor = rootcolor;
}