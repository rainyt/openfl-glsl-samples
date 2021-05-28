#pragma header
#define r openfl_TextureSize.xy
uniform float u_time;
void main(void){
	#pragma body
	color=vec4(0.,0.,0.,1.);
	vec3 c=vec3(0.,0.,0.);
	float l=u_time;
	float z=u_time;
	for(int i = 0;i<3;i++){
		vec2 uv=openfl_TextureCoordv;
		vec2 p=uv;
		p-=.5;
		p.x*=r.x/r.y;
		z+=0.7;
		l=length(p);
		uv+=p/l*(sin(z)+1.)*abs(sin(l*9.-z*2.));
		c[i]=.01/length(abs(mod(uv,1.)-.5));
	}
	gl_FragColor=vec4(c/l,1);
}