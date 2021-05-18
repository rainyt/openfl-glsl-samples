#pragma header
uniform float u_time;

void main(void){#pragma body
  color.w=sin(floor(openfl_TextureCoordv.x*6.0)-u_time/600.*9.0);
  gl_FragColor=color;
  
}
