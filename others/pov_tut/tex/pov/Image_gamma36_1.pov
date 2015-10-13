// POV-Ray 3.6 Scene File "Image_gamma36_1.pov"
// author: Friedrich A. Lohmueller, Dec-2012
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6;
global_settings{ assumed_gamma 1.0 } 
#default{ finish{ ambient 0.1 diffuse 0.9  }}
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
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 0 ;
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 0.90,-5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  64 ;
#break
#case (1)
  #declare Camera_Position = < 5.00, 5.00,-5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (2)
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<
// sun ----------------------------------------------------------------------
light_source{<1500,1500,-1500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky ---------------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.25,0.30,1.0>*0.65]
                                     [0.50 rgb <0.25,0.30,1.0>*0.65]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground --------------------------------------------------------
fog { fog_type   2
      distance  50
      color      White *0.7 
      fog_offset 0.1
      fog_alt     1
      turbulence 1.8
    }
// ground -------------------------------------------------------------------
plane{ <0,1,0>, 0
       texture{ pigment{ checker color rgb<1,1,1>*1.2 color rgb<0.25,0.15,0.1>*0}
              //normal { bumps 0.75 scale 0.025}
                finish { phong 0.1}
              } // end of texture
     } // end of plane
//---------------------------------------------------------------------------
//---------------------------- objects in scene -----------------------------
//---------------------------------------------------------------------------
sphere { <0,0,0>, 1.1
         texture{ Polished_Chrome }
         scale<1,1,1>  rotate<0,0,0>  translate<1.35,1.5,-0.75>  
       }  // end of sphere ----------------------------------- 
//---------------------------------------------------------------------------
//
// box with layered textures
box { <-0.04,-0.04,0>,< 1.03, 1.04, 0.01>   
      // 1st layer: White
      texture{ 
        pigment{ color rgb<1,1,1>*1.1 } 
        finish{ phong 1}
      } // ------------------------------ 
      // 2nd layer: image_map
      texture{
        pigment{
          image_map{ jpeg "Image_gamma_0.jpg"  
          // maps an image on the xy plane from <0,0,0> to <1,1,0> (aspect ratio 1:1)
          // accepted types: gif, tga, iff, ppm, pgm, png, jpeg, tiff, sys
          map_type 0 // 0=planar, 1=spherical, 2=cylindrical, 5=torus
          interpolate 2 // 0=none, 1=linear, 2=bilinear, 4=normalized distance
          once //
         } // end of image_map
       } //  end of pigment
     } // end of texture
    
     scale <4/3,1,1>*1.75
     rotate<  0, 0,0>
     translate<-1.5,0.1,-2>
} // end of box //-----------------------------------------------------------
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
