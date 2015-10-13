// POV-Ray 3.6 Scene File "Stereo_Ani_00_Combi_36_.pov"
// Sample file to combine stereo images together.
// author: Friedrich A. Lohmueller, Jan-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6;
global_settings{ assumed_gamma 1.0} 
#default{ finish{ ambient 0.1 diffuse 0.9}} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//------------------------ 
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
  // combine stereo images of right/left eye's view to one image
  //..................................................................... 
  #declare Camera_Position = < 0.00, 0.00,-8.18> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.00,  0.00> ;
  #declare Camera_Angle    =  14 ;
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
camera{ orthographic
        location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<

// Macro for the adjustment of images for POV-Ray 3.6.2
// for image_map with assumed_gamma = 1.0 ;
#macro Correct_Pigment_Gamma(Orig_Pig, New_G)
  #local Correct_Pig_fn =
      function{ pigment {Orig_Pig} }
  pigment{ average pigment_map{
   [function{ pow(Correct_Pig_fn(x,y,z).x, New_G)}
               color_map{[0 rgb 0][1 rgb<3,0,0>]}]
   [function{ pow(Correct_Pig_fn(x,y,z).y, New_G)}
               color_map{[0 rgb 0][1 rgb<0,3,0>]}]
   [function{ pow(Correct_Pig_fn(x,y,z).z, New_G)}
               color_map{[0 rgb 0][1 rgb<0,0,3>]}]
   }}
#end //
// "image_map" gamma corrected:
//    Correct_Pigment_Gamma(
//    pigment{ image_map{ jpeg "Image.jpg"}}
//    , Correct_Gamma)
//------------------------------------------------
//------------------------------------------------
#declare New_Gamma = 2.25; // necessary for POV-Ray 3.6.2 only!
                          
#declare Image_Number_r = 2*frame_number-1; 
#declare Image_Number_l = 2*frame_number; 


#declare Im_Border = 0.005; // image border   
//----------------------------------------------------------------------
// box with layered textures
box { < -Im_Border, -0.5-Im_Border,0>,< 1+Im_Border, 0.5+Im_Border, 0.01>
      // 1st layer: White for border
      texture{
        pigment{ color rgb<1,1,1> }
        finish{ ambient 1 } 
      } // ------------------------------
      // 2nd layer: image_map
      texture{
     Correct_Pigment_Gamma( // gamma correction
        pigment{                              
          image_map{                            
          sys concat( "Stereo_Ani_00_",str(Image_Number_r,-2,0),".bmp")  
          map_type 0
          interpolate 2
          once
          } // end of image_map
        } //  end of pigment
    , New_Gamma) //, New_Gamma
        finish{ ambient 1 } 
        translate<0,-0.5,0>
      } // end of texture
               // 
     translate< -1-Im_Border,0,0>
     scale <1,image_height/(image_width/2),1> 
} // end of box //-----------------------

 // box with layered textures
box { < -Im_Border, -0.5-Im_Border,0>,< 1+Im_Border, 0.5+Im_Border, 0.01>
      // 1st layer: White for border
      texture{
        pigment{ color rgb<1,1,1> }
        finish{ ambient 1 } 
      } // ------------------------------
      // 2nd layer: image_map
      texture{
     Correct_Pigment_Gamma( // gamma correction
        pigment{
          image_map{                    
          sys concat( "Stereo_Ani_00_",str(Image_Number_l,-2,0),".bmp") 
          map_type 0
          interpolate 2
          once
          } // end of image_map
        } //  end of pigment
    , New_Gamma) //, New_Gamma
        finish{ ambient 1 }                                             
        translate<0,-0.5,0>
     } // end of texture
     translate< +Im_Border,0,0>
     scale <1,image_height/(image_width/2),1> 
} // end of box //-----------------------
