// POV-Ray 3.7 Scene File "Accelerate_speed_1.pov"
// author: Friedrich A. Lohmueller, June-2012
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
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 2 ;
//---------------------------
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = <9.5 , 4.5  ,-0.5> ;  // diagonal view
  #declare Camera_Look_At  = <1.0 ,  -0.8 , 5.5> ;
  #declare Camera_Angle    =  65 ;
#break
#case (2)
  #declare Camera_Position = <9.5 , 4.5  ,-0.5> ;  // diagonal view
  #declare Camera_Look_At  = <1.0 ,  -0.5 , 3.5> ;
  #declare Camera_Angle    =  48 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-10.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<4.25, 2.5,-1.15> color White*0.8}
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.2}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.24,0.34,0.56>]//~Navy
                                [0.6 color rgb<0.24,0.34,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//------------------------------------------------------------------------
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
          rotate Text_Rotate scale 0.65 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow }
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

//object{ AxisXYZ( 4.5, 3.0, 5, Texture_A_Dark, Texture_A_Light) scale 0.2}
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

//-----------------------------------------------------------------------------------------
//------------------------------------------- objects in scene ----------------------------
//-----------------------------------------------------------------------------------------



#macro Z_Sphere ( Radius_, Way_ ) // ---------------------------------------
#local Rot_Angle = Way_/Radius_ *360 / ( 2*pi* pow(Radius_,2) )  ; 
       // circumference / 360 = 1 degree  
       // circumference =  2*pi* pow(Radius_,2)
sphere{ <0,0,0>,Radius_
/*
        texture{ pigment{ checker color rgb<1,1,1> color rgb<1,1,1>*0.05 }   
                 finish { phong 1 reflection { 0.1 metallic 0.5} } 
                 scale Radius_
               } // end texture 
*/
        texture{ pigment{ radial frequency 2
                          color_map{ [0.0 color White]
                                     [0.5 color White]
                                     [0.5 color Black]
                                     [1.0 color Black]
                                   }
                        }   
                 finish { diffuse 0.9 phong 1 } 
                 rotate<0,0,90> scale 0.25 translate<0,0,0>
               } // end of texture 
 
        rotate<Rot_Angle,0,0>                 
        translate <0,Radius_,0> 
      } // end sphere 
#end // of macro -----------------------------------------------------------


 // ----------------------------------------------------------------------
 // ----------------------------------------------------------------------
 // fr: 
 // vitesse constante :                       v = const.   
 // distance parcourue :                   s(t) = v * t     
 // ----------------------------------------------------------------------
 // accélération constant                    a  = const.
 // vitesse avec accélération constant:    v(t) =   a*t   + v(0)   
 // distance parcourue avec aceleration:   s(t) = a/2*t*t + v(0)*t + s(0)

 // en: 
 // constant speed :                         v = const.   
 // covered distance :                     s(t) = v * t     
 // ----------------------------------------------------------------------
 // constant acceleration                   a  = const.
 // speed with constant acceleration:     v(t) =   a*t   + v(0)   
 // covered distance with acceleration:   s(t) = a/2*t*t + v(0)*t + s(0)
 // ----------------------------------------------------------------------
 // ----------------------------------------------------------------------

#declare Total_Time = 4.48;  
#declare Time = Total_Time*(clock + 0.00)  ; //   4*(0 ~ 1) - all will to place in 4 "seconds"

#declare Time_A  = 2.65; // start with acceleration 
#declare Time_B  = 3.45; //   end with acceleration 
#declare Ac_Time =  Time_B - Time_A; // total aceleration time
#declare End_Time= Total_Time - Time_B; // last sector without acceleration 


#declare Acceleration =   5.0 ;
#declare V_0         =     1 ; // v(0) = constant speed at start 

// final speed after acceleration     ---- vitesse finale après l'accélération constante
#declare Speed_End  = Acceleration * Ac_Time + V_0 ; 
 
// covered distances          ---- distances parcourues ----- 
//1: with constant speed:       ---- avec vitesse constante:  
#declare Way1 = V_0*Time_A ;  
//2: with constant acceleration  --- avec accélération constante:  
#declare Way2 =  Acceleration/2* pow(Ac_Time,2) + V_0*Ac_Time + Way1  ;   
                             //Ac_Time*Ac_Time 

// with constant speed in last sector  --- avec la vitesse constant dans le dernière secteur
//3: total distance                    --- distance totale   
#declare Way3 =  Speed_End*(  End_Time ) + Way2 ;   


//--------------------------------------------------------------------------------------------------

// calculating the distance at 'Time'      --- calulation de la distance au temps 'Time'
// covered by the rolling sphere;          --- parcourue de la sphère roulante:

 #if ( Time < Time_A )   //---------------------- constant translation 
   #declare Way = V_0*Time; 
 #end
 #if (( Time >= Time_A ) & ( Time < Time_B ))  // constant translation + acceleration 
   #declare Way = Acceleration/2*pow(Time - Time_A,2) + V_0*(Time - Time_A)  + Way1; 
 #end 
 #if ( Time >= Time_B ) // ---------------------- way with constant speed after end of acceleration 
   #declare Way = Speed_End*( Time - Time_B)  + Way2; 
 #end                                                             
//-------------------------------------------------------------------------------------------------- 
#declare Rs = 0.75; // radius of the sphere --- le rayon de la sphère  
//-------------------------------------------------------------------------------------------------- 


union{ //-------------------------------------------------------------------------------------------
  // marker points 
  sphere{ <0,0,0>,0.1 pigment{ Red } translate <0,0, 0 > } 
  sphere{ <0,0,0>,0.1 pigment{ Red } translate <0,0,Way1 > } 
  sphere{ <0,0,0>,0.1 pigment{ Red } translate <0,0,Way2 > } 
  sphere{ <0,0,0>,0.1 pigment{ Orange } translate <0,0,Way3 > } 
  // -----------------------------------------------------------
 

  // the rolling sphere;  --- la sphère roulante:
  object{ Z_Sphere( Rs, Way ) translate<0,0, Way>}
                                                 
 rotate<0,0,0> translate<3,0.00,-1.70 >
}// end of union -----------------------------------------------------------------------------------
