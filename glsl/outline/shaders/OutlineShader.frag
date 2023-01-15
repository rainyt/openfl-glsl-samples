#pragma header
uniform bool u_showout;
uniform float u_quality;
uniform float u_outlineSize;
uniform vec4 u_outlineColor;
uniform float u_hdrStrength;
vec4 texColor(vec4 color1, vec4 color2){
	return u_outlineColor * max(0., (color1.a - color2.a));
}
void main(void){
	#pragma body
	vec2 uv = 1. / openfl_TextureSize;
	int times = int(u_quality * 4.);
	float setp = 6.28 / float(times);
	vec4 outcolor = color;
	float light = 0.;
	for(int i = 0;i < 360;i ++){
		if(i > times){
			break;
		}
		float r = setp * float(i);
		vec2 offestCenter = vec2(uv.x * u_outlineSize * sin(r), uv.y * u_outlineSize * cos(r));
		vec4 copy = texture2D(openfl_Texture, openfl_TextureCoordv + offestCenter);
		outcolor += texColor(copy, color) * (1. - color.a) * (1. - color.a) * (1. - color.a);
		light += (copy.r + copy.g + copy.b) / 3.;
	}
	outcolor += u_outlineColor * vec4(light / float(times)) * u_hdrStrength;
	if(u_showout){
		gl_FragColor = outcolor * (1. - color.a);
	}else{
		outcolor += color * (light / (float(times) / 8.)) * u_hdrStrength;
		gl_FragColor = outcolor;
	}
}