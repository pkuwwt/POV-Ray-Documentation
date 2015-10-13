// PoVRay 3.7 Scene File "Newtons_Cradle_5demo.pov"
// author: Friedrich A. Lohmueller, March-2008/Aug-2009/Jan-2011
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
//-------------------------------------------------------------  
#declare Camera_Position =  <2.2 , 1.8 ,-3.0 >;  // diagonal view
#declare Look_At = <-0.10, 0.47, 0.00>; 
#declare Camera_Angle = 40; // in degrees
//---------------------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ /*ultra_wide_angle*/   // don't use fish eye - for proper text 
        location  Camera_Position
        right     x*image_width/image_height
        angle Camera_Angle  
        look_at  Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
// soft light (areal_light) ---------  An area light (creates soft shadows)
// WARNING: This special light can significantly slow down rendering times!
light_source { <0,0,0>          
               color rgb <1,1,1>*0.7     // light's color 
               area_light            // kind of light source (Art der Lichtquelle)
               <1, 0, -1>*5
               <1, 0, 1>*5 // lights spread out across this distance (x * z)
               12, 12                // total number of lights in grid (4x*4z = 16 lights)
               adaptive 3          // 0,1,2,3...
               jitter              // adds random softening of light
               translate < -6, 40, -20>   // <x,y,z> position of light
             } //---------------- end of area_light 
//------------------------------------------------------------------------
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light
//------------------------------------------------------------------------
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
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color rgb<1,1,1>*1.3} }
                  
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        scale 0.2 rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//------------------------------------------------------------------optional textures -//
#declare Ball_Texture = texture{ Polished_Chrome } ; 
#declare Cradle_Texture = texture{ Polished_Chrome } ; 
//-------------------------------------------------------------------------------------//
#include "Newtons_Cradle_5.inc" 
//-------------------------------------------------------------------------------------// 
object{Newtons_Cradle_5 ( 0.15, //  Time, // time for clock from 0 to 1 
                          30,  // Amplitude, // degrees from vertical 

                          0.025, // Frame_R_min, // R_minor, 
                          0.15,  // Frame_R_maj, // R_major, 
                          1.40,  // Frame_Height, //  height in y
                          1.20,  // Frame_Width, //   width in x
                          1.90,  // Frame_Length, //  length in z 

                          0.15,  // Ball_Radius, //Ball_R ,  
                          0.005, // Wire_R , // Filament_R , 
                          1.00,  // Ball_H , // Ball_H , 
                        ) // -------------------------------------------
        //no_shadow 
        // scale it down to real size !!!!
        scale<1,1,1>*1 rotate<0,0,0>  translate<0,0,0>  
     } // ------------------------------------------------------------- 

//---------------------------------------------------------------------------------------
