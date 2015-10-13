// PoVRay 3.7 Scene File "Stair_0demo.pov"
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera0 = camera {ultra_wide_angle angle 60           // front view
                        location  <0.0 , 1.5 ,-4.5>
                        right     x*image_width/image_height
                        look_at   <0.0 , 2.3 , 0.0>}
#declare Camera1 = camera {ultra_wide_angle angle 14.0           //   far view
                        location  <0.0 , 1.5 , -35.0>
                        right     x*image_width/image_height
                        look_at   <0.0 , 2.50 , 0.0>}
#declare Camera2 = camera {ultra_wide_angle angle 90      // right side view
                        location  <3.0 , 2.3 , 0.0>
                        right     x*image_width/image_height
                        look_at   <0.0 , 1.0 , 0.0>}
#declare Camera3 = camera {ultra_wide_angle angle 90             // top view
                        location  <0.0 , 3.0 ,-0.001>
                        right     x*image_width/image_height
                        look_at   <0.0 , 1.0 , 0.0>}
camera{Camera1}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.76  scale 3
                         color_map { [0.65 rgb <0.20, 0.20, 1.0>]
                                     [0.8 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                         translate<2,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   100
    color      White
    fog_offset 0.1
    fog_alt    1.5
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{<0,1,0>, 0 texture{ pigment{color rgb<0.35,0.65,0.0>}
		          normal {bumps 0.75 scale 0.015}
                          finish {ambient 0.1 diffuse 0.8}}}
//--------------------------------------------------------------------------
//----------------------- scenery objects ---------------------------------- 
//--------------------------------------------------------------------------



//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Railing_Texture = 
   texture { Chrome_Metal  
             //pigment{ color rgb<1,1,1> } 
             finish { phong 0.1} 
           } // end of texture
#declare Step_Texture = 
   texture { pigment{ color rgb<1,1,1>*1.0 } 
             finish { phong 0.1} 
           } // end of texture
//---------------------------------------------------------------------------------------
#include "Stair_0.inc" 
//-------------------------------------------------------------------------------------// 
union{
object{ Stair_0(  2.00, // Stair___H, // stair total height
                  3.50, // Stair___X, // length of stair in x direction    
                  0.175,// Step___H_, // ca. single step height - adapted to fit the height                           
                  1.50, // Step___Z, // width  of a step in z direction
                  3, // Banisters_On 1=right; 2 = left; 3= both ; 0= off;
                  0.03, // Railing___R, // radius of railing linear tubes
                  0.02, // Railing___Rv // radius of vertical tubes 
                  0.75, // Railing___H, // railing heigth 
                  Railing_Texture, // 
                  Step_Texture   // 
                ) //-------------------------------------------------------------------//
        scale <1,1,1>*1
        } 
object{ Stair_0(  2.00, // Stair___H, // stair total height
                  3.50, // Stair___X, // length of stair in x direction    
                  0.175,// Step___H_, // ca. single step height - adapted to fit the height                           
                  1.50, // Step___Z, // width  of a step in z direction
                  3, // Banisters_On 1=right; 2 = left; 3= both ; 0= off;
                  0.03, // Railing___R, // radius of railing linear tubes
                  0.02, // Railing___Rv // radius of vertical tubes 
                  0.75, // Railing___H, // railing heigth 
                  Railing_Texture, // 
                  Step_Texture   // 
                ) //-------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,-90,0>
        translate<1.50+3.50,2.00,1.50>
        } 
object{ Stair_0(  2.00, // Stair___H, // stair total height
                  3.50, // Stair___X, // length of stair in x direction    
                  0.175,// Step___H_, // ca. single step height - adapted to fit the height                           
                  1.50, // Step___Z, // width  of a step in z direction
                  3, // Banisters_On 1=right; 2 = left; 3= both ; 0= off;
                  0.03, // Railing___R, // radius of railing linear tubes
                  0.02, // Railing___Rv // radius of vertical tubes 
                  0.75, // Railing___H, // railing heigth 
                  Railing_Texture, // 
                  Step_Texture   // 
                ) //-------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0, 0,0>
        translate<1.50+3.50,4.00,1.50+3.50>
        } 

box{ <0.00,-0.15,0.00>,<1.50,0,1.50> texture{Step_Texture} 
        translate<3.50,2.00,0.00>
        }
box{ <0.00,-0.15,0.00>,<1.50,0,1.50> texture{Step_Texture} 
        translate<3.50,4.00,3.50+1.50>
        }

        rotate<0,-50,0> 
        translate<-0.25,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

sphere { <0,0,0>, 0.05 

         texture { pigment{ color Red } // rgb< 1, 0.0, 0.0>}
                   finish { diffuse 0.9 phong 1 reflection 0.00}
                 } // end of texture 

          scale<1,1,1>  rotate<0,0,0>  translate<-0.25,0.0,0>  
       }  // end of sphere ----------------------------------- 






