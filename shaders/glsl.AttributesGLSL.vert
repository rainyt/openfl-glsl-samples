#pragma header
attribute float a_g_blendmode;
attribute float a_g_alpha;
uniform sampler2D u_bitmapData;
varying vec4 v_color;
void main(void){#pragma body
  v_color=vec4(a_g_alpha,0.,0.,a_g_blendmode);
}