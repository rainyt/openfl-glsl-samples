#pragma header
uniform float u_time;
void main(void){#pragma body
  color.r+=sin(openfl_TextureCoordv.x*90.);
  color.r+=cos(openfl_TextureCoordv.y*90.);
  gl_FragColor=color;
}