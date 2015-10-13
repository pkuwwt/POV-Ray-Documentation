// POV-Ray 3.6 / 3.7 Scene File "Cheese_1demo.pov"
// author: Friedrich A. Lohmueller, Dec-2009
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#if ( version < 3.7 ) global_settings{ assumed_gamma 1.0 } #end
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
//--------------------------------------------------------------------------------------------------------<<<<
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 0.30, -1.50> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.30,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (1)
  #declare Camera_Position = <-1.00, 1.00,-1.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.15, 0.06,  0.00> ;
  #declare Camera_Angle    =  14 ;
#break
#case (2)
  #declare Camera_Position = <-2.00, 0.50,  0.00> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 0.50,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#else
  #declare Camera_Position = < 0.00, 0.30, -1.50> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.30,  0.00> ;
  #declare Camera_Angle    =  45 ;
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
light_source{<-1500,2500,-2500> color White*0.9}           // sun light
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
#declare T_Rotate = <20,45,0>; 
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate T_Rotate scale 0.5 translate <AxisLenX+0.05,0.4,-0.10> no_shadow}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate T_Rotate scale 0.5 translate <-0.75,AxisLenY+0.50,-0.10> no_shadow}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate T_Rotate scale 0.5 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow}
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

object{ AxisXYZ( 6.6*2, 3.25*2, 1.25*2, Texture_A_Dark, Texture_A_Light) scale 0.07/2 }
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.1;
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


//------------------------------------------------------------------------------
//----------------------------------------------------------- optional textures
#declare Cheese_Texture =  
         texture { pigment{ color rgb< 1.0, 0.85, 0.35> } //  light orange
                   normal { bumps 0.15 scale 0.025 }
                   finish { phong 1 reflection 0.05}
                 } // end of texture 
#declare Cheese_Skin_Texture =  
         texture { pigment{ color rgb< 1.0, 0.55, 0.3> } //  red orange
                   normal { bumps 0.25 scale 0.025 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
//--------------------------------------- optional random seed number 0~32000
#declare Rnd_ = seed( 18426);  // 18426
//------------------------------------------------------------------------------
#include "pov_objects3/Cheese_1.inc"
//------------------------------------------------------------------------------
object{ Cheese_1( 30,   // Cut_Angle_, 
                  0.30, // Cheese_R_, 
                  0.15, // Cheese_H_,     
                  0.05, // Cheese_Border_R_, 
                 )// --------------------------
// rotate<0,180,0>

 translate<0.0,0, 0.0>  // rotate<0,-30,0>
} // ---------------------------------------------------------
//------------------------------------------------------------------------------










   
 