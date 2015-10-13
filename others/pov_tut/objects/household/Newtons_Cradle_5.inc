// POV-Ray 3.6/3.7 include file "Newtons_Cradle_5.inc"                                                                
// author: Friedrich A, Lohmueller, Oct-2008 / April-2013, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Newtons_Cradle_5_Inc_Temp)
#declare Newtons_Cradle_5_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//--------------------------------------------------------------------------
#ifndef ( Shapes3_Inc_Temp )
#include "shapes3.inc"
#end 

//---------------------------------------------------------------------
#macro Newtons_Cradle_5( Time, // time for clock from 0 to 1 
                         Amplitude, // degrees from vertical 

                         Frame_R_min, // R_minor, 
                         Frame_R_maj, // R_major, 
                         Frame_Height, //  height in y
                         Frame_Width, //   width in x
                         Frame_Length, //  length in z 

                         Ball_Radius, //Ball_R ,  
                         Wire_R , // Filament_R , 
                         Ball_H  // Ball_H , 
                       ) // -------------------------------  
//---------------------------------------------------------------------
#ifndef (Ball_Texture) 
#declare Ball_Texture = texture{ Polished_Chrome } ; 
#end 
#ifndef (Cradle_Texture) 
#declare Cradle_Texture = texture{ Polished_Chrome } ; 
#end 
//---------------------------------------------------------------------
//---------------------------------------------------------------------
//------------------------------------------------------------ sub macros

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
#declare Ball_1_Rotate = Amplitude*sin(2*pi*Time)* (Time<=0.5) ;  
#declare Ball_2_Rotate = Amplitude*sin(2*pi*Time)* (Time<=0.5) ;   
#declare Ball_3_Rotate = Amplitude*sin(2*pi*Time)*1;// (Time>0.5) ;  
#declare Ball_4_Rotate = Amplitude*sin(2*pi*Time)* (Time>0.5) ;  
#declare Ball_5_Rotate = Amplitude*sin(2*pi*Time)* (Time>0.5) ;   
//---------------------------------------------------------------------
//---------------------------------------------------------------------
//---------------------------------------------------------------------
//---------------------------------------------------------------------
#declare One_Ball = 
 object{ Newtons_Cradle_Ball( Ball_Radius ,// Ball_R ,  
                              Wire_R , // Filament_R , 
                              Ball_H , // Ball_H , 
                              Frame_Width-2*Frame_R_min // in x 
                           ) //-------------------------
         texture{ Ball_Texture } 
       }  // end of object ----------------------------------- 
//---------------------------------------------------------------------
//---------------------------------------------------------- finally !!!!
union{
 // -------------------------------------------------------------------
 object{Newtons_Cradle_Frame ( Frame_R_min, // R_minor, 
                               Frame_R_maj, // R_major, 
                               Frame_Height, //  height in y
                               Frame_Width, //   width in x
                               Frame_Length  //  length in z 
                            ) //-------------------------
         texture{ Cradle_Texture } 
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
}// end of union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------


//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//------------------------------------------------------------------optional textures -//
#declare Ball_Texture = texture{ Polished_Chrome } ; 
#declare Cradle_Texture = texture{ Polished_Chrome } ; 
//-------------------------------------------------------------------------------------//
#include "Newtons_Cradle_5.inc" 
//-------------------------------------------------------------------------------------// 
object{Newtons_Cradle_5 ( 0.25, //  Time, // time for clock from 0 to 1 
                          50,  // Amplitude, // degrees from vertical 

                          0.025, // Frame_R_min, // R_minor, 
                          0.15,  // Frame_R_maj, // R_major, 
                          1.40,  // Frame_Height, //  height in y
                          1.20,  // Frame_Width, //   width in x
                          1.90,  // Frame_Length, //  length in z 

                          0.15,  // Ball_Radius, //Ball_R ,  
                          0.015, // Wire_R , // Filament_R , 
                          1.00,  // Ball_H , // Ball_H , 
                        ) // -------------------------------------------
        // no_shadow 
        scale<1,1,1>  rotate<0,0,0>  translate<0,0,0>  
     } // ------------------------------------------------------------- 

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Newtons_Cradle_5_Inc_Temp;
#end
//------------------------------------- end of include file

