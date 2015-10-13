// POV-Ray 3.6 / 3.7 Scene File "Regulare_Tetrahedron_Vectors_1.pov"
// author: Friedrich A. Lohmueller, Dec-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
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
//--------------------------------------------------------------------------------------------------------<<<<
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 0.00, -2.80> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.00,  0.00> ;
  #declare Camera_Angle    =   40 ;
#break
#case (1)
  #declare Camera_Position = < 3.20, 2.00, -2.70> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 0.10,  0.00> ;
  #declare Camera_Angle    =  20 ;
#break
#case (2)
  #declare Camera_Position = < 0.00, 0.00, -2.50> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 0.00,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 3.00, -0.01> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#else
  #declare Camera_Position = < 3.20, 2.00, -2.70> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 0.10,  0.00> ;
  #declare Camera_Angle    =  20 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<-500,1500,-1500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.5 color rgb<0.14,0.14,0.56>*0.7]//~Navy
                                [0.5 color rgb<0.14,0.14,0.56>*0.7]//~Navy
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
#declare Text_Rotate = < 20,-45,0>; // rotate Text_Rotate 

union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.5 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate scale 0.5 translate <-0.75,AxisLenY+0.20,-0.10>}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate Text_Rotate  scale 0.75 translate <-0.75,0.2,AxisLenZ+0.10>}
#end // of #if
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,0.4,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture {
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

// axes ------------------------------------------------------------------- 
object{ AxisXYZ( 6.2, 5.2, 7.2, Texture_A_Dark, Texture_A_Light) scale 0.15 no_shadow }
//-------------------------------------------------- end of coordinate axes

/*
// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.1;
#declare RasterHalfLine  = 0.035;
#declare RasterHalfLineZ = 0.035;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.7]
                          [0+HLine color rgbt<1,1,1,0>*0.7]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.7]
                          [1.000   color rgbt<1,1,1,0>*0.7]} }
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------
plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate< 0,0,0>
        translate<0,0,0> 
      }
//------------------------------------------------ end of squared plane XZ
*/

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

 

// sizes of lines and points ----------------------------------------------- 
#declare Rl = 0.010; // lines radius
#declare Rp = 0.020; // points radius
// textures ---------------------------------------------------------------- 
#declare Edge_Texture = 
         texture { pigment{ color rgb< 0.75, 1.0, 0.0> } 
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#declare Corners_Texture = 
         texture { pigment{ color rgb<0.4,1,0>*0.35 } 
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
#declare Surface_Texture = 
         texture { pigment{ color rgbt< 0.75, 1.0, 0.0, 0.75> }  
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
//------------------------------------------------------------------------------------------------------- 
//------------------------------------------------------------------------------------------------------- 
//--------------------------------------------------------------------- macro "Vector(Start,End,Radius)"!
#macro Vector(P_start,P_end, R_Vector)  
union{

cylinder{ P_start, P_end - ( vnormalize(P_end - P_start)*9.5*R_Vector), R_Vector  }
cone    { P_end - ( vnormalize(P_end - P_start)*10*R_Vector), 3*R_Vector, P_end, 0 }
}// end of union
#end //------------------------------------------------------------------------------------- end of macro
// alternatively:   #include "analytical_g.inc"
//-------------------------------------------------------------------------------------------------------- 

// -------------------------------------------------------------------------------------------------------
#declare Side_a = 1; // length of a side of a regular tetrahedron
// ---- equilateral triangle -----------------------------------------------------------------------------
//#declare Th =  1/2*sqrt(3)*Side_a; // the height of an equilateral triangle
//#declare Sh =  1/6*sqrt(3)*Side_a; // the height of the incenter of an equilateral triangle
//#declare Rc =  1/3*sqrt(3)*Side_a; // radius of circumcircle of an equilateral triangle
// ---- regular tetrahedron ------------------------------------------------------------------------------ 
//#declare Tetra_H = sqrt (2/3) * Side_a; // the height of a regular tetrahedron  
#declare R_circum  = sqrt( 3/8 ) * Side_a; // radius of the circumsphere of a regular tetrahedron 
//#declare R_in  = 1/3 * Rc ; //    or  = 1/sqrt(24) * A = Tetra_H-R_circum ; radius insphere
//#declare Face_Corner_Center_Angle =  degrees (  atan (  R_in / Rf ) );
//#declare Face_to_Face_Angle =  degrees( atan(2*sqrt(2))) ; // degrees (  atan (  Tetra_H/ Sh ) );  ~ 71
//#declare Edge_to_Face_Angle =  degrees( atan(sqrt(2))) ;  //   ~ 55    
#declare Vertex_Center_Vertex_Angle = degrees( acos( -1/3 ))    ;  //  ~ 109.471 
// -------------------------------------------------------------------------------------------------------


// caculation of the vectors ------------------------------------------ 
#declare V1 = <0,R_circum,0>; 
#declare V2 = vrotate ( V1, < Vertex_Center_Vertex_Angle,   0, 0> ); 
#declare V3 = vrotate ( V2, <   0, 120, 0> ); 
#declare V4 = vrotate ( V2, <   0,-120, 0> ); 

// vectors ------------------------------------------------------------ 
object{ Vector( o,V1, Rl) pigment{ color rgb<0.2,0.5,0.0> } no_shadow}
object{ Vector( o,V2, Rl) pigment{ color rgb<0.2,0.5,0.0> } no_shadow}
object{ Vector( o,V3, Rl) pigment{ color rgb<0.2,0.5,0.0> } no_shadow}
object{ Vector( o,V4, Rl) pigment{ color rgb<0.2,0.5,0.0> } no_shadow}


// corners ------------------------------------------------------------ 
sphere{ V1, Rp texture{ Corners_Texture } no_shadow }
sphere{ V2, Rp texture{ Corners_Texture } no_shadow }
sphere{ V3, Rp texture{ Corners_Texture } no_shadow }
sphere{ V4, Rp texture{ Corners_Texture } no_shadow }


// lettering ---------------------------------------------------------- 
text{ ttf "arial.ttf", "A", 0.02, 0.0  rotate<20,-40,0>  
      texture{ Corners_Texture }  
      scale<1,1,1>*0.10  translate V1 + <-0.10,0,-0.10>     no_shadow
    } // end of text object ------------------------------------------- 
text{ ttf "arial.ttf", "B", 0.02, 0.0  rotate<20,-40,0> 
      texture{ Corners_Texture } 
      scale<1,1,1>*0.12  translate V2 + < 0.00,-0.05, 0.15> no_shadow
    } // end of text object ------------------------------------------- 
text{ ttf "arial.ttf", "C", 0.02, 0.0  rotate<20,-40,0> 
      texture{ Corners_Texture } 
      scale<1,1,1>*0.09  translate V3 + < 0.00,-0.12,-0.05> no_shadow
    } // end of text object ------------------------------------------- 
text{ ttf "arial.ttf", "D", 0.02, 0.0  rotate<20,-40,0> 
      texture{ Corners_Texture }  
      scale<1,1,1>*0.10  translate V4 + <-0.15,-0.05,-0.10> no_shadow
    } // end of text object -------------------------------------------
//--------------------------------------------------------------------- 
#declare Point_A = V1; 
#declare Point_B = V2; 
#declare Point_C = V3; 
#declare Point_D = V4; 
// edges ---------------------------------------------------------
cylinder{ Point_A, Point_B, Rl  texture{ Edge_Texture } }
cylinder{ Point_B, Point_C, Rl  texture{ Edge_Texture } }
cylinder{ Point_C, Point_A, Rl  texture{ Edge_Texture } }
cylinder{ Point_A, Point_D, Rl  texture{ Edge_Texture } }
cylinder{ Point_B, Point_D, Rl  texture{ Edge_Texture } }
cylinder{ Point_C, Point_D, Rl  texture{ Edge_Texture } }

// surfaces-------------------------------------------------------
triangle{ Point_A, Point_B, Point_C texture{ Surface_Texture } } 
triangle{ Point_A, Point_B, Point_D texture{ Surface_Texture } } 
triangle{ Point_B, Point_C, Point_D texture{ Surface_Texture } } 
triangle{ Point_C, Point_A, Point_D texture{ Surface_Texture } } 
 
//---------------------------------------------------------------- 
// The corners of a regular tetraeder based on x-axis:
//#declare Point_A = <-Side_a/2,      0, 0>;
//#declare Point_B = < Side_a/2,      0, 0>;
//#declare Point_C = <        0,      0,Th>;
//#declare Point_D = <        0,Tetra_H,Sh>; // "top"
//----------------------------------------------------------------