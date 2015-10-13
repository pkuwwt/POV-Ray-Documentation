// PoVRay 3.7 Scene File "Window_3_demo.pov"
// author: Friedrich A. Lohmueller, March-2007/Aug-2009/Jan-2011
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 23      // front view
                            location  < 1.0 , 2.73 ,-6.5>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.00 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <2.0 , 2.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}

// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.65 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.75 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [0.90 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate<-1,0,2>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   50
      color      White  
      fog_offset 0.1
      fog_alt    1.5
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
#declare Wall_Texture = 
       texture { pigment{ color rgb< 1, 0.90, 0.85>  }// very light brown  
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1 reflection 0.00}
               } // end of texture 
//----------------------------------------------------------------------------- textures
#declare Window_3_Texture = 
   texture { // pigment{ color rgb< 0.75, 0.5, 0.30>*0.5 } // brown  
             pigment{ color rgb<1,1,1>*1.2 } 
             finish { phong 0.1} 
           } // end of texture
//---------------------------------------------------------------------------------------
#include "Window_3.inc" 
//-------------------------------------------------------------------------------------// 
#declare Windows_Position_1 = <-0.60,0,0>;
#declare Windows_Position_2 = < 0.60,0,0>;
union{ 
 difference{ 
  box{ <-1.5,0,-0.075>,<1.5,2,0.075>  texture{Wall_Texture}}       
  object { Window_3_Hole translate Windows_Position_1  texture{Wall_Texture}}
  }

 object { Window_3_Hole translate Windows_Position_2  texture{pigment{color rgb<1,1,1>*1.2 transmit 0.5}}}

 object{ Window_3(0.8, 0.2) // Window_Open_Right, Window_Open_Left: 0= closed; 1= opened   
         texture { Window_3_Texture } 
         translate Windows_Position_1 
       }
 //--------------------------------------------------------------------------------------
rotate<0,-45,0>   translate<  0.15,0.00,0.00>
} //-------------------------------------------------------------------------------------








