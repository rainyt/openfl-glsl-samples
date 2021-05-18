#define TEXT 1
uniform float time;
uniform vec2 resolution;
uniform vec2 mouse;
bool b;
float abc;

void main(void){
  time++;
  --time;
  if(!(time>10. || time<30. && time!=0.)){
    gl_FragColor=vec4(float(TEXT),1.,0.,1.);
    ;
  }else{
    if(time==0.){
      gl_FragColor=vec4(1.,1.,0.5,1.);
      ;
    }else{
      gl_FragColor=vec4(1.,1.,1.,1.);
      ;
    };
  };
  float w=0.;
  while(w<100.){
    for(int i = 0;i<10;i++){
      w++;
      
    };
    
  };
  int w2=1;
  float w3=1.;
  w3+=abc;
  
}
