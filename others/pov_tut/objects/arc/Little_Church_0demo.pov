// PoVRay 3.6 / 3.7 Scene File "Little_Church_0demo.pov"
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <0.0 , 1.0 ,-10.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 45   // diagonal view
                            location  <-18.00, 1.60,-30.00>
                            right     x*image_width/image_height
                            look_at   < 2.00, 4.00, 0.00>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White *0.9}
light_source{ <-18.00, 1.60,-30.00> color White * 0.1} // Camera_1_Position

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
      distance   150
      color      White  
      fog_offset 0.1
      fog_alt    3.5
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

//-------------------------------------------------------------------------------------// 
//--------------------------------------------------------------------- Textures  
#declare Wall_Texture = 
 texture { pigment{ color White*1.1}
           normal { bumps 0.5 scale 0.0025}
           finish { phong 0.2}
         } // end of texture
#declare Window_Hole_Texture = 
 texture { pigment{color White*0.8}
           finish { phong 0.2}
         } // end of texture
#declare Roof_Texture = 
// layered texture!!!
      texture { pigment{ color  rgb<0.8,0.30,0.2>*0.9} 
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

#declare Door_Texture = 
  texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.55 }// dark brown  
           normal { bumps 0.25 scale 0.025 }
           finish { diffuse 0.9 phong 1 reflection 0.00}
         } // end of texture 
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------// 
#include "Little_Church_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ Little_Church_0( Wall_Texture , // texture of the walls 
                         Window_Hole_Texture, // texture of window holes and inside
                         Roof_Texture,        // texture of roof in x direction    
                         Door_Texture
                       ) //------------------------------------------------------------// 
        scale <1,1,1>*1
        rotate<0,-20,0> 
        translate<6.0 ,0.00, -3.00>}
//-------------------------------------------------------------------------------------// 
//-------------------------------------------------------------------------------------// 
object{ Little_Church_0( Wall_Texture , // texture of the walls 
                         Window_Hole_Texture, // texture of window holes and inside
                         Roof_Texture,        // texture of roof in x direction    
                         Door_Texture
                       ) //------------------------------------------------------------// 
        scale <1,1,1>*1
        rotate<0,130,0> 
        translate<-4.00,0.00, -2.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------











