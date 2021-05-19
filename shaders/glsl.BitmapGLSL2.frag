#pragma header
uniform float u_time;
void main(void){#pragma body
  color.r+=0.3;
  color.b+=sin(u_time/60.);
  gl_FragColor=color;
}