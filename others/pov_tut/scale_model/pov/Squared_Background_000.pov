// POV-Ray 3.6 / 3.7 Scene File "Squared Background_000.pov"
// author: Friedrich A. Lohmueller, Feb-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7 
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
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Ultra_Wide_Angle_On = 0; 
  #declare Orthographic_On = 1; 
  #declare Camera_Position = < 1.55, 1.60, -10.00> ;  // front view                                                                 
  #declare Camera_Look_At  = < 1.55, 1.60,  0.00> ;
  #declare Camera_Angle    =  20;
#break
#case (1)
  #declare Ultra_Wide_Angle_On = 0; 
  #declare Orthographic_On = 0; 
  #declare Camera_Position = < 15.00, 10.00, -15.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.50, 1.50, -0.50> ;
  #declare Camera_Angle    =  22;
#break
#else
  #declare Ultra_Wide_Angle_On = 0; 
  #declare Orthographic_On = 0; 
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<

camera{ #if (Ultra_Wide_Angle_On = 1) ultra_wide_angle #end  
        #if (Orthographic_On = 1)     orthographic     #end  
        location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//-------------------------------------------------------------------------------------------------------<<<<

//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1000,1500,-2500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.24,0.34,0.56>]//~Navy
                                [0.6 color rgb<0.24,0.34,0.56>]//~Navy
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
#declare Text_Rotate = <10,-35,0>;
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.5 translate <AxisLenX+0.15,0.3,-0.05> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate <Text_Rotate.x,0,0> scale 0.5 translate <-0.35,AxisLenY+0.20,-0.05> rotate <0,Text_Rotate.y,0> no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.65 translate <-0.55,0.1,AxisLenZ+0.10> no_shadow }
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

object{ AxisXYZ( 6.0/2, 6.0/2, 10.5/2, Texture_A_Dark, Texture_A_Light) scale 1}
//-------------------------------------------------- end of coordinate axes




//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


//--------------------------------------------------------------- ////////////
//--------------------------------------------------------------- ////////////
#macro Raster_Lines (RScale, HLine, Intensity_)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*Intensity_]
                          [0+HLine color rgbt<1,1,1,0>*Intensity_]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*Intensity_]
                          [1.000   color rgbt<1,1,1,0>*Intensity_]} }
 #end// of Raster(RScale, HLine)-macro
//--------------------------------------------------------------- ////////////
//--------------------------------------------------------------- ////////////
//--------------------------------------------------------------- ////////////
#macro Raster_Plate ( RD1, Width1,//primary raster distance/width,
                      RD2, Width2,//secondary raster distance/width, 
                      Base_Texture, //  non = pigment { Clear } 
                      Intensity, // Line gray intensity
                      Start_Box, End_Box, // vectors
                    ) //------------------------------------------ 
//---------------------------------------------------------------- 
box{ Start_Box,End_Box
     texture{ Base_Texture } 
     #if (RD1 > 0 ) 
         // raster big  RD1, Width1,-------------------
         texture { Raster_Lines(RD1,Width1,Intensity) rotate<0,0,0> }
         texture { Raster_Lines(RD1,Width1,Intensity) rotate<0,90,0>}
     #end 
     #if (RD2 > 0 ) 
         //  raster small RD2, Width2, -----------------
         texture { Raster_Lines(RD2,Width2,Intensity) rotate<0,0,0> }
         texture { Raster_Lines(RD2,Width2,Intensity) rotate<0,90,0>}
     #end 
} // end box ----------------------------------------------- 
#end // --------------------------------------------------------- end of macro
//--------------------------------------------------------------- ////////////
//--------------------------------------------------------------- ////////////

//------------------------------------------------------------- the background raster
#declare Base_Texture = texture{ pigment{ color rgb<1,1,1>*1.2 }} 
//--------------------------------------------------------------------------------
object{ Raster_Plate( 1.0,   0.025, // 1st raster distance/width,
                      0.1,   0.075, // 2nd raster distance/width, 
                      Base_Texture, // non = pigment { Clear } 
                      0.7, // Intensity, // Line gray intensity
                      <-3.00,-0.05,-0.0>, <3.00,0,3.00>, //Start, End, // vectors
                    ) //----------------------------------------------------------
        rotate<-90,0,0> 
        translate<0,0,3>
      } //-----------------------------------------------------------------------------
//--------------------------------------------------------------------------------
object{ Raster_Plate( 1.0,   0.025, // 1st raster distance/width,
                      0.1,   0.075, // 2nd raster distance/width, 
                      Base_Texture, // non = pigment { Clear } 
                      0.7, // Intensity, // Line gray intensity
                      <-3.00,-0.05,-3.0>, <3.00,0,3.00>, //Start, End, // vectors
                    ) //----------------------------------------------------------
        rotate< 0,0,0> 
        translate<0,0,0> //no_shadow
      } //-----------------------------------------------------------------------------

//--------------------------------------------------------------------------------
object{ Raster_Plate( 1.0,   0.025, // 1st raster distance/width,
                      0.1,   0.095, // 2nd raster distance/width, 
                      Base_Texture, // non =  pigment { Clear } 
                      0.7, // Intensity, // Line gray intensity
                      <-3.00,-0.05,-0.0>, <3.00,0,3.00>, //Start, End, // vectors
                    ) //----------------------------------------------------------
        rotate<-90,-90,0> 
        translate<-3,0,0> // no_shadow
      } //-----------------------------------------------------------------------------
 
//------------------------------------------------------------------------------------
/* 
//------------------------------------------------------- squared plane XZ
plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
         texture { Raster_Lines(1.0, 0.01, 0.8) rotate<0,0,0> }
         texture { Raster_Lines(1.0, 0.01, 0.8) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ
*/ 