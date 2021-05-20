#pragma header
uniform sampler2D u_bitmapData;
varying vec4 v_color;
void main(void){#pragma body
  vec4 c=texture2D(openfl_Texture,openfl_TextureCoordv);
  gl_FragColor=c*v_color;
}