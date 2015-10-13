// POV-Ray 3.6 / 3.7 Scene File "Erlenmeyer_Flask_1_demo.pov"
// author: Friedrich A. Lohmueller, Feb-2010/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
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
  #declare Camera_Position = < 0.00, 0.20, -1.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.20,  0.00> ;
  #declare Camera_Angle    =  7 ;
#break
#case (1)
  #declare Camera_Position = < 0.50, 0.35, -0.50> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 0.16,  0.00> ;
  #declare Camera_Angle    =   25;
#break
#else
  #declare Camera_Position = < 0.00, 0.20, -1.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.20,  0.00> ;
  #declare Camera_Angle    =  7 ;
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
light_source{<1000,2500,-2500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light
// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.30, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.30, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   5
      color      color rgb<0.24,0.34,0.56>*0.9 //White  
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }
//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
#macro Axis_( AxisLen, Dark_Texture,Light_Texture)
 union{
    cylinder { <0,-AxisLen*6,0>,<0,AxisLen,0>,0.05
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
          rotate Text_Rotate scale 0.45 translate <AxisLenX+0.15,0.2, 0.05> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          scale 0.5 translate <-0.45,AxisLenY+0.20,-0.00> rotate Text_Rotate  no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.65 translate <-0.65,0.0,AxisLenZ-0.15> no_shadow }
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

object{ AxisXYZ( 2.65, 6.45, 5, Texture_A_Dark, Texture_A_Light) scale 0.05}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.1;
#declare RasterHalfLine  = 0.025;
#declare RasterHalfLineZ = 0.025;
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
       // rotate<-90,0,0>
      }
//------------------------------------------------ end of squared plane XY

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------




//--------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#declare Glass_D         = 0.002; 
#declare Base_Height     = 0.25; 
#declare Base_Half_Width = 0.12; 
#declare Neck_Length     = 0.05;
#declare Neck_Radius     = 0.03;
#declare Fillet_Radius   = 0.10; 
#declare Base_Border_Radius = 0.025; 
//-------------------------------------------------------------------------------------// 
#include "Erlenmeyer_Flask_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Erlenmeyer_Flask_1(  Glass_D, // 
                             Base_Height, // Base_H, // 
                             Base_Half_Width, // Base_Half_Width, //  
                             Neck_Length, // Neck_Len, // 
                             
                             Neck_Radius, // Neck_R, // 
                             Fillet_Radius, // Fillet_R, // 
                             Base_Border_Radius, // Base_Border_R,//  
                             
                             1, // Merge_On, // 1 for transparent materials 
                          ) //-------------------------
 
        material{   //-----------------------------------------------------------
         texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                   normal { bumps 0.15 scale 0.03} 
                   finish { diffuse 0.1 reflection 0.2  
                            specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                 } // end of texture -------------------------------------------
         interior{ ior 1.5 caustics 0.5
                 } // end of interior ------------------------------------------
        } // end of material ----------------------------------------------------


        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.0001, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
