// POV-Ray 3.7 Scene File "Stereo_Ani_00_Combi_.pov"
// Sample file to combine stereo images together.
// author: Friedrich A. Lohmueller, Jan-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
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
        pigment{                              
          image_map{                            
          jpeg concat( "Stereo_Ani_00_",str(Image_Number_r,-2,0),".jpg")  
          map_type 0
          interpolate 2
          once
          } // end of image_map
        } //  end of pigment
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
        pigment{
          image_map{                    
          jpeg concat( "Stereo_Ani_00_",str(Image_Number_l,-2,0),".jpg") 
          map_type 0
          interpolate 2
          once
          } // end of image_map
        } //  end of pigment
        finish{ ambient 1 }                                             
        translate<0,-0.5,0>
     } // end of texture
     translate< +Im_Border,0,0>
     scale <1,image_height/(image_width/2),1> 
} // end of box //-----------------------
