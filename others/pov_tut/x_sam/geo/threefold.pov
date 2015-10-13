// POV-Ray 3.6 / 3.7 Scene File "threefold.pov"
// author: Friedrich A. Lohmueller, Aug-2005/Jan-2011/April-2013
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//------------------------------------------------------------------------
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
//------------------------------------------------------------------------
#declare Camera_0 = camera { perspective
                             angle 11
                             right     x*image_width/image_height
                             location  < 0.00, 0.00,-40.0>
                             look_at   < 0.00, 0.00, 0.00>
                           }
camera{Camera_0}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500, 500,-2500> color White}
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
    cylinder { <0,-AxisLen-0.35,0>,<0,AxisLen,0>,0.05
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
          scale 0.5 translate <AxisLenX+0.05,0.2,-0.05>}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
           scale 0.5 translate <-0.40,AxisLenY+0.05,-0.05>}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.75,0.2,AxisLenZ+0.10>}
#end // of #if
} // end of union
#end// of macro "AxisXYZ( ... )"
//-------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,0.55,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture {
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ( 3.15, 3.15, 0, Texture_A_Dark, Texture_A_Light)}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 0.5;
#declare RasterHalfLine  = 0.04;
#declare RasterHalfLineZ = 0.04;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
       finish { phong 0.1}
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------


plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{ color White*1.1}
                  finish { phong 0.1}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<-90,0,0>
      }
//------------------------------------------------ end of squered plane XY

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
#declare R0 = 0.07;   // minor radius of all tori

#declare M  = <0,0,0>; // center of the outer circle

// Threefold Fish
#declare Ra  = 3.00-R0;    // radius of the outer circle
#declare Ri  = Ra /(1+2/3*sqrt(3)); // radius of inner circles

#declare Mi = <0,-Ra+Ri,0>; // center of the inner circle below
#declare S_3_Angle =  210 ; // segment angle  torus


torus { Ra,  R0
        texture { pigment{ color rgb<0.4,1,0>}
                  finish { phong 1}
                } // end of texture
        scale <1,1,1> rotate<90,0,0> translate M
      } // end of torus  -------------------------------


// 3 torus segments
#include "shapes3.inc"

//#macro Segment_of_Torus( R_major, R_minor, Segment_Angle)
#declare Segment =
object{ Segment_of_Torus( Ri,  R0, -S_3_Angle)
        texture { pigment{ color rgb<0.4,1,0>}
                  finish { phong 1}
                } // end of texture
        rotate<-90,0, 60>
      } // end of Torus_Segment(...) -------------------------------------

object{ Segment translate Mi rotate<0,0,0*120>}
object{ Segment translate Mi rotate<0,0,1*120>}
object{ Segment translate Mi rotate<0,0,2*120>}


//------------------------------------------------------------------ end