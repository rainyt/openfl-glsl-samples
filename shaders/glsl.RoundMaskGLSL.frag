#pragma header
bool checkRound(float x,float y,float size){
  return distance(vec2(x,y)*openfl_TextureSize,openfl_TextureCoordv.xy*openfl_TextureSize)<size*openfl_TextureSize.x;
}
uniform vec4 u_px;
void main(void){#pragma body
  float xsize=u_px.x/openfl_TextureSize.x;
  float xsize_y=u_px.x/openfl_TextureSize.y;
  float ysize=u_px.y/openfl_TextureSize.x;
  float ysize_y=u_px.y/openfl_TextureSize.y;
  float zsize=u_px.z/openfl_TextureSize.x;
  float zsize_y=u_px.z/openfl_TextureSize.y;
  float wsize=u_px.w/openfl_TextureSize.x;
  float wsize_y=u_px.w/openfl_TextureSize.y;
  gl_FragColor=vec4(0.);
  if((openfl_TextureCoordv.x>xsize || openfl_TextureCoordv.y>xsize_y) && openfl_TextureCoordv.x<0.5 && openfl_TextureCoordv.y<0.5){
    gl_FragColor=color;
  }
  if((openfl_TextureCoordv.x<1.-ysize || openfl_TextureCoordv.y>ysize_y) && openfl_TextureCoordv.x>0.5 && openfl_TextureCoordv.y<0.5){
    gl_FragColor=color;
  }
  if((openfl_TextureCoordv.x>zsize || openfl_TextureCoordv.y<1.-zsize_y) && openfl_TextureCoordv.x<0.5 && openfl_TextureCoordv.y>0.5){
    gl_FragColor=color;
  }
  if((openfl_TextureCoordv.x<1.-wsize || openfl_TextureCoordv.y<1.-wsize_y) && openfl_TextureCoordv.x>0.5 && openfl_TextureCoordv.y>0.5){
    gl_FragColor=color;
  }
  if(checkRound(xsize,xsize_y,xsize) || checkRound(1.-ysize,ysize_y,ysize) || checkRound(zsize,1.-zsize_y,zsize) || checkRound(1.-wsize,1.-wsize_y,wsize)){
    gl_FragColor=color;
  }
}