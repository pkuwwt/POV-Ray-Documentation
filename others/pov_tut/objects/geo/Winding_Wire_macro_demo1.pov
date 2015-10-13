// POV-Ray 3.7 Scene File "Winding_Wire_macro_demo1.pov"
// author: Friedrich A. Lohmueller, Jan-2014
// homepage: http://www.f-lohmueller.de
//---------------------------------------------
#version 3.7;
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
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
#declare Camera_Number = 1 ;
//---------------------------------------------------------------------------------
// camera -------------------------------------------------------------------------
#switch ( Camera_Number )
#case (0)
  #declare Camera_Location = < 0.00, 0.00, -3.50> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.00,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (1)
  #declare Camera_Location =  <2.0  , 2.0 ,-2.0> ;  // diagonal view
  #declare Camera_Look_At  =  < 0.05 , 0.30 , 0.0> ;
  #declare Camera_Angle    =  35 ;
#break
#case (2)
  #declare Camera_Location = < 4.00, 0.00,  0.00> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 0.00,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (3)
  #declare Camera_Location = < 0.00, 5.00,  0+0.000> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0+0.001> ;
  #declare Camera_Angle    =  45 ;
#break
#else
  #declare Camera_Location = < 2.00, 1.00, -2.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 0.30,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#break
#end // of "#switch ( Camera_Number )"  
//-------------------------------------------------------------------------
camera{ // ultra_wide_angle // orthographic 
        location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
// sun --------------------------------------------------------------------
light_source{< 500,1500,-2500> color rgb<1,1,1>*0.9}                // sun
light_source{ Camera_Location  color rgb<0.9,0.9,1>*0.0 shadowless}// flash
// sky --------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<0.24,0.34,0.56>*1.0]
                                [0.3 color rgb<0.24,0.34,0.56>*0.3]
                                [0.7 color rgb<0.24,0.34,0.56>*0.3]
                                [1.0 color rgb<0.24,0.34,0.56>*1.0]
                              }
                     rotate< 0,0, 0>
                     scale 2 }
           } // end of sky_sphere
 
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
#declare Text_Rotate = < 5,-45,0>; //
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arialbd.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.6 translate <AxisLenX+0.15,0.4,-0.05> no_shadow }
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arialbd.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate <Text_Rotate.x,0,0> scale 0.6 translate <-0.55,AxisLenY+0.20,-0.05>
          rotate <0,Text_Rotate.y,0> no_shadow }
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arialbd.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.95 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow }
#end // of #if
} // end of union
#end// of macro "AxisXYZ( ... )"
//-------------------------------------------------------------------------
//------------------------------------------------------------------------
#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,0.45,0>}
                               finish { phong 1}
                           }
#declare Texture_A_Light = texture { 
                              pigment{ color rgb<1,1,1>}
                              finish { phong 1}
                           }
object{ AxisXYZ( 4*2.05,4* 2.4 ,4* 5.0, Texture_A_Dark, Texture_A_Light) scale 0.1 }
//-------------------------------------------------- end of coordinate axes


//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------




//--------------------------------------------------------------------------//////
//--------------------------------------------------------------------------//////
#include "shapes_lo2/Winding_Wire_1.inc"
//--------------------------------------------------------------------------//////
object{ Winding_Wire_1( 0.055, // Wire radius
                        0.19, // vertical wire distance: min 2*WR (pitch)
                        0.50, //  column base radius (to wire center)
                        0.30, //  corner radius major of wire 
                        4.5 , //  4.5 ;// revolutions: 0.25, 0.5, 0.75, 1,2,3 .... 
                      ) //--------------------------------------------------------
          texture{ pigment{ color rgb< 1, 1, 1> } //  color White
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
        rotate<0,0,0> 
        translate<0,0,0>
      } //------------------------------------------------------------------//////
//--------------------------------------------------------------------------//////
//--------------------------------------------------------------------------//////

