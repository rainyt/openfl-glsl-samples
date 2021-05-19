#pragma header
uniform float u_time;
float random2d(vec2 v2){
  return fract(sin(dot(v2,vec2(12.9898,78.233)))*43758.5496);
}
void main(void){#pragma body
  color.rbg=vec3(random2d(sin(openfl_TextureCoordv/900.)*u_time));
  gl_FragColor=color;
}