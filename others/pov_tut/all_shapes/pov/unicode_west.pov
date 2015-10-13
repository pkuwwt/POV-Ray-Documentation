// POV-Ray 3.6/3.7 Scene File "unicode1.pov"
// author: Friedrich A. Lohmueller, June 2004/Aug-2009/2011
// email:  Friedrich.Lohmueller_at_t-online.de 
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
//------------------------------------------
#include "colors.inc"
#include "textures.inc"
//--------------------------------------------------------------------------
#if (version < 3.7) global_settings{ assumed_gamma 1.0 } #end
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 70          // front view
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 2.5 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{< 1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
sky_sphere { pigment { color rgb <1.0,1.0,1.0>  
                     } // end of pigment
           } //end of skysphere
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
#declare V_Dist =1.2;
#declare H_Dist =1.1;
#declare Dist =1.0;

global_settings { charset utf8 }  // "\u5000"

//-----------------------------------------  
#declare The_Font0 = "ARIAL.TTF"   
// additional unicode fonts for asian characters:
#declare The_Font1 = "MSMINCHO.TTF"
#declare The_Font2 = "SIMSUN.TTF"
#declare The_Font3 = "ARIALUNI.TTF" 
#declare The_Font4 = "BATANG.TTF"
//-----------------------------------------

//------------------------------------------- unicode
union{
 text { ttf The_Font0 concat(chr(196),chr(203),chr(214),chr(220)," ",chr(8364)) 0.01, 0  
       texture{ pigment{ color rgb<0,0,0>} 
                normal { bumps 0.5 scale 0.01}
                finish { phong 0.1 }
              } // end of texture
translate<-1, 1*Dist,0>
}// 
 text { ttf The_Font0 concat(chr(228)," ",chr(235)," ",chr(246)," ",chr(252)," ",chr(946)) 0.01, 0   
       texture{ pigment{ color rgb<0,0,0>} 
                normal { bumps 0.5 scale 0.01}
                finish { phong 0.1 }//specular 1 reflection 0.25}
              } // end of texture
translate<-1, 0*Dist,0>
}// 
 
 text { ttf The_Font0 concat(" Friedrich A. Lohm",chr(252),"ller") 0.01, 0 scale<0.40,1,1>*0.75  
       texture{ pigment{ color rgb<0,0,0>} 
                normal { bumps 0.5 scale 0.01}
                finish { phong 0.1 }//specular 1 reflection 0.25}
              } // end of texture
translate<-1, -1*Dist,0>
}// 


/*

// only with  fonts 1, 2,3 or 4 installed!!!
 // Japan, Tokyo 
 text { ttf The_Font2 concat(chr(26085),chr(26412)," ",chr(26481),chr(20140)) 0.01, 0  
       texture{ pigment{ color rgb<0.5,0.25,0>*0} 
                normal { bumps 0.5 scale 0.01}
                finish { phong 0.1 }//specular 1 reflection 0.25}
              } // end of texture
translate<-1, -1*Dist,0>
}// 

 
 text { ttf The_Font3 concat(chr(26085),chr(26412)," ",chr(26481),chr(20140)) 0.01, 0   
       texture{ pigment{ color rgb<0.5,0.25,0>*0} 
                normal { bumps 0.5 scale 0.01}
                finish { phong 0.1 }//specular 1 reflection 0.25}
              } // end of texture
translate<-1, -2*Dist,0>
}//
*/
 

translate<-1.0,1.25*Dist+1,0>
}// end  of union

