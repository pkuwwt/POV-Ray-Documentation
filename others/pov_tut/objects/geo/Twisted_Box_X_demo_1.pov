// PoVRay 3.6 / 3.7 Scene File "Twisted_Box_X_demo_1.pov"
// author:  Friedrich A. Lohmueller, Sept-2012
//--------------------------------------------------------------------------
#version 3.6;
global_settings{ assumed_gamma 1.1 }
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 35  // diagonal view
                            location < 6.00, 4.00, -4.00>
                            right     x*image_width/image_height
                            look_at   < 2.30,0.00,  0.00> }
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}

// sky ---------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<0.24,0.34,0.56>*0.7]        
                                [0.5 color rgb<0.24,0.34,0.56>*0.7] 
                                [0.5 color rgb<0.24,0.34,0.56>*0.7] 
                                [1.0 color rgb<0.24,0.34,0.56>*0.7]          
                              }
                     
                      rotate< 0,0, 0>  
                   
                     scale 2 }
           } // end of sky_sphere
 
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
          rotate<0,-35,0> scale 0.65 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
                          scale 0.75 translate <-0.50,AxisLenY+0.50,-0.10> rotate<0,-45,0>}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<0,-45,0> scale 0.95 translate <-0.75,0.2,AxisLenZ+0.20>}
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

object{ AxisXYZ( 17.5, 3.0, 9, Texture_A_Dark, Texture_A_Light) scale 0.25}
//-------------------------------------------------- end of coordinate axes
// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.025;
#declare RasterHalfLineZ = 0.025;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x  scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------


plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1 transmit 1 }
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ


//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//
#include "shapes_lo2/Twisted_Box_X.inc"
//--------------------------------------------------------------------------------//
object{ Twisted_Box_X(  1.00, // start height in y, // ~ 1.0,  
                        0.30, // start width in z, // ~ 0.1;
                      90/360, // number of turns: Angel/360, or i.e. 0.25 = 45� 
                        3.00, // Twist_Length, // ~ 3, // ca. >2*min( start height in y, start width in z )
                        0.50, // Start_Length, // ~  0.5, // linear start; 0 =non
                        0.50, // End_Length  , // ~  0.5, // linear end;   0 =non
                        1.5, // Max_Gradient, // ~ 2 or higher(=slower!), increase it, to avoid holes!  
                     ) //------------------------------------------------------------
        texture{ pigment{ color rgb< 1, 1, 1>*1 }  
                 // normal { bumps 0.5 scale 0.05 }
                 finish { phong 1 reflection 0.00}
               } // end of texture 
        scale<1,1,1>
        rotate<0, 0,0>
        translate<0,0,0>
      } //------------------------------------------------------------------------// 
//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//































