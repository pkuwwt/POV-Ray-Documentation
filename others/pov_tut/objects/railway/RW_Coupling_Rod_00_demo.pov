// PoVRay 3.6 / 3.7 Scene File "RW_Coupling_Rod_Single_00_demo.pov"
// author:  Friedrich A. Lohmueller, Aug-2012
// Homepage: http://www.f-lohmueller.de
//------------------------------------------------------------------------
#version 3.6;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//------------------------------------------------------------------------
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
//------------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 45      // front view
                            location  <0.0 , 1.0 ,-5.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 9   // diagonal view
                            location  <8.0 , 2.0 ,-6.0>
                            right     x*image_width/image_height
                            look_at   <0.85 , 0.70 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 60  //right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 30        // top view
                            location  <0.0 , 6.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
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

//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
#macro Axis_( AxisLen, Dark_Texture,Light_Texture) 
 union{
    cylinder { <0,-AxisLen,0>,<0,AxisLen,0>,0.05
               texture{checker texture{Dark_Texture } 
                               texture{Light_Texture}
                       translate<0.1,0,0.1>}
             }
    cone{<0,AxisLen,0>,0.2,<0,AxisLen+0.7,0>,0
          texture{Dark_Texture}
         }
     } // end of union                   
#end // of macro "Axis()"
//------------------------------------------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, Tex_Dark, Tex_Light)
//--------------------- drawing of 3 Axes --------------------------------
union{
#if (AxisLenX != 0)                                                                   
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark} 
          rotate<10,-25,0> scale 0.55 translate <AxisLenX+0.05,0.4,-0.10> no_shadow}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
          rotate<10,0,0> scale 0.55 translate <-0.65,AxisLenY+0.50,-0.10>  rotate<0,-25,0> no_shadow}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<10,-25,0> scale 0.55 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow}
#end // of #if 
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,0.45,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ( 6.80 , 1.50 , 3.50 , Texture_A_Dark, Texture_A_Light) scale 0.25 translate<0,0.5,0> no_shadow}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.5;
#declare RasterHalfLine  = 0.02;  
#declare RasterHalfLineZ = 0.02; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.8]
                          [0+HLine color rgbt<1,1,1,0>*0.8]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.8]
                          [1.000   color rgbt<1,1,1,0>*0.8]} }
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

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//------------------------------------------------------------------- optional textures//
#declare Rod_Metal_1 = texture{ pigment{ color rgb<1,0.95,0.90>*0.010} normal{ bumps 0.125 scale 0.085} finish{ phong 0.2 reflection{ 0.2 metallic} }}  
#declare Rod_Metal_2 =   texture{pigment{ rgb<1,1,1>*0.85}  finish {phong 1 reflection{ 0.2 metallic}}} 
#declare Rod_Texture_1 = texture{  pigment{ color rgb<1,1,1>*0.75} finish {phong 1 reflection{ 0.1 metallic}} }  
//-------------------------------------------------------------------------------------//
#include "RW_System/RW_Coupling_Rod_00.inc" 
//-------------------------------------------------------------------------------------// 
object{ RW_Coupling_Rod_00( 1.50, // Rod_Len,  // coupling rod length in x+ from link to link                               
                            0.17, // Rod_H,  // height in y+/- of rod
                            0.09, // Rod_D,  // depth in -z // 
                            0.15, // Rod_End_R // radius of the end links, >Rod_H/2 !!! 
                            1,    // Oil_Fillers_On // 0 = non, 1= On 
                          ) //--------------------------------------------------//
        scale <1,1,1>*1
        rotate< 0, 0,0> 
        translate< 0.00,0.50, 0.00>}
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
object{ RW_Coupling_Rod_00( 1.20, // Rod_Len,  // coupling rod length in x+ from link to link                               
                            0.12, // Rod_H,  // height in y+/- of rod
                            0.04, // Rod_D,  // depth in -z // 
                            0.10, // Rod_End_R // radius of the end links, >Rod_H/2 !!! 
                            0,    // Oil_Fillers_On // 0 = non, 1= On 
                           ) //--------------------------------------------------//
        scale <1,1,1>*1
        rotate< 0, 0,0> 
        translate<-0.20,0.90, 0.40>}
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//




