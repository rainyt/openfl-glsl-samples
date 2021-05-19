#pragma header

bool inAlpha(vec2 v2,float offestX,float offestY){
  return texture2D(openfl_Texture,v2+vec2(offestX,offestY)).a>0.;
  
}

bool circleCheck(vec2 v2,float len){
  float setpX=1./openfl_TextureSize.x*len;
  float setpY=1./openfl_TextureSize.y*len;
  float checkTimes=36.;
  float setp=3.14/checkTimes;
  for(int i = 0;i<36;i++){
    float r=setp*float(i);
    if(inAlpha(v2,setpX*sin(r),setpY*cos(r)) || inAlpha(v2,setpX*-sin(r),setpY*-cos(r))){
      return true;
    };
    
  };
  return false;
  
}
uniform float u_storksize;

void main(void){#pragma body
  for(int i = 0;i<5;i++){
    if(float(i)>u_storksize){
      break;
    };
    if(circleCheck(openfl_TextureCoordv,float(i))){
      gl_FragColor=vec4(1.,1.,0.,1.);
      if(color.a>0.){
        gl_FragColor=color;
        gl_FragColor.w=1.;
        
      };
      
    };
    
  };
  
}
