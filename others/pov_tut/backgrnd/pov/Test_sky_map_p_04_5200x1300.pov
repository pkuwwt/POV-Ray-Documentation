// POV-Ray 3.7 Scene File "Test_sky_map_p_04_5200x1300.pov"
// author: Friedrich A. Lohmueller, Dec-2009 / Jan-2011
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
//--------------------------------------------------------------------------------------------------------<<<<
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 0.01, -0.0001> ;  // vertical up 180� view
  #declare Camera_Look_At  = < 0.00,150,  0.00> ;
  #declare Camera_Angle    = 179.999 ;
#break
#case (1)
  #declare Camera_Position = < 5.00, 1.00,-5.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 4.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-10.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light


//-----------------------------------------------------------------------------  
// Adaption of images for image_map to assumed_gamma = 1.0 : 
#ifndef( Correct_Gamma) #declare Correct_Gamma = 1.5; #end  // display_gamma = 2.2
#macro Correct_Pigment_Gamma(Original_Pigment_, New_Gamma_)
  #local Correct_Pigment_fn = function{ pigment {Original_Pigment_ } }
  pigment{ average pigment_map{
      [function{ pow(Correct_Pigment_fn(x,y,z).x, New_Gamma_)} color_map{[0 rgb 0][1 rgb<3,0,0>] } ]
      [function{ pow(Correct_Pigment_fn(x,y,z).y, New_Gamma_)} color_map{[0 rgb 0][1 rgb<0,3,0>] } ]
      [function{ pow(Correct_Pigment_fn(x,y,z).z, New_Gamma_)} color_map{[0 rgb 0][1 rgb<0,0,3>] } ]
    } }
#end // 
// "image_map" Gamma corrected :
//    Correct_Pigment_Gamma(
//    pigment{ image_map{ jpeg "colors.jpg"}}
//    , Correct_Gamma)
// sky --------------------------------------------------------------
//sphere{<0,0,0>, 1
//   texture{
sky_sphere{
   //---------------------- gamma correction 
   Correct_Pigment_Gamma( 
     pigment{
     image_map{ jpeg "sky_map_p_04_5200x1300.jpg"
                map_type 2    // cylindrical
                interpolate 2 // bilinear
                once //
              } //  end of image_map
             scale<1,1.02,1> 
    } // end of pigment
    , 2.2) //, Correct_Gamma)
   //------------------------- 
   rotate<0,30,0>
} // end of sky_sphere
 
  

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

 









