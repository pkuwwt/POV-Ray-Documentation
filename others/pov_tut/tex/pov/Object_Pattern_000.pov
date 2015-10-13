// POV-Ray 3.6 / 3.7 Scene File "Object_Pattern_000.pov"
// author: Friedrich A. Lohmueller, Dec-2012
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
  #declare Camera_Position = < 0.00, 1.00,-10.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 5.00, 4.50, -7.50> ;  // diagonal view
  #declare Camera_Look_At  = <-2.20, 1.00,  0.00> ;
  #declare Camera_Angle    =  35 ;
#break
#case (2)
  #declare Camera_Position = < 0.00, 1.00,-10.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 8.00,  0+0.000> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0+0.001> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.2 color rgb<0.24,0.34,0.56>*0.8]//~Navy
                                [0.8 color rgb<0.24,0.34,0.56>*0.8]//~Navy
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
    cone{<0,AxisLen,0>,0.15,<0,AxisLen+0.5,0>,0
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
          rotate Text_Rotate scale 0.5 translate <AxisLenX+0.15,0.2,-0.05> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate <Text_Rotate.x,0,0> scale 0.5 translate <-0.35,AxisLenY+0.20,-0.05> rotate <0,Text_Rotate.y,0> no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.65 translate <-0.15,0.2,AxisLenZ+0.10> no_shadow }
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

//object{ AxisXYZ( 1.5, 3.25, 4, Texture_A_Dark, Texture_A_Light) scale 1}
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
/* 
// alternative declaration of textures
#declare Street_Texture = 
      texture{ pigment{ color rgb<1,1,1>*0.4}
               normal { bumps 0.25 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture
#end
#ifndef( Stripes_Texture )
#declare Stripes_Texture = 
      texture{ pigment{ color rgb<1,1,1>*1.1}
             //normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.5}
             } // end of texture
*/
//-------------------------------------------------------------------------------------// Street
#include "Street_10.inc"  // street with center stripes with continuous border lines
//-------------------------------------------------------------------------------------// 
object{ Street_10( 10,     // Street_Widthm, // 
                   1000 , // Street_Length, //
                   0.10,  // Stripes_Width, // 
                   1.00,  // Stripes_Length                                  
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,90,0> 
        translate<-500.00,0.00,3.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

//--------------------------------------------------
#declare Pattern_Object_1= 
union{ 
  box{ <-7.00,1.35,-1.50>,< 0.78,1.40,1.50> }  
  box{ <-7.00,1.25,-1.50>,< 0.78,1.30,1.50> }  

  text{ ttf "arialbd.ttf", "POV-Ray", 0.5, 0.0 
        matrix<1, 0, 0, //  matrix-shear_y_to_x 
            0.35, 1, 0,
               0, 0, 1,
               0, 0, 0>
        scale<0.83,0.9,1> translate<-5.7,1.6,-1.5> } 
                               
  text{ ttf "arialbd.ttf", "POV-Ray", 0.5, 0.0 
        matrix<1  , 0, 0, //  matrix-shear_y_to_x 
        0.35, 1, 0,
        0  , 0, 1,
        0  , 0, 0>
        rotate<0,180,0>
        scale<0.83,0.9,1> translate<-2.25,1.6,1.5> } 
} // end of union                                      
//--------------------------------------------------
#declare Object_Pigment_1 = 
pigment{ 
   object {  
    Pattern_Object_1
    color rgb<1,0.95,0.75> // outside
    color rgb<0.8,0.15,0>  // inside 
   }// object
  } // end pigment 
//--------------------------------------------------





//--------------------------------------------------
#declare Truck_Texture =  
   texture{ pigment{ Object_Pigment_1 }
            finish { phong 1 }
          }
//--------------------------------------------------
#include "Truck_12.inc"                              
//--------------------------------------------------
object{ Truck_12( 0, // Front wheel angle: ~  +/-60
                  Truck_Texture 
                ) //-------------------------------- 
        scale< 1,1,1>
        rotate<0, 0,0> 
        translate<0.00,0,0.00>
      } //------------------------------------------
//--------------------------------------------------
//--------------------------------------------------







