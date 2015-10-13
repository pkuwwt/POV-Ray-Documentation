// PoVRay 3.7 Scene File "truck_01.pov"
// author:  Friedrich A. Lohmueller, Nov-2006/Aug-2009/Jan-2011
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
                            location  <0.0 , 1.0 ,-15.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 45   // diagonal view
                            location  < 9.00, 2.00,-7.00>
                            right     x*image_width/image_height
                            look_at   <-1.00, 1.50, 0.00>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <15.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 ,15.0 ,-0.001>
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

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
/* 
// alternative declaration of textures
#declare Street_Texture = 
      texture{ pigment{ color rgb<1,1,1>*0.4}
               normal { bumps 0.25 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture
#end
#ifndef( Stripes_Texture )
#declare Stripes_Texture = 
      texture{ pigment{ color rgb<1,1,1>*1.1}
             //normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.5}
             } // end of texture
*/
//-------------------------------------------------------------------------------------// Street
#include "Street_10.inc"  // street with center stripes with continuous border lines
//-------------------------------------------------------------------------------------// 
object{ Street_10( 6,     // Street_Widthm, // 
                   1000 , // Street_Length, //
                   0.10,  // Stripes_Width, // 
                   1.00,  // Stripes_Length                                  
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,90,0> 
        translate<-500.00,0.00,0.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------
object{ Street_10( 6,     // Street_Widthm, // 
                   1000 , // Street_Length, //
                   0.10,  // Stripes_Width, // 
                   1.00,  // Stripes_Length                                  
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,90,0> 
        translate<-500.00,0.00,6.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------




//--------------------------------------------------------- Trucks 
#declare Trailer_Angle = 0; //  ~ +/-110
#declare Wheel_Angle   = 0; // ~  +/-60
#declare Truck_Texture =  
   texture{ pigment{ color rgb<1,1,1>*1.1}
            finish { diffuse 0.9 phong 1}
          }
//----------------------------------------
#include "Truck_01.inc"
//---------------------------------------------------------
object{ Truck_01( Wheel_Angle, // Front wheel angle: ~  +/-60
                  Trailer_Angle, // Trailer angle:   ~ +/-110
                  Truck_Texture 
                ) //-----------------------------------------
scale< 1,1,1>
rotate<0,0,0> translate<2.00,0,-1.5>}
//---------------------------------------------------------
//---------------------------------------------------------
object{ Truck_01( Wheel_Angle, // Front wheel angle: ~  +/-60
                  Trailer_Angle, // Trailer angle:   ~ +/-110
                  Truck_Texture 
                ) //-----------------------------------------
scale<-1,1,-1>
rotate<0,0,0> translate<-10.50,0, 6.5>}
//---------------------------------------------------------







