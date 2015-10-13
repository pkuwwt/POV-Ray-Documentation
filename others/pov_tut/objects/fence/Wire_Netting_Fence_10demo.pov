// PoVRay 3.7 Scene File "Wire_Netting_Fence_10demo.pov"
// author: by Friedrich A. Lohmueller, Jan-2006/Aug-2009/Jan-2011
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












//---------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------//
#declare Fence_Post_Texture = 
         texture { pigment{ color rgb< 1, 1, 1>*0.75 } 
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1}
                 } // end of texture 

//---------------------------------------------------------------------------------------//
#include "Wire_Netting_Fence_10.inc" // a wire netting fence
//-------------------------------------
//global_settings { max_trace_level 10 }//(1...256) [default = 5] 

#declare Fence_Segment = 
//---------------------------------------------------------------------------------------// 
object{ Wire_Netting_Fence_10(  2.00, // Fence_Width_X, // width of fence in x direction
                                1.80, // Fence_Heigth_Y,// width of fence in y direction
                                0.079, // Wire_Net_Width,  //  net width   
                                0.03,  // Wire_Net_Radius, //
                                <1,1,1>*0.5, // Wire_Color // color of the wire
                                0.035, // Fence_Post___Radius,  // Zaunpfahl
                                Fence_Post_Texture // 
                              ) //-------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0, 0,0> 
        translate<-1.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------//

union{ 
object{ Fence_Segment  rotate<0, 0,0> translate<0*2.00, 0, 0*2.00>}
object{ Fence_Segment  rotate<0, 0,0> translate<1*2.00, 0, 0*2.00>}
object{ Fence_Segment  rotate<0, 0,0> translate<2*2.00, 0, 0*2.00>}
object{ Fence_Segment  rotate<0, 0,0> translate<3*2.00, 0, 0*2.00>}
object{ Fence_Segment  rotate<0, 0,0> translate<4*2.00, 0, 0*2.00>}
object{ Fence_Segment  rotate<0, 0,0> translate<5*2.00, 0, 0*2.00>}
object{ Fence_Segment  rotate<0, 0,0> translate<6*2.00, 0, 0*2.00>}
object{ Fence_Segment  rotate<0, 0,0> translate<7*2.00, 0, 0*2.00>}
object{ Fence_Segment  rotate<0, 0,0> translate<8*2.00, 0, 0*2.00>}

scale < 1,1,-1> rotate<0,-60,0> translate<-0.0,0.00,-1.5> 
} // end of union












