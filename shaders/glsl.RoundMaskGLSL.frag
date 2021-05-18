#pragma header
uniform vec4 u_px;

void main(void){#pragma body
  float xsize=radians(u_px.x);
  float ysize=radians(u_px.y);
  float zsize=radians(u_px.z);
  float wsize=radians(u_px.w);
  if(distance(vec2(xsize,xsize),openfl_TextureCoordv.xy)<xsize){
    gl_FragColor=color;
    ;
  }else{
    if(distance(vec2(1.-ysize,ysize),openfl_TextureCoordv.xy)<ysize){
      gl_FragColor=color;
      ;
    }else{
      if(distance(vec2(zsize,1.-zsize),openfl_TextureCoordv.xy)<zsize){
        gl_FragColor=color;
        ;
      }else{
        if(distance(vec2(1.-wsize,1.-wsize),openfl_TextureCoordv.xy)<wsize){
          gl_FragColor=color;
          ;
        }else{
          gl_FragColor=vec4(0.,0.,0.,0.);
          ;
        };
        ;
      };
      ;
    };
    ;
  };
  if((openfl_TextureCoordv.x>xsize || openfl_TextureCoordv.y>xsize) && openfl_TextureCoordv.x<0.5 && openfl_TextureCoordv.y<0.5){
    gl_FragColor=color;
    ;
  };
  if((openfl_TextureCoordv.x<1.-ysize || openfl_TextureCoordv.y>ysize) && openfl_TextureCoordv.x>0.5 && openfl_TextureCoordv.y<0.5){
    gl_FragColor=color;
    ;
  };
  if((openfl_TextureCoordv.x>zsize || openfl_TextureCoordv.y<1.-zsize) && openfl_TextureCoordv.x<0.5 && openfl_TextureCoordv.y>0.5){
    gl_FragColor=color;
    ;
  };
  if((openfl_TextureCoordv.x<1.-wsize || openfl_TextureCoordv.y<1.-wsize) && openfl_TextureCoordv.x>0.5 && openfl_TextureCoordv.y>0.5){
    gl_FragColor=color;
    ;
  };
  
}
