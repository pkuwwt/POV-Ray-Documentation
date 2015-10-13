// POV-Ray 3.6 / 3.7 Scene File "railing_1_1.pov"
// author: Friedrich A. Lohmueller, Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}
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
#switch ( Camera_Number )
#case (0)
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Orthographic_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 4.50, 1.20, -1.50> ;  // diagonal view
  #declare Camera_Look_At  = < 3.00, 0.40,  0.00> ;
  #declare Camera_Angle    =  60 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#case (1)
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Orthographic_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 5.00, 1.00, -0.80> ;  // diagonal view
  #declare Camera_Look_At  = < 3.00, 0.20,  0.50> ;
  #declare Camera_Angle    =  55 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#else
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Orthographic_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//---------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ #if (Ultra_Wide_Angle_On = 1) ultra_wide_angle #end  // don't use fish eye - for proper text
        #if (Orthographic_On = 1)     orthographic     #end // don't use fish eye - for proper text
        location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
        rotate   Camera_Rotate
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<-500,2900,-2500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

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
#declare Text_Rotate = <10,-45,0>;
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.5 translate <AxisLenX+0.15,0.3,-0.05> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate <Text_Rotate.x,0,0> scale 0.5 translate <-0.45,AxisLenY+0.20,-0.05> rotate <0,Text_Rotate.y,0> no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.65 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow }
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

object{ AxisXYZ( 15.0, 4.00, 10 Texture_A_Dark, Texture_A_Light) scale 0.25}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.01;
#declare RasterHalfLineZ = 0.01;
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




//-------------------------------------------------------------------- optional texture
/*
#declare Railing_Texture_1 =
         texture { Chrome_Metal
                   // pigment{ color rgb< 1, 1, 1>*0.7 }  
                   normal { bumps 0.25 scale 0.35 }
                   finish { phong 0.3 }
                 } // end of texture 
*/
//---------------------------------------------------------------------------------------
#include "Railing_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Railing_1( 4.00,  // railing length in x // i.e. 5.00, 
                   0.90,  // railing height in y // i.e. 1.00, 
                   0.80,  // railing vertical ~distance // i.e. 1.00,
                   0.025, // railing main radius   // i.e. 0.025, 
                   4, // vertical subdivision  // integer, i.e. 0, 1, 2, ...
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
