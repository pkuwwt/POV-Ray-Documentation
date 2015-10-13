// PoVRay 3.7 Scene File "IsoWater_001.pov"
// author: Friedrich A. Lohmueller, April-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
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
                            location  <0.0 , 2.0 ,-9.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <5.0 , 10.5 ,-5.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 40        // top view
                            location  <0.0 , 30.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<-2500,1500,-1500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.25, 0.30, 1.0>*0.7]
                                     [0.50 rgb <0.25, 0.30, 1.0>*0.7]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   150
      color      White  
      fog_offset 0.1
      fog_alt    2.5
      turbulence 1.8
    }
// -------------------------------------------------------------------



//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#declare Water_Texture = texture{ Polished_Chrome } 

// pigment for isosurface modulation
// and pigment pattern for normal 
#declare Pigment_01 =
pigment { bumps   
          turbulence 0.2
          scale <3,1,1> 
} // end pigment
//---------------------------------------
#declare Pigment_Function_01 = 
function { 
  pigment { Pigment_01 }
} // end of function 
//---------------------------------------

// sizes x/z of isosurface container box
#local Scale_x = 10;  
#local Scale_z = 7; 
#local Iso_Start =<-Scale_x,-1.0,-Scale_z>; 
#local Iso_End   =< Scale_x, 1.0, Scale_z>; 
//---------------------------------------
isosurface {

  function{
    y 
   -Pigment_Function_01(x, y, z).gray* 0.95  
  } // 
 
  contained_by { box {Iso_Start,Iso_End} }
  accuracy 0.01
  max_gradient 2
 
  texture{ Polished_Chrome
           normal { pigment_pattern {  Pigment_01 } }
         }
  // dont scale this isosurface! 
  // scale the Pigment_01 if necessary!  
translate <0, -0.3, 0>
} // end of isosurface ------------------------
//--------------------------------------------- 



difference{ // far away with 'pigment pattern'
 plane{<0,1,0>, 0 }
 box { Iso_Start,Iso_End  } 
 texture{ 
    Water_Texture  
    normal{ 
     pigment_pattern{ Pigment_01 }, 5}
          }
     translate<0,0.0,0>
     }

//-------------------------------- white frame
difference{ 
box{ <-6.00,-1.00, 0.00>,< 0.00, 0.50, 6.00> }  
box{ <-5.50,-1.01, 0.50>,<-0.50, 0.51, 5.50> }  

     texture { pigment{ color rgb<1,1,1>}  
               finish { phong 1 } 
             } // end of texture

     rotate<0,45,0> translate<0,0,-6> 
   } // end of box ---------------------------
//--------------------------------------------

 