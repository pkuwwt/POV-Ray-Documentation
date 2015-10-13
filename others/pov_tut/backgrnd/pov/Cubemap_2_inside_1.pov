// POV-Ray 3.7 Scene File "Cubemap_2_inside_1.pov"
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
//---------------------------
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = <0.00, 1.00, -20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  55 ;
#break
#case (1)
  #declare Camera_Position = <  0.00, 2.00, -5.00> ;  // front view up
  #declare Camera_Look_At  = < -1.00, 4.50,  0.00> ;
  #declare Camera_Angle    =  85 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  55 ;
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

// sky ---------------------------------------------------------------------
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
//--------------------------------------------------------------------------------------
box{<-1, -1, -1>,< 1, 1, 1>
 texture{ uv_mapping
   Correct_Pigment_Gamma( // gamma correction
     pigment{
     image_map{ jpeg "Cubemap_2_2048x1536.jpg"
                map_type 0    // planar
                interpolate 2 // bilinear
                once //
              } //  end of image_map
   
    } // end of pigment
    , 2.5) //, New_Gamma
    finish { ambient 1  diffuse 0 }
 } // end of texture
scale 10000
} // end of skybox --------------------


//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

// ...  //








