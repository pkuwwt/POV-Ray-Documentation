// PoVRay 3.7 Scene File "Mast_1demo.pov"
// author: Friedrich A, Lohmueller, Jan-2006/Aug-2009/Jan-2011
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
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
#declare Cam_Pos_1 = < 2.50, 15.50,-3.80>;  // diagonal view
#declare Look_At_1 = < 0.52, 12.30, 0.55>; 
#declare Camera_Angle = 75; // in degrees

#declare Camera_X = camera { angle Camera_Angle 
                             location Cam_Pos_1
                             right  x*image_width/image_height
                             look_at Look_At_1 } 
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
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
camera{Camera_X}
// sun ---------------------------------------------------------------------
light_source{<-1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>]
                                   [0.30 rgb <0.0,0.1,1.0>]
                                   [0.70 rgb <0.0,0.1,1.0>]
                                   [1.00 rgb <1.0,1.0,1.0>] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <0.825,0.57,0.35>}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------












//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ textures
#declare Mast_Texture = 
 texture { //Chrome_Metal}  
           pigment{ color rgb<1,1,1> } 
           finish { phong 0.1} 
         } // end of texture
//-------------------------------------------------------------------------------------//
#include "Mast_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Mast_1(   8, // number of segments * segment height = total height 
                  2.00, // segment_height
                  1.00, // half width (outline!)
                  0.050,  // R1, tube main radius
                  0.025   // R2, tube diagonals radius 
                                 
                 ) //------------------------------------------------------------------//
        texture { Mast_Texture }
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.05, 0.00>}
//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------
// base:   
#declare Base_Texture =
 texture{ pigment{ color rgb<1,1,1>*0.7}
          finish { phong 1}
        } // end of texture

box {<-1,0,-1>,< 1,1,1> scale <1.1,0.05,1.1> texture{Base_Texture}}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------







