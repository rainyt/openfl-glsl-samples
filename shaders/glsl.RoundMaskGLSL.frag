#pragma header

bool checkRound(float x,float y,float size){
  return distance(vec2(x,y),openfl_TextureCoordv.xy)<size;
  
}
uniform vec4 u_px;

void main(void){#pragma body
  float xsize=radians(u_px.x);
  float ysize=radians(u_px.y);
  float zsize=radians(u_px.z);
  float wsize=radians(u_px.w);
  if(checkRound(xsize,xsize,xsize) || checkRound(1.-ysize,ysize,ysize) || checkRound(zsize,1.-zsize,zsize) || checkRound(1.-wsize,1.-wsize,wsize)){
    gl_FragColor=color;
  }else{
    gl_FragColor=vec4(0.);
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
