// PoVRay 3.7 Scene File "Waterglass_01c.pov"
// author:  Friedrich A. Lohmueller, March-2011
// Homepage: http://www.f-lohmueller.de
//------------------------------------------------------------------------
#version 3.7;
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
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 53 // diagonal view
                            location  <0.7 , 0.6 ,-0.7>
                            right     x*image_width/image_height
                            look_at   < 0.15 , 0.0 , -0.135>}
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
light_source{<-1500,2500,-2500> color White*0.9 }
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.24,0.34,0.56>*0.8]//~Navy
                                [0.6 color rgb<0.24,0.34,0.56>*0.8]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere 
//------------------------------------------------------------------------
/*
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
          rotate<20,-40,0> scale 0.55 translate <AxisLenX+0.25,0.3,-0.10> no_shadow}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
          rotate<10,0,0> scale 0.55 translate <-0.65,AxisLenY+0.50,-0.10>  rotate<0,-45,0> no_shadow}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<20,-40,0> scale 0.75 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow}
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

object{ AxisXYZ( 4.50, 2.80, 5.00, Texture_A_Dark, Texture_A_Light) scale 0.1}
//-------------------------------------------------- end of coordinate axes
*/

// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.10;
#declare RasterHalfLine  = 0.0125;  
#declare RasterHalfLineZ = 0.0125; 
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
    
// squared plane XZ
plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.2}
                }
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//-----------------------------------------
#macro Glass_01( G_R, // radius of glass
                 G_H, // height of glass
               ) //------------------------

difference{
 cylinder{<0,      0,0>,<0,G_H   ,0>,G_R }
 cylinder{<0,G_R*.05,0>,<0,G_H+.1,0>,G_R*.9}
} // end of difference


#end // end of macro
//-----------------------------------------
//-----------------------------------------


global_settings{max_trace_level 10}
//-----------------------------------------
union{ 
  
 object{ Glass_01( 0.14, // radius of glass
                   0.30, // height of glass
                ) //-----------------------
        material{
         texture{
          pigment{ rgbf<.98,.98,.98,0.85>*1}
          finish { ambient 0.0
                   diffuse 0.15
                   reflection 0.2
                   specular 0.6
                   roughness 0.005
                  // phong 1 
                  // phong_size 400
                   reflection { 0.03, 1.0 fresnel on }
                //   conserve_energy
                 }
          } // end of texture

          interior{ ior 1.5
                    fade_power 1001
                    fade_distance 0.5
                    fade_color <0.8,0.8,0.8>
                  } // end of interior

 
        } // end of material
  } // end glass
 
// water
intersection{ 
 cylinder{<0,0,0>,<0,0.30*0.75,0>,0.14  
        material{
         texture{
          pigment{ rgbf<.93,.95,.98,0.9>*0.95}
          normal { ripples 1.35 scale 0.0125 turbulence 0.3 translate<-0.05,0,0> rotate<0,-20,0>} 
          finish { ambient 0.0
                   diffuse 0.15
                   reflection 0.2
                   specular 0.6
                   roughness 0.005
                  // phong 1 
                  // phong_size 400
                   reflection { 0.2, 1.0 fresnel on }
                   conserve_energy
                 }
           } // end of texture
         
          interior{ ior 1.33 
                    fade_power 1001
                    fade_distance 0.5
                    fade_color <0.8,0.8,0.8> 
                } // end of interior
        } // end of material
   } //

 cylinder{<0,0.14*0.051,0>,<0,1,0>,0.14*0.90 *0.999 
        material{
         texture{
          pigment{ rgbf<.93,.95,.98,0.825>*0.99}
         //  normal { ripples 0.5 scale 0.025 turbulence 0.1 translate<-0.05,0,0> rotate<0,-20,0>} 
          finish { ambient 0.0
                   diffuse 0.15
                   reflection 0.2
                   specular 0.6
                   roughness 0.005
                  // phong 1 
                  // phong_size 400
                   reflection { 0.17, 1.0 fresnel on }
                   conserve_energy
                 }
           } // end of texture
         
          interior{ ior 1.33 
                    fade_power 1001
                    fade_distance 0.5
                    fade_color <0.8,0.8,0.8> 
                } // end of interior
        } // end of material
         } //           
 }// end water


// drinking straw 
cylinder{<0,0,0>,<0,0.40,0>,0.01 
          texture{ pigment{ color rgb< 1, 1, 1>*1.5 } //  color White
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
   rotate<0,0,35> rotate<0,-20,0>
   translate<0.11,0.05,0>
 } // end straw
         
  translate< 0.25,0,-0.35 >
} //------------------------------------------------------

