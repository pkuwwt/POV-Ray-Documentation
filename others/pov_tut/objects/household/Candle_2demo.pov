// POV-Ray 3.6 / 3.7 Scene File "Candle_2_demo.pov"
// author: Friedrich A. Lohmueller, Aug-2009/Jan-2011
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
#declare Camera_Number = 1 ;
//-------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 5.00, 5.00,-5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;// front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//---------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.05}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.05}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//------------------------------------------------------------------------



// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.025;
#declare RasterHalfLineZ = 0.025;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.3]
                          [0+HLine color rgbt<1,1,1,0>*0.3]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.3]
                          [1.000   color rgbt<1,1,1,0>*0.3]} }
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------


plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.2}
                  finish { phong 1 }}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//------------------------------------------------------------------ optional textures
#declare Candle_Texture = 
  texture{ pigment{ rgb<1,1,0.95>*1.3}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.02}}
         } // end texture
#declare Candle_Wax_Liquid_Texture = 
  texture{ pigment{ rgbf<1,0.9,0.6,0.05>*1.3}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.30}}
         } // end texture
// -------------------------------------------------------------------------------------
#include "Candle_2.inc"
// -------------------------------------------------------------------------------------
object{ Candle_2( 0.3,  // Shining_On, 0= off, >0 = intensity of candle light 
                  0, // Flame_Shadow, // >0 = intensity ; 0 = off
                  1.0,  // Candle_Height, relative to diameter (d=1) 
                  1.2,  // Candle_Intensity,  
                  0.7   // Candle_Flame_Scale
                  4, // Fade_Distance, //  3 ~ 5    
                  3 // Fade_Power //   2,3,4
                 ) // -------------------------
        scale 1
        rotate<0,0,0>
        translate<0.50,0,0.50> 
      } // ------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
object{ Candle_2( 0.3,  // Shining_On, 0= off, >0 = intensity of candle light 
                  0, // Flame_Shadow, // >0 = intensity ; 0 = off
                  1.5,  // Candle_Height, relative to diameter (d=1) 
                  1.2,  // Candle_Intensity,  
                  0.7   // Candle_Flame_Scale
                  4, // Fade_Distance, //  3 ~ 5    
                  3 // Fade_Power //   2,3,4
                 ) // -------------------------
        scale 1
        rotate<0,0,0>
        translate<-0.70,0,0> 
      } // ------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
