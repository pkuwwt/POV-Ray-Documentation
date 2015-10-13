// POV-Ray 3.6 / 3.7 Scene File "Tube_2_Tube_demo.pov"
// author: Friedrich A. Lohmueller, Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.0 diffuse 0.9 }}
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
#declare Camera_Number = 2 ;
//---------------------------
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00,-10.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 4.00, 3.00,-3.500> ;  // front view
  #declare Camera_Look_At  = < 0.80, 0.45,  0.00> ;
  #declare Camera_Angle    =  40 ;
#break
#case (2)
  #declare Camera_Position = < 4.00, 3.00,-3.500> ;  // front view
  #declare Camera_Look_At  = < 0.80, 0.45, -1.00> ;
  #declare Camera_Angle    =  55 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-10.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//---------------------------------------------------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<300, 1500,-2500> color White*0.8} // sun
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.2} // flash light
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.24,0.34,0.56>*0.6]//~Navy
                                [0.6 color rgb<0.24,0.34,0.56>*0.6]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 
                     rotate<-40,0,-20> }
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
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark}
          scale 0.5 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
           scale 0.5 translate <-0.75,AxisLenY-0.30,-0.10>}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.75,0.2,AxisLenZ+0.10>}
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

object{ AxisXYZ( 4.5, 2.55, 8, Texture_A_Dark, Texture_A_Light) scale 0.5}
//-------------------------------------------------- end of coordinate axes

/*
// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.50;
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
*/

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

#local D = 0.00001; 
// --------------------------------------------------------------------
// --------------------------------------------------------------------
#include "Tube_2_Tube.inc"   
// --------------------------------------------------------------------
#declare R1 = 1.00;
#declare R2 = 0.30;  
#declare Len = 1.50; 
#declare End_Center_Y= 0.60; 
#declare End_Center_Z= 0.80; 
// --------------------------------------------------------------------
object{ Tube_2_Tube      (  R1 , // Radius_1_, 
                            R2, // Radius_2_, 
                           Len, // Length_,    [1->1000;2->500]
                          
                           End_Center_Y, // End_Center_Y_,
                           End_Center_Z, // End_Center_Z_,

                           1, // Accuracy, // >= 1  
                           0, // Merge_On ) 
                        
                        ) //-------------------------------------------
        texture { pigment{ color rgb< 1,1,1>*1.2}// 0.75, 1.0, 0.0> } //  yellow lemon
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1 reflection 0.00}
                } // end of texture 
        
        scale<1,1,1>
        rotate<0, 00,0>
        translate< 0, 0.0, 0>
      
      } // ------------------------------------------------------------ 
 cylinder{ <0,0,0>,< +0.5,0,0>, R2 translate<Len,End_Center_Y,End_Center_Z> pigment{ color rgbt< 1,1,1,0.7>*1.0}} 
 cylinder{ <-1,0,0>,<0,0,0>, R1 pigment{ color rgbt< 1,1,1,0.7>*1.0}} 
// --------------------------------------------------------------------      
      
      
//------------------------------------------------------------------------------------
//------------------------------------------------- macro "Vector(Start,End,Radius)"!
#macro Vector(P_start,P_end, R_Vector)  
union{
cylinder{ P_start, P_end - ( vnormalize(P_end - P_start)*9.5*R_Vector), R_Vector  }
cone    { P_end - ( vnormalize(P_end - P_start)*10*R_Vector), 3*R_Vector, P_end, 0 }
}// end of union
#end //------------------------------------------------------------------ end of macro
//------------------------------------------------------------------------------------
#declare A  = <Len+0.5,0,0>;  
#declare B  = <Len+0.5,0,End_Center_Z>; 
#declare C  = <Len+0.5,End_Center_Y,End_Center_Z>;
//------------------------------------------------------------------------------------
object{ Vector( A,B, 0.02) pigment{ color rgb<0.5,0.2,1.0> } }
object{ Vector( B,C, 0.02) pigment{ color rgb<0.5,0.9,0.0> } }
//------------------------------------------------------------------------------------
      
      
      
#declare R1 = 0.15;
#declare R2 = 0.40;  
#declare Len = 0.50; 
#declare End_Center_Y= 0.00; 
#declare End_Center_Z= 1.50; 
// --------------------------------------------------------------------
union{ 
object{ Tube_2_Tube      ( R1 , // Radius_1_, 
                           R2, // Radius_2_, 
                           Len, // Length_, [ >0.5;  1->1500;2->500]
                          
                           End_Center_Y, // End_Center_Y_,
                           End_Center_Z, // End_Center_Z_,

                           1, // Accuracy, // >= 1  
                           0, // Merge_On ) 
                        
                        ) //-------------------------------------------
        texture { pigment{ color rgb< 1,1,1>*1.2}// 0.75, 1.0, 0.0> } //  yellow lemon
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1 reflection 0.00}
                } // end of texture 
        
        scale<1,1,1>
        rotate<0,0,0>
        translate<0,0,0>
      
      } // ------------------------------------------------------------ 
 cylinder{ <-D,0,0>,<+0.5,0,0>, R2 translate<Len,End_Center_Y,End_Center_Z> pigment{ color rgbt< 1,1,1,0.7>*1.0}} 
 cylinder{ <-1,0,0>,<   D,0,0>, R1 pigment{ color rgbt< 1,1,1,0.7>*1.0}} 
// --------------------------------------------------------------------      
rotate<0,0, 90> rotate<0,-30,0>
translate< 0, 0.0, -3>
}// end of union  


#declare R1 = 0.50;
#declare R2 = 0.20;  
#declare Len = 0.70; 
#declare End_Center_Y= 0.00; 
#declare End_Center_Z= 0.00; 
// --------------------------------------------------------------------
union{ 
object{ Tube_2_Tube      (  R1 , // Radius_1_, 
                            R2, // Radius_2_, 
                           Len, // Length_,    [1->1500;2->500]
                          
                           End_Center_Y, // End_Center_Y_,
                           End_Center_Z, // End_Center_Z_,

                           1, // Accuracy, // >= 1  
                           0, // Merge_On ) 
                        
                        ) //-------------------------------------------
        texture { pigment{ color rgb< 1,1,1>*1.2}// 0.75, 1.0, 0.0> } //  yellow lemon
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1 reflection 0.00}
                } // end of texture 
        
        scale<1,1,1>
        rotate<0,0,0>
        translate<0,0,0>
      
      } // ------------------------------------------------------------ 
 cylinder{ <-D,0,0>,<+0.5,0,0>, R2 translate<Len,End_Center_Y,End_Center_Z> pigment{ color rgbt< 1,1,1,0.7>*1.0}} 
 cylinder{ <-1,0,0>,<   D,0,0>, R1 pigment{ color rgbt< 1,1,1,0.7>*1.0}} 
// --------------------------------------------------------------------      
rotate<0,0,0>
translate< 0,-1, -1.5>
}// end of union  

// -------------------------------------------------------------------- 
// -------------------------------------------------------------------- 