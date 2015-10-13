// POV-Ray 3.6 / 3.7 Scene File "Two_Cylinder_Blob_1_demo.pov"
// author: Friedrich A. Lohmueller, Feb-2010, May-2014
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#if ( version < 3.7 ) global_settings{ assumed_gamma 1.0 } #end
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
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 0.5, 0.4, -0.5> ;  // diagonal view
  #declare Camera_Look_At  = < 0.02, 0.0,  0.06> ;
  #declare Camera_Angle    =  20 ;
#break
#else
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#end // of "#switch ( Camera_Number )"
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// sun ----------------------------------------------------------------------
light_source{<-2000,1200,-2500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky ----------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.2 color rgb<0.24,0.34,0.56>*0.7]//~Navy
                                [0.8 color rgb<0.24,0.34,0.56>*0.7]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//---------------------------------------------------------------------------

//------------------------------ the Axes -----------------------------------
//---------------------------------------------------------------------------
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
//---------------------------------------------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, Tex_Dark, Tex_Light)
//--------------------- drawing of 3 Axes -----------------------------------
#declare Text_Rotate = <20,-35,0>;
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.65 translate <AxisLenX+0.15,0.3,-0.05> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          scale 0.65 translate <-0.75,AxisLenY+0.20,-0.05> rotate Text_Rotate no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.65 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow }
#end // of #if
} // end of union
#end// of macro "AxisXYZ( ... )"
//---------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,0.45,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture {
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ(  5.5, 3, 12, Texture_A_Dark, Texture_A_Light) scale 0.025 no_shadow}
//----------------------------------------------------- end of coordinate axes


// ground --------------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.05;
#declare RasterHalfLine  = 0.025;
#declare RasterHalfLineZ = 0.025;
//----------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------- objects in scene -----------------------------

//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
#include "Two_Cylinder_Blob_1.inc"
//----------------------------------------------------------------------------
object{ Two_Cylinder_Blob_1 ( 0.127, // Pitch, // distance of the 2 cylinders
                              0.009, // SD,    // slice thickness
                              0.051, // Cyl_R, // cylinder radius
                              0.081, // Fillet_R , // fillet radius
                              0.022, // Axis_R, // < Cyl_R, 0=non
                              0.005, // Border_R, //
                            )

        texture { pigment{ color rgb<1, 1,1>}
                 // normal { bumps 0.15 scale 0.0005}
                  finish { phong 1.0 reflection 0.10}
                } // end of texture

        scale<1,1,1>  rotate<0,0,0>  translate<0,0,0>
      } // end of sphere -----------------------------------------------------
//----------------------------------------------------------------------------
object{ Two_Cylinder_Blob_1 ( 0.127, // Pitch, // distance of the 2 cylinders
                              0.009*5, // SD,    // slice thickness
                              0.051, // Cyl_R, // cylinder radius
                              0.081, // Fillet_R , // fillet radius
                              0.000, // Axis_R, // < Cyl_R, 0=non
                              0.005, // Border_R, //
                            )

        texture { pigment{ color rgb<1, 1,1>}
                 // normal { bumps 0.15 scale 0.0005}
                  finish { phong 1.0 reflection 0.10}
                } // end of texture

        scale<1,1,1>  rotate<0,0,0>  translate<0,0,0.15>
      } // end of sphere -----------------------------------------------------
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------