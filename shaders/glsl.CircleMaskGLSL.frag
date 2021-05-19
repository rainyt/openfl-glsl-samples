#pragma header
uniform float u_scale;

void main(void){#pragma body
  float len=(openfl_TextureSize.x<openfl_TextureSize.y)? openfl_TextureSize.x : openfl_TextureSize.y;
  if(distance(vec2(0.5)*openfl_TextureSize,openfl_TextureCoordv.xy*openfl_TextureSize)<len*0.5){
    gl_FragColor=texture2D(openfl_Texture,openfl_TextureCoordv);
    ;
  }else{
    gl_FragColor=vec4(0.);
    ;
  };
  
}
