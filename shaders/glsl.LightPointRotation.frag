#pragma header
uniform float u_time;
void main(void){#pragma body
  color=vec4(0.,0.,0.,1.);
  for(int i = 0;i<7;i++){
    float t=radians(float(i)*200./7.);
    t+=u_time/100.*(1.+float(i)/7.);
    vec2 p=vec2(cos(t),sin(t))*0.3+0.5;
    float d=max(distance(openfl_TextureCoordv,p)*50.,1.);
    color.rgb+=step(0.5,fract(vec3(float(i)/4.,float(i)/8.,float(i)/2.)))/(d*d);
  }
  gl_FragColor=color;
}