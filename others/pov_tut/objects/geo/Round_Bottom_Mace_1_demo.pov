// POV-Ray 3.7 Scene File "Round_Bottom_Mace_1demo.pov"
// author: Friedrich A. Lohmueller, May-2014
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7
global_settings{ assumed_gamma 1.0 }
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
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 0.20,-2.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.20,  0.00> ;
  #declare Camera_Angle    =  35 ;
#break
#case (1)
  #declare Camera_Position = < 0.50, 0.30, -0.30>  ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 0.18,  0.00>  ;
  #declare Camera_Angle    =  55 ;
#break
#case (2)
  #declare Camera_Position = < 2.00, 0.20, -0.001> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 0.20,  0.00> ;
  #declare Camera_Angle    =  25 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 3.00,-0.001> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  15 ;
#break
#else
  #declare Camera_Position = < 0.00, 0.20,-2.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.20,  0.00> ;
  #declare Camera_Angle    =  35 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{< 500,3500,-2500> color White*0.9}
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1} 
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>*0.6         ]//White
                                [0.1 color rgb<0.24,0.34,0.56>*0.8]//~Navy
                                [0.9 color rgb<0.24,0.34,0.56>*0.8]//~Navy
                                [1.0 color rgb<1,1,1>*0.6         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//------------------------------------------------------------------------
 
fog { fog_type   2
      distance   2
      color     White*0.6 // rgb<1,0.89,0.7>*0.9  
      fog_offset 0.0
      fog_alt    0.1
      turbulence 1.8
    }
 
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
          rotate Text_Rotate scale 0.5 translate <AxisLenX+0.25,0.3,-0.05> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.5 translate <-0.85,AxisLenY+0.20,-0.05> no_shadow }
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

object{ AxisXYZ( 2.5, 13.8 , 8.5 , Texture_A_Dark, Texture_A_Light) scale 0.025}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.05;
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
                  finish {ambient 0.25 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate< 0,0,0>
      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//----------------------------------------------------------------------- textures
#declare Round_Bottom_Mace_Texture = 
        texture { pigment{ color rgb< 1, 1, 1.00> }  
               // normal { bumps 0.5 scale 0.05 }
                  finish { diffuse 0.9 phong 1 reflection 0.00}
                } // end of texture 
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
#declare D = 0.000001;
#declare Glass_D = 0.004*1;
#declare Neck_Fillet =  0.050*1; // > 0 !!!
#declare Bowl_Radius = 0.100*1;
#declare Neck_Radius = 0.030*1;  
#declare Neck_Length = 0.100*1; 
//---------------------------------
#include "Round_Bottom_Mace_1.inc" 
//---------------------------------
object{ Round_Bottom_Mace_1 (     //  A round-bottom flask shape 
                // declares: Total_Height_of_Mace
                Neck_Fillet, // > 0 // neck base fillet // Hohlkehle 
                Bowl_Radius, // base bowl radius
                Neck_Radius, // neck radius
                Neck_Length, // 0=non; neck linear length 
                1, //   1 for transparent materials, else: 0 
              ) //-----------------------------------------------------------------
        texture{ Round_Bottom_Mace_Texture }  
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>
} // end of object
//----------------------------------------------------------------------------------
//----------------------------------------------------------------------------------
