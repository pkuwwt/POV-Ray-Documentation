// POV-Ray 3.6/3.7 Scene File "pigment_pattern_1.pov"
// author: Friedrich A. Lohmueller, Dec-2012
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6;
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
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 5.00, 5.00, -4.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.70, 1,  0.00> ;
  #declare Camera_Angle    =  42 ;
#break
#case (2)
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 8.00,  0+0.000> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0+0.001> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<

//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
// sun --------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky --------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//-------------------------------------------------------------------------

// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.015;
#declare RasterHalfLineZ = 0.015;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.9]
                          [0+HLine color rgbt<1,1,1,0>*0.9]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.9]
                          [1.000   color rgbt<1,1,1,0>*0.9]} }
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------


plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ

//-------------------------------------------------------------------------
//---------------------------- objects in scene ---------------------------
//-------------------------------------------------------------------------

// ----------------------------------
#declare Pigment_1 = 
pigment{ crackle turbulence 0.35 scale 0.45 
         color_map{
          [0.00 color rgb<1,1,1>*0]
          [0.08 color rgb<1,1,1>*0]
          [0.40 color rgb<1,0.55,0>]
          [1.00 color rgb<1,1,0.8>]
         } // end of color_map
} // end of pigment -----------------


object{ //---------------------------
  Round_Box(<-1,0,-1.25>,<2,2,2>,0.15,0)  
  texture{ pigment{ Pigment_1  }
           finish { phong 1 }
         } // end texture
} // --------------------------------
