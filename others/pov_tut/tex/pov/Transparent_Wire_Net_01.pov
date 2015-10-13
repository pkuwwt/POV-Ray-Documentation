// POV-Ray 3.6 / 3.7 Scene File "Wire_Netting_01.pov"
// author: Friedrich A. Lohmueller, Dec-2012
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6;
global_settings{ assumed_gamma 1.0 } 
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
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 0.80, -3.50> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.80,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (1)
  #declare Camera_Position = < 2.00, 2.00, -2.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 0.73,  0.00> ;
  #declare Camera_Angle    = 53 ;
#break
#case (2)
  #declare Camera_Position = < 0.00, 0.80, -4.00> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 0.80,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 5.00,  0+0.000> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0+0.001> ;
  #declare Camera_Angle    =  45 ;
#break
#else
  #declare Camera_Position = < 0.00, 0.80, -3.50> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.80,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.9}           // sun light
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
          rotate Text_Rotate scale 0.75 translate <AxisLenX+0.25,0.2, 0.05> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate <Text_Rotate.x,0,0> scale 0.75 translate <-0.55,AxisLenY+0.20,-0.05> rotate <0,Text_Rotate.y,0> no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.95 translate <-0.5,0.3,AxisLenZ+0.20> no_shadow }
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
                     
object{ AxisXYZ( 3.5, 6.6, 11, Texture_A_Dark, Texture_A_Light) scale 0.25}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.01;
#declare RasterHalfLineZ = 0.01;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.9]
                          [0+HLine color rgbt<1,1,1,0>*0.9]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.9]
                          [1.000   color rgbt<1,1,1,0>*0.9]} }
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

// -----------------------------------
// -----------------------------------
#declare T_Map = // transparency map
 pigment{ 
  image_map{ jpeg "Wire_Net_01.jpg"  
             interpolate 2  
           } //
          warp {
            cylindrical 
            orientation 1 
            dist_exp 1 
          }
          scale 0.09 //0.135 
       } // --------------------------
#declare Opaque_Texture   =
texture{ pigment{ color rgb<1,1,1>*.05}
         finish { phong 0.2 }                  
       } // --------------------------  
#declare Surface_Material  = 
material{
   texture{ 
      pigment_pattern{ T_Map }
      texture_map{
        [0.0 pigment{ rgbf<1,1,1,1>}]
        [1.0 Opaque_Texture  ]  
       } // end texture_map
     }// end texture
  }// end material -------------------
// -----------------------------------
difference{ 
 cylinder{<0, 0  ,0>,<0,1.535,0>,0.700} 
 cylinder{<0,-0.1,0>,<0,1.536,0>,0.699}
 material{ Surface_Material 
           scale <1,3.89,1>
           translate<0,0.015,0>} 
 rotate<0,30,0> 
} // end of cylinder ------------------
torus{ 0.70, 0.0075 
       translate<0,0.005,0> 
       texture { Opaque_Texture }
     }
torus{ 0.70, 0.0075 
       translate<0,1.535,0> 
       texture { Opaque_Texture } 
      }
// -----------------------------------
// -----------------------------------
cylinder{ <0,0,0>,<0,1,0>,0.65
          texture{ 
            pigment{ color rgb<1,1,1>}
            finish { phong 1}
          } // end of texture 
        } // end of cylinder --------- 
// -----------------------------------
// -----------------------------------

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
