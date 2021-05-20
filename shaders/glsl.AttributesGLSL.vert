#pragma header
attribute float a_g_alpha;
varying vec4 v_color;
void main(void){#pragma body
  v_color=vec4(1.,0.,0.,a_g_alpha);
}