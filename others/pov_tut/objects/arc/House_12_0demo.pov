// PoVRay 3.7 Scene File "House_12_0demo.pov"
// author: Friedrich A. Lohmueller, Jan-2006/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Cam_Pos_0 = <-12.0 , 2.0 ,-35.0>; 
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle  33      // front view
                            location  Cam_Pos_0
                            right     x*image_width/image_height
                            look_at   <4.0 , 2.0 , 0.0>}
#declare Cam_Pos_1 =<-14.00,7.60,-17.00>; 
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 50   // diagonal view
                            location  Cam_Pos_1
                            right     x*image_width/image_height
                            look_at   < 4.50, -1.00, 5.00>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White *0.9}
light_source{ Cam_Pos_1 color White * 0.1}
// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                         scale<1,1,1.7>*2.5  translate< 0,0,0>
                         rotate<0,20,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   200
      color      White*0.9  
      fog_offset 0.1
      fog_alt    4.5
      turbulence 1.8
    }
// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Wall_Texture_Outside = 
      texture { pigment{ color White*1.1}
                normal { bumps 0.5 scale 0.005} 
                finish { phong 1}
              } // end of texture
//----------------------------------------------------------------
#declare Wall_Texture_Inside = 
      texture { pigment{ color White*1.1}
                finish { phong 1}
              } // end of texture
//----------------------------------------------------------------
#declare Roof_Texture = 
// layered texture!!!
      texture { pigment{ color rgb<0.8,0.30,0.2>*0.9} 
                normal { gradient z scallop_wave scale<1,1,0.15>} 
                finish { phong 1}
              } // end of texture
 
      texture { pigment{ gradient x 
                         color_map{[0.00 color Clear]
                                   [0.90 color Clear]
                                   [0.95 color White*0.1]
                                   [1.00 color White*0.1]}
                          scale 0.25}
                 finish { phong 1}
              } // end of texture

//---------------------------------------------------------------
#declare Window_Texture = 
         texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.35 } // brown  
                  // pigment{ color White*1.2}
                  finish { phong 0.1}}
//-------------------------------------------------------------------------------------// 
#include "House_12_0.inc"
//-------------------------------------------------------------------------------------// 
object{ House_12_0 ( // main house: x = +/-2.80, h = 5.20, z = 7.50,
                     // side part : z = 4.60, x ~ 2.50, h = 4.70. 
                     Wall_Texture_Outside
                     Wall_Texture_Inside 
                     Window_Texture
                     Roof_Texture
                   )  //----------------------------------------------------------------//
        rotate<0, 0,0>
        translate<-1+1,0.00, -2>
      }   
//---------------------------------------------------------------------------------------
object{ House_12_0 ( // main house: x = +/-2.80, h = 5.20, z = 7.50,
                     // side part : z = 4.60, x ~ 2.50, h = 4.70. 
                     Wall_Texture_Outside
                     Wall_Texture_Inside 
                     Window_Texture
                     Roof_Texture
                   )  //----------------------------------------------------------------//
        rotate<0,-90,0>
        translate  <17-2,0,2>
      }   
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------