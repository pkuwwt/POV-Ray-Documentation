// POV-Ray 3.7 Scene File "Stereo_Image_Combine_.pov"
// Sample file to combine stereo images together.
// author: Friedrich A. Lohmueller, Jan-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0} 
#default{ finish{ ambient 0.1 diffuse 0.9}} 
//------------------------------------------- 
#include "colors.inc"
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
  // combine stereo images of right/left eye's view to one image
  //..................................................................... 
  #declare Camera_Position = < 0.00, 0.50,-8.18> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.50,  0.00> ;
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

#declare IBorder = 0.005; // image border   


// left box with layered textures
box { < -IBorder, -IBorder,0>,< 1+IBorder, 1+IBorder, 0.01>
      // 1st layer: White for border
      texture{
        pigment{ color rgb<1,1,1> }
        finish{ ambient 1 } 
      } // ------------------------------
      // 2nd layer: image_map
      texture{
        pigment{                             
          image_map{   
          jpeg concat( "Stereo_Image_1",".jpg") // gamma 2.3
          map_type 0
          interpolate 2
          once
          } // end of image_map
        } //  end of pigment
        finish{ ambient 1 } 
     } // end of texture

     scale <1,1,1>*1
     translate< -1-IBorder,0,0>
} // end of box //-----------------------

// right box with layered textures
box { < -IBorder, -IBorder,0>,< 1+IBorder, 1+IBorder, 0.01>
      // 1st layer: White for border
      texture{
        pigment{ color rgb<1,1,1> }
        finish{ ambient 1 } 
      } // ------------------------------
      // 2nd layer: image_map
      texture{
        pigment{
          image_map{    
          jpeg  concat( "Stereo_Image_2",".jpg") // gamma 2.3
          map_type 0
          interpolate 2
          once
          } // end of image_map
        } //  end of pigment
        finish{ ambient 1 }                                             
     } // end of texture

     scale <1,1,1>*1
     translate< +IBorder,0,0>
} // end of box //-----------------------
