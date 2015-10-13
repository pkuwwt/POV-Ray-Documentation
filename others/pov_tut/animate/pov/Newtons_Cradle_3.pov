// PoVRay 3.7 Scene File "Newtons_Cradle_3.pov"
// created by Friedrich A. Lohmueller, March-2008/Aug-2009/Jan-2011/April-2013
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
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------
#declare Cam_Pos_0 =  <0.0 , 1.0 ,-10.0>;  // front view     //
#declare Cam_Pos_1 =  <2.2 , 1.8 ,-3.0 >;  // diagonal view
//---------------------------------------
#declare Look_At_0 = < 0.00, 0.50, 0.00>;
#declare Look_At_1 = <-0.10, 0.47, 0.00>;
//---------------------------------------
#declare Camera_Angle_0 = 65; // in degrees
#declare Camera_Angle_1 = 40; // in degrees
//---------------------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ /*ultra_wide_angle*/   // don't use fish eye - for proper text
        location  Cam_Pos_1
        right     x*image_width/image_height
        angle Camera_Angle_1
        look_at  Look_At_1
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<2500,1500,-1700> color White}
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>       ]//White
                                [0.4 color rgb<0.68,0.68,1> ]//~LightBlue
                                [0.6 color rgb<0.68,0.68,1> ]//~LightBlue
                                [1.0 color rgb<1,1,1>       ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//------------------------------------------------------------------------
plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.8}}
      }

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
#ifndef ( Shapes3_Inc_Temp )
#include "shapes3.inc"
#end

#macro Newtons_Cradle_Frame ( FR_min, // minor radius
                              FR_maj, // major radius
                              Frame_H, // height in y
                              Frame_W, // width in x
                              Frame_L //  length in z
                            ) //-------------------------
//#local D = 0.00001;
#if (FR_maj <= FR_min) #local FR_maj= FR_min+D; #end

#local FR_H = Frame_H -2*FR_min ; // inner height in y
#local FR_W = Frame_W -2*FR_min ; // inner width in x
#local FR_L = Frame_L -2*FR_min ; // inner length in z


#local F_Quart =
object{ Segment_of_Torus( FR_maj,FR_min, 90)
   //     scale <1,1,1> rotate<-90,0,0> translate<0*FR_maj,0*FR_maj,0*FR_maj>
      } // end of Torus_Segment(...) -----------------------
//----------------------------------------------------------
union{
// in x
 cylinder{ <-(FR_W/2-FR_maj),0,0>,<(FR_W/2-FR_maj),0,0>,FR_min translate<0,0,-FR_L/2>}
 cylinder{ <-(FR_W/2-FR_maj),0,0>,<(FR_W/2-FR_maj),0,0>,FR_min translate<0,0, FR_L/2>}
// in z
 cylinder{ <0,0,-(FR_L/2-FR_maj)>,<0,0,(FR_L/2-FR_maj)>,FR_min translate< FR_W/2,FR_H,0>}
 cylinder{ <0,0,-(FR_L/2-FR_maj)>,<0,0,(FR_L/2-FR_maj)>,FR_min translate<-FR_W/2,FR_H,0>}

// verticals
 cylinder{ <0,FR_maj,0>,<0,FR_H-FR_maj,0>,FR_min translate< FR_W/2,0, FR_L/2>}
 cylinder{ <0,FR_maj,0>,<0,FR_H-FR_maj,0>,FR_min translate< FR_W/2,0,-FR_L/2>}
 cylinder{ <0,FR_maj,0>,<0,FR_H-FR_maj,0>,FR_min translate<-FR_W/2,0, FR_L/2>}
 cylinder{ <0,FR_maj,0>,<0,FR_H-FR_maj,0>,FR_min translate<-FR_W/2,0,-FR_L/2>}

// corners:
// low
 object{ F_Quart rotate<-90, 0, 0> translate< FR_W/2-FR_maj,FR_maj,-FR_L/2>}
 object{ F_Quart rotate<-90, 0, 0> translate< FR_W/2-FR_maj,FR_maj, FR_L/2>}

 object{ F_Quart rotate<-90,180,0> translate<-FR_W/2+FR_maj,FR_maj,-FR_L/2>}
 object{ F_Quart rotate<-90,180,0> translate<-FR_W/2+FR_maj,FR_maj, FR_L/2>}
// high
 object{ F_Quart rotate< 90, 90,0> translate< FR_W/2,FR_H-1*FR_maj,-FR_L/2+FR_maj>}
 object{ F_Quart rotate< 90,-90,0> translate< FR_W/2,FR_H-1*FR_maj, FR_L/2-FR_maj>}

 object{ F_Quart rotate< 90, 90,0> translate<-FR_W/2,FR_H-1*FR_maj,-FR_L/2+FR_maj>}
 object{ F_Quart rotate< 90,-90,0> translate<-FR_W/2,FR_H-1*FR_maj, FR_L/2-FR_maj>}
translate<0,FR_min,0>
} // end of union ---------------------------------------------------------
#end // end of macro ------------------------------------------------------





// -------------------------------------------------------
#macro Newtons_Cradle_Ball ( Ball_R , // radius of sphere
                             Wire_R ,// the radius of the wire
                             Ball_H , // depth of the sphere
                             Frame_X // Frame_width
                           ) //---------------------------
//--------------------------------------------------------
union{
  sphere{<0,0,0>, Ball_R translate<0,-Ball_H-Ball_R,0>}
  cylinder{ <-Frame_X/2,0,0>,<-Ball_R/5,-Ball_H,0>,Wire_R}
  cylinder{ < Frame_X/2,0,0>,< Ball_R/5,-Ball_H,0>,Wire_R}
  sphere{<0,0,0>,Ball_R/5 translate<0,-Ball_H,0>}
} // end of union ----------------------------------------
#end // end of macro -------------------------------------

//----------------------------------------------------------
//----------------------------------------------------------
//----------------------------------------------------------
#declare Time = 0.00+clock; // ( time for clock from 0 to 1)
#declare Amplitude = 50;

#declare Ball_1_Rotate = Amplitude*sin(2*pi*Time)* (Time<=0.5) ;
#declare Ball_2_Rotate = Amplitude*sin(2*pi*Time)* (Time<=0.5) ;
#declare Ball_3_Rotate = Amplitude*sin(2*pi*Time)*1;// (Time>0.5) ;
#declare Ball_4_Rotate = Amplitude*sin(2*pi*Time)* (Time>0.5) ;
#declare Ball_5_Rotate = Amplitude*sin(2*pi*Time)* (Time>0.5) ;


#declare Frame_R_min = 0.025;
#declare Frame_R_maj =  0.15;
#declare Frame_Height = 1.40;
#declare Frame_Width = 1.20;
#declare Frame_Length = 1.90;

#declare Ball_Radius = 0.15;
#declare Ball_H      = 1.00;
#declare Wire_R      = 0.015;// radius of the cables

#declare One_Ball =
 object{ Newtons_Cradle_Ball( Ball_Radius ,// Ball_R ,
                              Wire_R , // Filament_R ,
                              Ball_H , // Ball_H ,
                              Frame_Width-2*Frame_R_min // in x
                           ) //-------------------------
         texture{ Polished_Chrome }
       }  // end of object -----------------------------------

//----------------------------------------------------------
//----------------------------------------------------------
//----------------------------------------------------------
union{
 // -------------------------------------------------------------------
 object{Newtons_Cradle_Frame ( Frame_R_min, // R_minor,
                               Frame_R_maj, // R_major,
                               Frame_Height, //  height in y
                               Frame_Width, //   width in x
                               Frame_Length  //  length in z
                            ) //-------------------------
         texture{ Polished_Chrome }
       }  // end of object -----------------------------------
 //----------------------------------------------------------
 union{
 // all balls together and upward
 object{ One_Ball rotate<Ball_1_Rotate,0,0>  translate<0,0,-4*Ball_Radius>}
 object{ One_Ball rotate<Ball_2_Rotate,0,0>  translate<0,0,-2*Ball_Radius>}
 object{ One_Ball rotate<Ball_3_Rotate,0,0>  translate<0,0, 0*Ball_Radius>}
 object{ One_Ball rotate<Ball_4_Rotate,0,0>  translate<0,0, 2*Ball_Radius>}
 object{ One_Ball rotate<Ball_5_Rotate,0,0>  translate<0,0, 4*Ball_Radius>}
 translate<0,Frame_Height-Frame_R_min,0> } // end balls
 //----------------------------------------------------------
no_shadow
scale<1,1,1>  rotate<0,0,0>  translate<0,0,0>
}// end of union
//----------------------------------------------------------
//----------------------------------------------------------
//----------------------------------------------------------