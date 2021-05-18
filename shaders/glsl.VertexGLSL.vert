#pragma header
#define VALUE 0.5
uniform float u_time;
varying vec2 textureCoords[4];

void main(void){#pragma body
  textureCoords[0]=vec2(VALUE,sin(u_time));
  textureCoords[1]=vec2(VALUE,sin(u_time));
  textureCoords[2]=vec2(VALUE,sin(u_time));
  textureCoords[3]=vec2(VALUE,sin(u_time));
  
}
