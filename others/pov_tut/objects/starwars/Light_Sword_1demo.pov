// PoVRay 3.7 Scene File ""Light_Sword_1demo.pov"
// author:  Friedrich A. Lohmueller, Oct-2008/Jan-2011
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
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<

camera{ /*ultra_wide_angle*/  
        location < 0.00, 0.50,-1.00>
        right     x*image_width/image_height
        angle 65                                                      
        look_at  < 0.00, 0.50, 0.00>
      }
//------------------------------------------------------------------------------------------------------<<<<<
// sun ---------------------------------------------------------------------
#local Sky_Dimmer = 0.25; 

light_source{<1500,2500,-2500> color White*0.9*Sky_Dimmer  media_interaction off }           // sun light
light_source{<0.00,0.50,-1.00> color rgb<0.9,0.9,1>*0.1*Sky_Dimmer  media_interaction off}  // flash light

// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>*Sky_Dimmer]
                                   [0.30 rgb <0.0,0.1,1.0>*Sky_Dimmer]
                                   [0.70 rgb <0.0,0.1,1.0>*Sky_Dimmer]
                                   [1.00 rgb <1.0,1.0,1.0>*Sky_Dimmer] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White*Sky_Dimmer
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <1.00,0.95,0.8>}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------





// ----------------------------------------------------------
global_settings { max_trace_level 10 }//(1...256) [default = 5]

// ----------------------------------------------------------
#include "Light_Sword_1.inc"
// ----------------------------------------------------------
object{ Light_Sword_1 ( 1.0, // Blade_Length,  min: 0.08
                        0.15, // Handle_Len, 
                     
                        0.04,     // Aura_R,   
                        0.02,     // Center_R, 
                        0.025,     // Handle_R,  
                     
                        <1.0,0.3,0.8>*1.5,  // Aura_Color,  
                        <1.0,0.1,0.5>*10 ,  // Center_Color,
                        <0.5,0.0,0.3>*0.75  // Shining_Color
                      ) // --------------------------------

         rotate< 10,0,-60>  translate<-0.40,0.20,-0.10>     
       } // end of object "Light_Sword" --------------------- 
// ----------------------------------------------------------
// ----------------------------------------------------------
object{ Light_Sword_1 ( 1.0, // Blade_Length, min: 0.08 
                        0.15, // Handle_Len, 
                     
                        0.04,     // Aura_R,   
                        0.02,     // Center_R, 
                        0.025,     // Handle_R,  
                     
                        <0.4,0.3,1.0>*1.5,  // Aura_Color,  
                        <0.6,0.1,1.0>*7 ,   // Center_Color,
                        <0.3,0.0,0.5>*0.75  // Shining_Color
                      ) // --------------------------------

         rotate<-10,0, 50>  translate< 0.60,0.20,0.30>  
       } // end of object "Light_Sword" --------------------- 
// ----------------------------------------------------------
// ----------------------------------------------------------
// ----------------------------------------------------------

