// PoVRay 3.7 Include File "Fence_1demo.pov"
// author: Friedrich A. Lohmueller, Jan 2006/Aug-2009/Jan-2011
// homepage: http://www.f-lohmueller.de  
// email: Friedrich.Lohmueller_AT_t-online.de

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
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 60   // diagonal view
                            location  <5.0 , 1.2 ,-4.0>
                            right     x*image_width/image_height
                            look_at   <2.5 , 0.8 , 2.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}

// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
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



//--------------------------------------------------------------------- textures

#declare Fence_Texture = // (wood structures by default in direction z) 
         texture { pigment{ color rgb<1,1,1>*1.1}// 0.75, 0.5, 0.30>*1.00 } 
                   normal { bumps 0.25 scale 0.005 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

//-----------------------------------------------------------------------------
#include "Fence_1.inc"
//-----------------------------------------------------------------------------
#declare Fence_Segment = 
object{ Fence_1 ( 0.80, // Fence_Height, 
                    1.90, // Fence_Length_x,
                    13,   // Number_of_Elements_x,
                    0.10, // Element_Length_x, 
                    0.03, // Element_Depth_z, 
                    Fence_Texture) // -------------------------------
                translate<0.05,0.05,0.00> } // end of object{ Fence_1(...) ...}
//-----------------------------------------------------------------------------
#declare Pole = 
box { <-0.05, 0.00, -0.05>,< 0.05, 0.83, 0.05>   
      texture { Fence_Texture }  
    } // end of box --------------------------------------
//-----------------------------------------------------------------------------

union{ 
object{ Pole                           translate<0*2.00, 0, 0*2.00>} 
object{ Fence_Segment  rotate<0,  0,0> translate<0*2.00, 0, 0*2.00>}
object{ Pole                           translate<1*2.00, 0, 0*2.00>} 
object{ Fence_Segment  rotate<0,  0,0> translate<1*2.00, 0, 0*2.00>}
object{ Pole                           translate<2*2.00, 0, 0*2.00>} 
object{ Fence_Segment  rotate<0,-90,0> translate<2*2.00, 0, 0*2.00>}
object{ Pole                           translate<2*2.00, 0, 1*2.00>} 
object{ Fence_Segment  rotate<0,-90,0> translate<2*2.00, 0, 1*2.00>}
object{ Pole                           translate<2*2.00, 0, 2*2.00>} 

scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
} // end of union

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
