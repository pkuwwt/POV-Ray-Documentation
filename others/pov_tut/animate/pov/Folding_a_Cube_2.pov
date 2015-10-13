// POV-Ray 3.6/3.7 Scene File/ 3.7 Scene File "Folding_a_Cube_2.pov"
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
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00, -7.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  55 ;
#break
#case (1)
  #declare Camera_Position = < 3.00, 3.00, -1.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.50, 0.50,  1.30> ;
  #declare Camera_Angle    =  60;
#break
#case (2)
  #declare Camera_Position = < 6.00, 1.00,  2.00> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 0.00,  2.01> ;
  #declare Camera_Angle    =  50 ;
#break
#case (3)
  #declare Camera_Position = < 0.50, 7.00,  2.00> ;  // top view
  #declare Camera_Look_At  = < 0.50, 0.00,  2.01> ;
  #declare Camera_Angle    =  38 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
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
light_source{<1500,1500,-1500> color White*0.9}           // sun light
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
#local Text_Rotation = <10,-60,0>;
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotation scale 0.85 translate <AxisLenX+0.05,0.05, 0.50>  no_shadow}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotation scale 0.95 translate <-0.65,AxisLenY-0.10,-0.35>  no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotation  scale 1.25 translate <-0.95,0.05,AxisLenZ-0.25>  no_shadow}
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

object{ AxisXYZ( 5, 2.7, 8.5+1, Texture_A_Dark, Texture_A_Light) scale 0.25 } // no_shadow}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.015;
#declare RasterHalfLineZ = 0.015;
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




//---------------------------------------------------- textures
#declare Edge_Texture =
texture{ pigment{ color rgb< 0.75, 1.0, 0.0>*0.8 } //  yellow lemon
         finish { phong 1 }
       } // end of texture
#declare Corner_Texture =
texture{ pigment{ color rgb< 0.35, 0.6, 0.0> } // yellow lemon darker
         finish { phong 1 }
       } // end of texture
#declare Face_Texture =
texture{ pigment{ color rgb< 0.95, 1.0, 0.4>*1.1} // yellow lemon pale
         finish { phong 0.1 }
       } // end of texture
//-----------------------------------------------------------------
//------------------------------------------------------ dimensions
#declare D = 0.0001;
#declare S = 1;
#declare Rl   = 0.02 ; // "edge" line radius
#declare Rp   = 0.04 ; // "point" radius
//-----------------------------------------------------------------
#macro  Cos_010( X )
  (0.5-0.5*cos(2*pi*X))
#end
#declare Fold_Angle =  -90*Cos_010(clock);
//-----------------------------------------------------------------
//--------------------------------------------------------- square
#declare Square =   // das Quadrat, il quadrato, le carré
union{
 // the corners
 union{
  sphere{ <0,0,0>, Rp }
  sphere{ <S,0,0>, Rp }
  sphere{ <S,0,S>, Rp }
  sphere{ <0,0,S>, Rp }
  texture{ Corner_Texture } }
 // the edges
 union{
  cylinder{ <0,0,0>,<S,0,0>, Rl }
  cylinder{ <S,0,0>,<S,0,S>, Rl }
  cylinder{ <0,0,S>,<S,0,S>, Rl }
  cylinder{ <0,0,0>,<0,0,S>, Rl }
  texture{ Edge_Texture } }
 // the face
 box{ <0,-D,0>,<1,D,1>
  texture{ Face_Texture }}
} // end of union
//-----------------------------------------------------------------
//-----------------------------------------------------------------

union{ // A + B + C

  object{ Square } // C ------
  union{ // A + B

     object{ Square } // B ------
     object{ Square   // A ------
             rotate<Fold_Angle ,0,0>
             translate<0,0,S>
           } //-------------
     rotate<Fold_Angle,0,0>
     translate<0,0,S>
  } // end A + B -------------
  rotate<Fold_Angle,0,0>
  translate<0,0,S>
} // end A + B + C -------------

object{ Square } // D ------

object{ Square   // E ------
        translate<-S,0,0>
        rotate<0,0,Fold_Angle>
      } //------------------

object{ Square   // F ------
        rotate<0,0,-Fold_Angle>
        translate<S,0,0>
      } //------------------
//-----------------------------------------------------------------
//----------------------------------------------------------------- end
