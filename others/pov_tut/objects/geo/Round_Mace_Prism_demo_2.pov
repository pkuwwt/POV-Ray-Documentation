// POV-Ray 3.6/3.7 Scene File "Round_Mace_Prism_demo_2.pov"
// author: Friedrich A. Lohmueller, Aug-2012
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6;
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
  #declare Camera_Position = < 0.00, 0.50, -3.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.50,  0.00> ;
  #declare Camera_Angle    =  35 ;
#break
#case (1)
  #declare Camera_Position = < -4.00, 2.57, -6.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 0.57-0.15,  0.00> ;
  #declare Camera_Angle    =  14 ;
#break
#case (2)
  #declare Camera_Position = < 5.00, 0.50,  0.00> ;  // rigth side view
  #declare Camera_Look_At  = < 0.00, 0.50,  0.00> ;
  #declare Camera_Angle    =  25 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 3.00, -0.001> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.50,  0.00> ;
  #declare Camera_Angle    =  40 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------------
//------------------------------------------------------------------------
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.2 color rgb<0.24,0.34,0.56>*0.5]//~Navy
                                [0.8 color rgb<0.24,0.34,0.56>*0.5]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 
                     rotate<-50,0,0>
                    }
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
#declare Text_Rotate = < 0,30,0>;
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.45 translate <AxisLenX+0.05,0.25,-0.05> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.45,  0  texture{Tex_Dark}
          rotate <Text_Rotate.x,0,0> scale 0.45 translate <-0.35,AxisLenY+0.30,-0.05> rotate <0,Text_Rotate.y,0> no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.45 translate <-0.45,0.4,AxisLenZ+0.0 > no_shadow }
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

object{ AxisXYZ( 4, 6, 4.5, Texture_A_Dark, Texture_A_Light) scale 0.2  translate <0,0,0> }
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

/*
plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
*/
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
#include "Round_Mace_Prism.inc"  
//-------------------------------------------------------------------------------------//
object{ Round_Mace_Prism (  0.40, // R_main,    // mace radius, >0 and > basic half width
                            0.05, // R_Border,  // border radius >= 0, 0 = nor rounded borders
                            0.70, // H_main,    // height y ( + = up ; - = down ) of main circle center
                            0.20, // R_base,    // basic half width in x of the mace > 2*border radius !
 
                           -0.45, // Depth_Z,   // z depth (+/-) > 2*border radius !  
                            0.20, // Linear_Base_End, // 0 = non 
                            1,    // Rounded_Base_End, // 0/1: 0 = non, 1 = lower end with rounded cylinder 

                            1 // Merge_On - for transparent materials
                          ) // --------------------------------------------------------//
     /* 
       texture { pigment{ color  rgb< 1, 1, 1>}
                 finish { phong 1 reflection 0.00}
               } // end of texture 
    */  
       material{   //-----------------------------------------------------------
          texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.99> }
                   finish { diffuse 0.1 reflection 0.25  
                          specular 0.8 roughness 0.0003 phong 0.5 phong_size 400}
                 } // end of texture -------------------------------------------
          interior{ ior 1.5  caustics 0.5
                 } // end of interior ------------------------------------------
       } // end of material ----------------------------------------------------

       scale<1,1,1>   
       rotate< 0,0,0>
       translate<0,0,0>  
    }  // end of object ---------------------------------------------------------------// 
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
