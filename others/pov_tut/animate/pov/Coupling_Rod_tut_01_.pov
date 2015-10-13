// POV-Ray 3.6/3.7 Scene File "Coupling_Rod_tut_01.pov"
// author: Friedrich A. Lohmueller, Aug-2012
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
//-------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = <-0.6, 0.7, -6.80> ;  // front view
  #declare Camera_Look_At  = <-0.6, 0.7,  0.00> ;
  #declare Camera_Angle    =  26 ;
#break
#case (1)
  #declare Camera_Position = < 4.00, 2.33, -4.00> ;  // diagonal view
  #declare Camera_Look_At  = <-0.85, 0.55,  0.20> ;
  #declare Camera_Angle    = 30.4 ;
#break
#case (2)
  #declare Camera_Position = < 7.00, 0.70,-0.95> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 0.70, 0.001> ;
  #declare Camera_Angle    = 27  ;
#break
#case (3)
  #declare Camera_Position = <-0.80, 8.00,  0.00> ;  // top view
  #declare Camera_Look_At  = <-0.50, 0.00, 0.001> ;
  #declare Camera_Angle    =   45 ;
#break
#else
  #declare Camera_Position = <-0.6, 0.7, -6.80> ;  // front view
  #declare Camera_Look_At  = <-0.6, 0.7,  0.00> ;
  #declare Camera_Angle    =  26 ;
#break
#end // of "#switch ( Camera_Number )" ----------------------------- animated camera is at the end of this file !!!!
//---------------------------------------------------------------------
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1000,2500,-500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ color rgb<1,1,1> } /*gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
*/
           } // end of sky_sphere
//------------------------------------------------------------------------
/*
fog{ fog_type   2
     distance   30
     color      White *0.8 
     fog_offset 0.1
     fog_alt    1.0
     turbulence 1.8
   } //----------------
*/
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
#declare RasterHalfLine  = 0.015;
#declare RasterHalfLineZ = 0.015;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.8]
                          [0+HLine color rgbt<1,1,1,0>*0.8]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.8]
                          [1.000   color rgbt<1,1,1,0>*0.8]} }
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------

 
plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.7}
                  finish {ambient 0.45 diffuse 0.85}}
       // texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
       // texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
    //    rotate<90,0,0> 
 // translate<0.00,0.00,-0.20>
      }
 
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//----------------------------------------------------------------------------- basic values and dimensions
#local Gauge_ = 1.435; // 
#local Wheel_R = 1.00/2; // Wheel radius
#local Con_R = 0.20; // conjunction radius
#local Conjunction_Len = 1.20;
       // conjunction length = axis distance


#local Time = clock + 0.125; 
#local Wheel_Angle =  -360*1*Time ; 
#local Wheel_Circ = 2*pi*Wheel_R ; // wheel circumference
#local Wheel_Move = Wheel_Circ *Wheel_Angle/360; 


#local Con_Y = Con_R * sin( radians( Wheel_Angle)) ; 
#local Con_X = Con_R * cos( radians( Wheel_Angle)) ; 


//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------- optional textures --//
#declare Wheel_Metal_1   = texture{ pigment{ color rgb<1,1,1>*0.65} finish {phong 1 reflection{ 0.2 metallic}} }
#declare Wheel_Metal_2   = texture{ pigment{ rgb<1,1,1>*0.25 quick_color White} finish {phong 1 reflection{ 0.0 metallic}}} 
#declare Wheel_Texture_1 = texture{ pigment{ color rgb<1,0.95,0.90>*0.080} normal{ bumps 0.125 scale 0.085}  finish{ phong 0.1 reflection{ 0.0 metallic} }}
#declare Wheel_Texture_2 = texture{ pigment{ color rgb<0.9,0.97,0.95>*0.15} normal{ bumps 0.15 scale 0.0125} finish{ phong 0.1 reflection{ 0.0 metallic} }} 
//-------------------------------------------------------------------------------------//
#include "RW_System/RW_Axis_11.inc" 
//-------------------------------------------------------------------------------------// 
#local Axis = 
object{ RW_Axis_11(   2*Wheel_R, // Wheel_Diameter___, // in meter
                      12,   // Number_Of_Spokes___, // 
                      0.20, // Connector_Radius___ // 0 or >wheel diameter/2 = non
                            // must be between:  < 0 and <  wheel radius                    
                      0.12, // Counterweight_Depth___, //  0 = non,  < wheel radius    
                      Gauge_, // gauge in meter
                  ) //-----------------------------------------------------------------//
        rotate<0,0,Wheel_Angle> 
        translate<0.00,0.00, 0.00>
      } // end union Axis -------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------- optional textures --//
#declare Rod_Metal_1 =   texture{ pigment{ color rgb<1,1,1>*0.05} finish {phong 1 reflection{ 0.2 metallic}} }
#declare Rod_Metal_2 =   texture{ pigment{ rgb<1,1,1>*0.5}  finish {phong 1 reflection{ 0.2 metallic}}} 
#declare Rod_Texture_1 = texture{ pigment{ color rgb<1,0.95,0.90>*0.90} normal{ bumps 0.125 scale 0.085} finish{ phong 0.2 reflection{ 0.2 metallic} }}
//-------------------------------------------------------------------------------------//
#include "RW_System/RW_Coupling_Rod_00.inc" 
//-------------------------------------------------------------------------------------//  
#declare Coupling_Rod = 
union{ 
 object{ RW_Coupling_Rod_00( Conjunction_Len, // coupling rod length in x+ from link to link                               
                                   0.12, // height in y+/- of rod
                                   0.06, // depth in -z // 
                                   0.09, // radius of the end links, >Rod_H/2 !!! 
                                   1,    // Oil_Fillers_On // 0 = non, 1= On 
                                 ) //--------------------------------------------------//
        scale <-1,1,1>*1
       } 
 // coupling rod axes
 cylinder{<0,0,-0.05>,<0,0, 0.05>,0.03 texture{ Rod_Metal_1} } 
 cylinder{<0,0,-0.05>,<0,0, 0.05>,0.03 texture{ Rod_Metal_1} 
                              translate<-Conjunction_Len,0,0>} 
} // end union Coupling_Rod
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------- optional textures --//
#declare Tietex1    = texture{ pigment{ color DarkWood*0.95 quick_color Tan}
                               normal { bumps 0.5 scale 0.005 scale<1,2,10>}
                               finish { diffuse 0.85}}
#declare Tietex2    = texture{ pigment{ color DarkWood quick_color Tan}
                               normal { bumps 0.55 scale 0.005 scale<1,1,10>}
                               finish { diffuse 0.88}}
#declare Tietex3    = texture{ pigment{ color DarkWood*0.9 quick_color DarkTan}
                               normal { bumps 0.75 scale 0.005 scale<1,1,10>}}
//-------------------------------------------------------------------------------------//
#include "RT_System/RT_Track_Straight_00.inc"  // straight track in x
//-------------------------------------------------------------------------------------// 
#declare Rail_Spikes_On = 1; // optional, default = 0, 
//#declare Straight = 
#declare Track = 
object{ RT_Track_Straight_00( Wheel_Circ , // track length ,  // in x+ in meter
                               1.75 , // number of ties per meter,  ~1.5
                  ) }//----------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
  

//-------------------------------------------------------------------------------------// '2 axes + connecting rods'
union{ // ---- 2 axes with connecting rods
  object{ Axis translate<-Conjunction_Len,0,0>}
  object{ Axis translate<               0,0,0>} 

  object{ Coupling_Rod translate<+Con_X,+Con_Y,-Gauge_/2-0.12>}
  object{ Coupling_Rod scale<1,1,-1>                                                  

                       translate<-Con_X,-Con_Y,+Gauge_/2+0.12>}

translate<0,Wheel_R,0>//   
translate<-Wheel_Move,0,0>// // move it by clock     
translate<0,Height_Rail_Top,0>// // lift it to rail top    
  //  "Height_Rail_Top" is declared by calling the "RT_Track_Straight_00.inc" file ! 

} // end of union '2 axes + connecting rods'
//-------------------------------------------------------------------------------------// 'adding rail tracks'  
union{ // ----- adding the rail tracks:   
 #local Nr = -3;     // start
 #local EndNr = 4; // end
 #while (Nr< EndNr) 

   object{ Track translate<Nr*Wheel_Circ , 0,0 >} 

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 
} // end of union 'adding rail tracks'
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------// animated 'camera'

// animated 'camera': 

#declare Camera_Position = Camera_Position+<-Wheel_Move,0,0>; 
#declare Camera_Look_At =  Camera_Look_At +<-Wheel_Move,0,0>; 
//-----------------------------------------------------------
camera{ location Camera_Position 
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At 
      }
//-----------------------------------------------------------
//-----------------------------------------------------------


//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
