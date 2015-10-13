// PoVRay 3.7 Scene File "Tower_Sqared_000.pov"
// author: Friedrich A. Lohmueller, Jan-2006/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//------------------------------------------------------------------------
// command line options: 
// +h600 +w450
// 
#version 3.6; // 3.7;
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 15      // front view
                            location  <0.0 , 1.0 ,-40.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 26  // diagonal view
                            location  <10.0, 15.0,-10.0> 
                            right     x*image_width/image_height
                            look_at   < 0.00, 4.50, 0.00>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90  //right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1200,1700,-2500> color White}
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
         rotate<30,-40,0> scale 0.75 translate <AxisLenX+0.05,0.4, 0.00> no_shadow}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
           scale 0.5 translate <-0.75,AxisLenY+0.10,-0.10>  no_shadow}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<30,-40,0> scale 0.75 translate <-0.45,0.1,AxisLenZ+0.00>  no_shadow}
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

object{ AxisXYZ( 3.5, 9.25, 7, Texture_A_Dark, Texture_A_Light)}
//-------------------------------------------------- end of coordinate axes


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



//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Brick_Scale     = 0.075; 
#declare Brick_Translate = <0.0,-0.06,-0.0>;
#declare Brick_Intensity = 0.35; 
//------------------------------------------------------------- textures
#declare Tower_Texture_1 = // sandstone
         texture { pigment{ color rgb< 0.90, 0.78, 0.60>}
                   normal { pigment_pattern{ brick 
                                             color rgb 0.2, 
                                             color rgb 0.8 
                                             scale Brick_Scale 
                                             translate Brick_Translate
                                             rotate<0,0,0>} Brick_Intensity}
                   finish { phong 0.1}
                 } // end of texture 
#declare Tower_Texture_2 = // sandstone
         texture { pigment{ color rgb< 0.90, 0.78, 0.60>*0.95}
                            // color rgb< 0.4,1,0.0>} // test_color
                   normal { pigment_pattern{ brick 
                                             color rgb 0.2, 
                                             color rgb 0.8 
                                             scale Brick_Scale
                                             translate Brick_Translate
                                             rotate<0,0,0>} Brick_Intensity}
                   finish { phong 0.1}
                 } // end of texture 
//---------------------------------------------------------------------------------------
#include "Tower_Squared_0.inc" 
//-------------------------------------------------------------------------------------// 


object{ Tower_Squared_0( 2.00, // Tower_R, // half tower width in x and z                                
                         8.00, // Tower_H, // tower heigth in y 
                         1.50, // Tower_Balustrade_H, // tower balustrade high
                         0.25, // Tower_Wall_D,       // tower wall deepth 
                         0.66, // Merlon_H,       // battlements height in y
                         0.22, // Merlon_R,   // half battlements width in x or z 
                         Tower_Texture_1, // outside texture
                         Tower_Texture_2  // battlements tween texture
                       ) //------------------------------------------------------------// 
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
