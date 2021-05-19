#pragma header
vec2 getUv(float x,float y){
  return vec2(x/openfl_TextureSize.x,y/openfl_TextureSize.y);
}
uniform vec2 u_size;
uniform vec4 u_s9d;
void main(void){#pragma body
  vec2 uv=openfl_TextureCoordv*u_size;
  float centerWidth=u_size.x-u_s9d.x-u_s9d.y;
  float centerHeight=u_size.y-u_s9d.z-u_s9d.w;
  float centerSliceWidth=openfl_TextureSize.x-u_s9d.x-u_s9d.y;
  float centerSliceHeight=openfl_TextureSize.y-u_s9d.z-u_s9d.w;
  gl_FragColor=vec4(0.);
  if(uv.x<u_s9d.x && uv.y<u_s9d.z){
    gl_FragColor=texture2D(openfl_Texture,getUv(uv.x,uv.y));
  }else{
    if(uv.x>u_size.x-u_s9d.y && uv.y<u_s9d.z){
      gl_FragColor=texture2D(openfl_Texture,getUv(u_s9d.x+centerSliceWidth+uv.x-(u_size.x-u_s9d.y),uv.y));
    }else{
      if(uv.x<u_s9d.x && uv.y>u_size.y-u_s9d.w){
        gl_FragColor=texture2D(openfl_Texture,getUv(uv.x,centerSliceHeight+u_s9d.z+uv.y-(u_size.y-u_s9d.w)));
      }else{
        if(uv.x>u_size.x-u_s9d.y && uv.y>u_size.y-u_s9d.w){
          gl_FragColor=texture2D(openfl_Texture,getUv(u_s9d.x+centerSliceWidth+uv.x-(u_size.x-u_s9d.y),centerSliceHeight+u_s9d.z+uv.y-(u_size.y-u_s9d.w)));
        }else{
          if(uv.y<u_s9d.z){
            gl_FragColor=texture2D(openfl_Texture,getUv(u_s9d.x+(uv.y-u_s9d.z)/centerWidth*centerSliceWidth,uv.y));
          }else{
            if(uv.y>u_size.y-u_s9d.w){
              gl_FragColor=texture2D(openfl_Texture,getUv(u_s9d.x+(uv.y-u_s9d.z)/centerWidth*centerSliceWidth,centerSliceHeight+u_s9d.z+uv.y-(u_size.y-u_s9d.w)));
            }else{
              if(uv.x<=u_s9d.x){
                gl_FragColor=texture2D(openfl_Texture,getUv(uv.x,u_s9d.z+(uv.y-u_s9d.z)/centerHeight*centerSliceHeight));
              }else{
                if(uv.x>u_size.x-u_s9d.y){
                  gl_FragColor=texture2D(openfl_Texture,getUv(centerSliceWidth+u_s9d.x+uv.x-(u_size.x-u_s9d.y),u_s9d.z+(uv.y-u_s9d.z)/centerHeight*centerSliceHeight));
                }else{
                  gl_FragColor=texture2D(openfl_Texture,getUv(u_s9d.x+(uv.y-u_s9d.z)/centerWidth*centerSliceWidth,u_s9d.z+(uv.y-u_s9d.z)/centerHeight*centerSliceHeight));
                };
              };
            };
          };
        };
      };
    };
  }
}