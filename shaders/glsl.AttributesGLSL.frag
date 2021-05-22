#pragma header
varying vec4 v_color;
void main(void){#pragma body
  vec4 c=texture2D(gl_bitmap,openfl_TextureCoordv);
  gl_FragColor=c*v_color;
}