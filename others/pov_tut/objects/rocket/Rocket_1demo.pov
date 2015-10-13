// PoVRay 3.7 Scene File "Rocket_1demo.pov"
// author: Friedrich A. Lohmueller, May-2006/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle  50      // front view
                            location  < -5.00, 0.50,-10.00>
                            right     x*image_width/image_height
                            look_at   < -1.50, 3.50, 0.00> }
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
light_source{<-1500,1500,-2500> color White}

// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.60 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.75 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< -1,0,0.5>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   300
      color      White  
      fog_offset 0.1
      fog_alt    4.5
      turbulence 1.8
    }

// ground ------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <1.00,0.95,0.8>}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Rocket_Texture = 
   texture { //Chrome_Metal}  
             pigment{ color rgb<1,1,1>*1.0} 
             finish { phong 0.1} 
           } // end of texture
#declare Rocket_Metal = 
   texture { // Polished_Chrome// 
             // Chrome_Metal  
             T_Chrome_1A
             // pigment{ color rgb<1,1,1>*1.1} 
             // normal { bumps 0.25 scale 0.0015}
             finish { phong 1 reflection 0.3} 
           } // end of texture
//------------------------------------------------------------------------------------//
#include "Rocket_1.inc"  // height ~ 7.40 m
//------------------------------------------------------------------------------------//
#declare Rocket = 
object{ Rocket_1 (  Rocket_Texture, 
                    Rocket_Metal 
                 ) //-----------------   
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------
#declare R_Distance = 5;  

union{
object{ Rocket rotate<0,0,0> translate<0.00,0.00,0*R_Distance>}
object{ Rocket rotate<0,0,0> translate<0.00,0.00,1*R_Distance>}
object{ Rocket rotate<0,0,0> translate<0.00,0.00,2*R_Distance>}
object{ Rocket rotate<0,0,0> translate<0.00,0.00,3*R_Distance>}
object{ Rocket rotate<0,0,0> translate<0.00,0.00,4*R_Distance>}
object{ Rocket rotate<0,0,0> translate<0.00,0.00,5*R_Distance>}
object{ Rocket rotate<0,0,0> translate<0.00,0.00,6*R_Distance>}
rotate<0,0,0>  translate<0.00,0.00,0.00> } 


//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

















