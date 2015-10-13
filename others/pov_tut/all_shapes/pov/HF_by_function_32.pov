// POV-Ray 3.6/3.7 Scene File "HF_by_function_32.pov"
// author: Friedrich A. Lohmueller, Oct-2008/Aug-2009/Jan-2011
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
#declare Camera_Position =  < 1.70, 0.30,-0.70> ; 
#declare Camera_look_at  =  < 0.62, 0.05, 0.35> ;                   
#declare Camera_Angle    =  30 ; // in degrees
//--------------------------------------------------------------------------------------------------------<<<<

camera{ /*ultra_wide_angle*/   
        location  Camera_Position
        right     x*image_width/image_height
        angle Camera_Angle   
        look_at   Camera_look_at
      }
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<500,1500,-2500> color White*0.8}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.2 color rgb<0.14,0.14,0.56>*0.7]//~Navy
                                [0.8 color rgb<0.14,0.14,0.56>*0.7]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere 
//------------------------------------------------------------------------
 
fog { fog_type   2
      distance   10
      color      rgb<1,0.95,0.8>  
      fog_offset 0.1
      fog_alt    0.2
      turbulence 1.8
    }
 
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

#declare HF_Res_X = 1024; // number of points in x
#declare HF_Res_Z = 1024; // number of points in z
 
#declare SF = 
function {
   pigment { 
   boxed 
     color_map {
       [0.0, color 0.0 ]
       [0.5, color 0.8 ]
       [1.0, color 1.0 ]
     } // end color_map
    scale <0.5,1,0.5>
    translate<0.5,0,0.5>
   } // end pigment
 } // end function
    
#declare HF_Function   =  
   function(x, y, z)
  { 1+f_snoise3d(x*10,y*10,z*10)*0.30   * SF(x,y,z).gray }

#declare HF_Amplitude    = 0.5;
#declare D = 0.00001; // just a little bit! 


union{ 

intersection{
  height_field{
    function HF_Res_X, HF_Res_Z { HF_Function(x,0,y) * HF_Amplitude }
    // smooth
    //  water_level 0 
    translate<0,D-0.4 ,0>
  } // end HF
  box{ <D,-0.10,D>,<1-D,0.2-D,1-D>
  } // end box
  translate<0,-0.10,0>
 } // end intersection



difference{ // ground with hole 
plane { <0,1,0>, 0 }    
box{ <D,-0.10,D>,<1-D,0.2-D,1-D>}
}

 scale<1,1,1> 
 translate<0,0,0>
 texture { pigment{ color rgb <1.00,0.95,0.8>}
           normal { bumps 0.75 scale 0.0025  }
           finish { phong 0.1 } 
         } 
} // end union -----------------------------------------------



