// PoVRay 3.7 Scene File "Candle_1demo.pov"
// author: Friedrich A. Lohmueller, Oct-2008/Aug-2009
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#if (version < 3.7) global_settings{ assumed_gamma 1.0 } #end
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
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle 
#declare Camera_Position = <8.0, 6.0,-14.0> ;   
#declare Camera_look_at = <-0.80, 1.80,-0.70>; 
#declare Camera_Angle = 22; // in degrees
//-------------------------------------------  
camera{ /*ultra_wide_angle*/    
        location  Camera_Position
        right     x*image_width/image_height
        angle Camera_Angle   
        look_at   Camera_look_at
      } //-----------------------------------
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<000,1500,-1500> color White*0.5 media_interaction off}// sun 
light_source{ Camera_Position color rgb<0.9,0.9,1>*0.1}     // flash light
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         *0.2]//White
                                [0.4 color rgb<0.14,0.14,0.56>*0.2]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>*0.2]//~Navy
                                [1.0 color rgb<1,1,1>         *0.2]//White
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
                color_map{[0.000   color rgbt<1,1,1,0>*0.5]
                          [0+HLine color rgbt<1,1,1,0>*0.5]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.5]
                          [1.000   color rgbt<1,1,1,0>*0.5]
                         } }
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*0.25}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ

//----------------------------------------------------------------------------
//---------------------------- objects in scene ------------------------------

          


// ---------------------------------------------------------------------------
// optional texture declarations before including "Candle_1.inc" //-----------
#declare Candle_Texture = 
  texture{ pigment{ rgb<1,1,0.95>*1.3}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.02}}
         } // end texture
#declare Candle_Wax_Liquid_Texture = 
  texture{ pigment{ rgbf<1,0.9,0.6,0.05>*1.3}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.15}}
         } // end texture
// ---------------------------------------------------------------------------
#include "Candle_1.inc"
// ---------------------------------------------------------------------------
object{ Candle_1( 0.5,  // Shining_On, 0= off, >0 = intensity of candle light 
                  1.0,  // Candle_Height, relative to diameter (d=1) 
                  1.2,  // Candle_Intensity,  
                  0.7   // Candle_Flame_Scale
                ) // -------------------------
        scale 1
        rotate<0,0,0>
        translate<0.55,0,0> 
      } // -------------------------------------------------------------------
// ---------------------------------------------------------------------------
object{ Candle_1( 0.5,  // Shining_On, 0= off, >0 = intensity of candle light 
                  2.0,  // Candle_Height, relative to diameter (d=1) 
                  1.2,  // Candle_Intensity,  
                  0.8   // Candle_Flame_Scale
                ) // -------------------------
        scale 1
        rotate<0,-100,0>
        translate<-0.50,0,0> 
      } // -------------------------------------------------------------------
// ---------------------------------------------------------------------------
object{ Candle_1( 0.5,  // Shining_On, 0= off, >0 = intensity of candle light 
                  0.70, // Candle_Height, relative to diameter (d=1) 
                  1.5,  // Candle_Intensity,  
                  0.55  // Candle_Flame_Scale
                ) // -------------------------
        scale 1.5
        rotate<0,40,0>
        translate<-1.7,0,-1.00> 
      } // -------------------------------------------------------------------
// ---------------------------------------------------------------------------
object{ Candle_1( 0.5,  // Shining_On, 0= off, >0 = intensity of candle light 
                  4.70, // Candle_Height, relative to diameter (d=1) 
                  1.5,  // Candle_Intensity,  
                  1.20  // Candle_Flame_Scale
                ) // -------------------------
        scale 0.5
        rotate<0,40,0>
        translate<0.6,0, 1.00> 
      } // -------------------------------------------------------------------
// ---------------------------------------------------------------------------
// ---------------------------------------------------------------------------
