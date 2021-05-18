#pragma header

float random2d(vec2 v2){
  return fract(sin(dot(v2,vec2(12.9898,78.233)))*43758.5496);
  
}
uniform float u_time;
float amount=6.;

void main(void){#pragma body
  color.rgb+=(random2d(openfl_TextureCoordv)-0.5)*amount;
  gl_FragColor=color;
  
}
