// POV-Ray 3.6 / 3.7 Scene File "Erlenmeyer_Shape_1_demo.pov"
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
#declare Camera_Number = 1;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 0.00, 0.20, -2.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.20,  0.00> ;
  #declare Camera_Angle    =  10 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#case (1)
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 0.50, 0.30, -0.50> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 0.15,  0.00> ;
  #declare Camera_Angle    =   27 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#else
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 0.00, 0.60, -0.001> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.15,  0.00> ;
  #declare Camera_Angle    =   27 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//------------------------------------------------------------------------ 
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------ 
// sun ------------------------------------------------------------------- 
light_source{< -3000, 3000, -3000> color White}
// sky ------------------------------------------------------------------- 
sky_sphere { pigment { color rgb<0.24,0.34,0.56>*0.7} 
          
           } //end of skysphere
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
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          scale 0.5 translate <AxisLenX+0.15,0.2,-0.05>}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
           scale 0.5 translate <-0.45,AxisLenY+0.20,-0.05>}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.75,0.2,AxisLenZ+0.10>}
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

//---------------------------------------------------------------------------
 object{ AxisXYZ( 2.65, 6.45, 5, Texture_A_Dark, Texture_A_Light) scale 0.05}
//---------------------------------------------------------------------------
// ground -------------------------------------------------------------------
/*
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <0.7,0.5,0.3>}
              //normal { bumps 0.75 scale 0.025}
                finish { phong 0.1}
              } // end of texture
     } // end of plane
*/
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#declare Base_Height_     = 0.25; 
#declare Base_Half_Width_ = 0.12; 
#declare Neck_Length_     = 0.05;
#declare Neck_Radius_     = 0.03;
#declare Fillet_Radius_   = 0.10; 
#declare Base_Border_Radius_ = 0.025; 
//---------------------------------------------------------------------------------------
#include "Erlenmeyer_Shape_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Erlenmeyer_Shape_1(  Base_Height_, // Base_H, // 
                             Base_Half_Width_, // Base_Half_Width, //  
                             Neck_Length_, // Neck_Len, // 
                             
                             Neck_Radius_, // Neck_R, // 
                             Fillet_Radius_, // Fillet_R, // 
                             Base_Border_Radius_, // Base_Border_R,//  
                             
                             0, // Merge_On, // 
                          ) //-------------------------
 
        texture { pigment{ color rgb< 1, 1, 1> }  
                  finish { phong 1}
                 } // end of texture 

        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
                              