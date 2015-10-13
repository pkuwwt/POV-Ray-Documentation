// POV-Ray 3.6 / 3.7 Scene File "Seven_Segment_9.pov"
// author: Friedrich A. Lohmueller, Mai-2009/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} // for intel computers
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
//------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//---------------------------
//------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00, -3.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1) // 320x240
  #declare Camera_Position = < 1.50, 2.00,-2.50> ;  // side diagonal view
  #declare Camera_Look_At  = < 0.00, 0.00,  0.00> ;
  #declare Camera_Angle    =  35 ;
#break
#case (2) // 240x320
  #declare Camera_Position = < 0.90, 2.50,-2.20> ;  // top diagonal view
  #declare Camera_Look_At  = <-0.05, 0.00,  0.00> ;
  #declare Camera_Angle    =  28 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<
camera{ // ultra_wide_angle
        location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//-------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------------
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
          scale 0.5 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
           scale 0.5 translate <-0.75,AxisLenY-0.30,-0.10>}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.75,0.2,AxisLenZ+0.10>}
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

object{ AxisXYZ( 3.45, 3.5, 6, Texture_A_Dark, Texture_A_Light) scale 0.2}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.20;
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


#macro S7_Element( SS_Color__  ) //------------------------------
#local SS_Width = 1.2;
#local SS_Length = 6.0;
#local SS_Diag = sqrt(SS_Width*SS_Width)/2;

// polygon { number of points, list of <x,y> points -  closed series! }
polygon {  7,
  <-SS_Length/2, 0>,
  <-SS_Length/2+SS_Diag, -SS_Width/2>,
  < SS_Length/2-SS_Diag, -SS_Width/2>,
  < SS_Length/2, 0>,
  < SS_Length/2-SS_Diag,  SS_Width/2>,
  <-SS_Length/2+SS_Diag,  SS_Width/2>,
  <-SS_Length/2, 0>

  texture {SS_Color__}
  rotate<90,0,0>
} // end of polygon ----------------------------------------------------------
#end //--------------------------------------------------------- end of macro

//---------------------------------------------
#macro Seven_Segment( SS_Number,
                      SS_Angle,
                      SS_Background_Scale,
                      SS_Light_Color,
                      SS_Shade_Color,
                      SS_Background_Color,
                    ) //-----------------------
//---------------------------------------------
#local SS_Len = 6.2;
#local D = 0.0001;  // just a little bit !!
#local Shear_Factor =  tan(radians(SS_Angle));
//---------------------------------------------
// The sequence of the elements:
//      -       1
//    /  /   6    2
//     -        7
//  /  /     5    3
//   -          4
//
#switch (SS_Number)
#case(0)
 #local Lights_On = array [7] {1,1,1,1,1,1,0}
#break
#case(1)
 #local Lights_On = array [7] {0,1,1,0,0,0,0}
#break
#case(2)
 #local Lights_On = array [7] {1,1,0,1,1,0,1}
#break
#case(3)
 #local Lights_On = array [7] {1,1,1,1,0,0,1}
#break
#case(4)
 #local Lights_On = array [7] {0,1,1,0,0,1,1}
#break
#case(5)
 #local Lights_On = array [7] {1,0,1,1,0,1,1}
#break
#case(6)
 #local Lights_On = array [7] {1,0,1,1,1,1,1}
#break
#case(7)
 #local Lights_On = array [7] {1,1,1,0,0,0,0}
#break
#case(8)
 #local Lights_On = array [7] {1,1,1,1,1,1,1}
#break
#case(9)
 #local Lights_On = array [7] {1,1,1,1,0,1,1}
#break
#else // nothing - all off!!!
 #local Lights_On = array [7] {0,0,0,0,0,0,0}
#break
#end
  // end arrays
//---------------------------------------
#macro Light_Color(Num)
#if(Lights_On[Num] = 1)  SS_Light_Color
#else                    SS_Shade_Color
#end
#end //--------------------- end of macro
union{

 union{
 object{ S7_Element( Light_Color(1-1)) translate<0,0, SS_Len> }
 object{ S7_Element( Light_Color(7-1)) translate<0,0, 0> }
 object{ S7_Element( Light_Color(4-1)) translate<0,0,-SS_Len> }

 object{ S7_Element( Light_Color(2-1)) rotate<0,90,0> translate< SS_Len/2,0, SS_Len/2> }
 object{ S7_Element( Light_Color(3-1)) rotate<0,90,0> translate< SS_Len/2,0,-SS_Len/2> }
 object{ S7_Element( Light_Color(6-1)) rotate<0,90,0> translate<-SS_Len/2,0, SS_Len/2> }
 object{ S7_Element( Light_Color(5-1)) rotate<0,90,0> translate<-SS_Len/2,0,-SS_Len/2> }

 matrix< 1,  0,  0, // matrix-shear_z_to_x
         0,  1,  0,
         Shear_Factor, 0,  1,
         0,  0,  0 >

 } // end LEDs

box{ <-SS_Len/2,-0.01     ,-SS_Len>,
     < SS_Len/2,-0.0000001, SS_Len>
     scale SS_Background_Scale  texture {SS_Background_Color}}

translate<0,D,0>
} // end of union
#end //--------------------------------------------------------- end of macro
//----------------------------------------------------------------------------

#declare Active_Texture =
   texture { pigment{ color rgb< 1, 0.0, 0>*1.2 } //  color Red
//    texture { pigment{ color rgb< 0.25, 0.5, 0>*1.2  } //  color Green
//    texture { pigment{ color rgb< 1, 1, 1>*1.1  } //  color White
                   finish { ambient 0.9 diffuse 0.1 phong 1}
              } // end of texture
#declare Inactive_Texture =
    texture { pigment{ color rgb< 1, 1, 1>*0.3 } //  color gray
                   finish { phong 1 reflection 0.00}
              } // end of texture
#declare Background_Texture =
    texture { pigment{ color rgb< 1, 1, 1>*0.05 } //  color nearly black
                   finish { phong 1 reflection 0.1}
              } // end of texture

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
object{ Seven_Segment( 9, // 0~9, integer !!! SS_Number,
                       10, // 0~10, SS_Angle for shearing,
                       //< 1.5, 10, 1.40>, // SS_Background_Scale,
                       < 1.75, 10, 1.40>,// for SS_Angle=10
                       Active_Texture, // SS_Light_Color,
                       Inactive_Texture, //SS_Shade_Color,
                       Background_Texture, //SS_Background_Color,
                     ) //---------------------------------------
        scale 0.09
        rotate< 0,0,0>
        translate<0,0.05,0>
      } // end 7-segment-Display
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------