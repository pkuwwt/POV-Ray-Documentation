// POV-Ray 3.7 Scene File "a_geo_pyramid_shadow01.pov"
// author: Friedrich A. Lohmueller, March-2007/2009/2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://wwww.f-lohmueller.de
//
//------------------------------------------------------------------------
#version 3.7; 
global_settings{ assumed_gamma 1.0 } 
global_settings { max_trace_level 20 }//(1...256) [default = 5]

#default{ finish {ambient 0.15 diffuse 0.85} }  
//------------------------------------------------------------------------
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
//------------------------------------------------------------------------
#declare Camera_0_Position = <0.0 , 0.0 ,-40.0>;            
#declare Camera_0 = camera {                                 // xy-view
                             angle 20
                             location Camera_0_Position 
                             right     x*image_width/image_height
                             look_at   <0.0, 0.0 , 0.0>
                           }

#declare Camera_1_Position = <23.0 ,15.5 ,-55.0>;            
#declare Camera_1 = camera {                                // diagonal view
                             angle 15.5
                             location  Camera_1_Position
                             right     x*image_width/image_height
                             look_at   < -3.50 ,1 ,-0.2>
                           }
#declare Camera_2_Position = <27.0 ,25.5 ,-55.0>;            
#declare Camera_2 = camera {                                // diagonal view
                             angle 14.4
                             location  Camera_2_Position
                             right     x*image_width/image_height
                             look_at   < -3.40 ,1 ,-0.2>
                           }

camera{Camera_2}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{ Camera_2_Position color White*0.3} // flash at camera
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//
                                [0.6 color rgb<0.14,0.14,0.56>]//<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//------------------------------------------------------------------------

//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
#macro Axis_( AxisLen, Dark_Texture,Light_Texture)
 union{
    cylinder { <0,-AxisLen-5,0>,<0,AxisLen,0>,0.05
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
           scale 0.5 translate <-0.55,AxisLenY+0.20,-0.10>}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.55,0.1,AxisLenZ+0.10>}
#end // of #if
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{color rgb<1,0.55,0>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }
#declare Texture_A_Light = texture {
                               pigment{color rgb<1,1,1>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }

object{ AxisXYZ( 5 , 5.5, 7.5, Texture_A_Dark, Texture_A_Light)} // <<<<<<<<<<<<<<<<< adapt the axes here !!!
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 1.0/2;
#declare RasterHalfLine  = 0.035;
#declare RasterHalfLineZ = 0.035;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,1>*0.2]
                          [0+HLine color rgbt<1,1,1,1>*0.2]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>*0.2]
                          [1.000   color rgbt<1,1,1,1>*0.2]} }
       finish { ambient 0.15 diffuse 0.85}
 #end// of Raster(RScale, HLine)-macro
//-------------------------------------------------------------------------

box { <-9.00, 0.00, -7.00>,< 4.00, 0.001, 4.00>   
//plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color rgbt<1,1,1,0.2>*1.2}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
        no_shadow
      }
 
//------------------------------------------------ end of squered plane XZ



//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------











//-----------------------------------------------------------------------------------
#declare Rl  = 0.055; // radius of lines  - Radius der Strecken
#declare Rp  = 0.105; // radius of points - Radius der Punkte
//------------------------------------------------------------------------------------
#include "analytical_g.inc"
//------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

// -----------------------------------------------------------------------------------
// ---------------------  Punti e Vettori  - Punkte und Vektoren -  Points and Vectors
//------------------------------------------------------------------------------------
#declare R  = 6 ; 
#declare S  = < 0.0, 4.0, 0.0>;
#declare A  = <-R/2, 0.0, R/2>;
#declare B  = <-R/2, 0.0,-R/2>;
#declare C  = < R/2, 0.0,-R/2>;
#declare D  = < R/2, 0.0, R/2>;

#declare L  = <-2, -1 ,-1.5 >; 
// F = Spurpunkt des Lichtstrahl durch S:  
#declare F  = S-(S.y/L.y)*L ;


//------------------------------------------------------------------------------------
// --------------------------------------------------------------- Zeichnen ----------
// ---------------------------------------------------------------- Drawing ----------
sphere{ S, Rp    pigment{ color Red*1.2 } } // top of pyramid

sphere{ A, Rp    pigment{ color Green*0.5 } }
sphere{ B, Rp    pigment{ color Green*0.5 } }
sphere{ C, Rp    pigment{ color Green*0.5 } }
sphere{ D, Rp    pigment{ color Green*0.5 } }


// corners 
 object{ Vector( S,A, Rl) pigment{ color rgb<0.6,1,0> }  }
 object{ Vector( S,B, Rl) pigment{ color rgb<0.6,1,0> }  }
 object{ Vector( S,C, Rl) pigment{ color rgb<0.6,1,0> }  }
 object{ Vector( S,D, Rl) pigment{ color rgb<0.6,1,0> }  }

// triangles  
 triangle { A, B, S       pigment{ color YellowGreen transmit  0.75 }}
 triangle { B, C, S       pigment{ color YellowGreen transmit  0.75 }}
 triangle { C, D, S       pigment{ color YellowGreen transmit  0.75 }}
 triangle { D, A, S       pigment{ color YellowGreen transmit  0.75 }}
// base lines
 cylinder{ A, B, 0.025  pigment{ color Green*0.35 } }
 cylinder{ B, C, 0.025  pigment{ color Green*0.35 } }
 cylinder{ C, D, 0.025  pigment{ color Green*0.35 } }
 cylinder{ D, A, 0.025  pigment{ color Green*0.35 } }

//------------------------------------------------------------------- Captions - Beschriftung
#declare Rotate = < 5, -15, 0> ;  
//-------------------------------
text { ttf "arial.ttf", "S",0.1,0
       scale 0.5 rotate Rotate translate S+<-0.35,0.2,-0.2> pigment{ color Red*1.5 } no_shadow}


text { ttf "arial.ttf", "A",0.1,0
       scale 0.5 rotate Rotate translate A+<-0.35,0.1,-0.2> pigment{ color Green*0.5 } no_shadow }
text { ttf "arial.ttf", "B",0.1,0
       scale 0.5 rotate Rotate translate B+<-0.3,0.1,-0.2> pigment{ color Green*0.5 } no_shadow }
text { ttf "arial.ttf", "C",0.1,0
       scale 0.5 rotate Rotate translate C+< 0.40,0.1,-0.2> pigment{ color Green*0.5 } no_shadow }
text { ttf "arial.ttf", "D",0.1,0
       scale 0.5 rotate Rotate translate D+< 0.3,0.1,-0.2> pigment{ color Green*0.5 } no_shadow }
 
//------------------------------------------------------------------------------------
text { ttf "arial.ttf", "F",0.1,0
       scale 0.5 rotate Rotate translate F+<-0.1,0.1,-0.2> pigment{ color Orange*1.4 } no_shadow }

//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
// straight line - Gerade  
cylinder{ S-10*(L), S+10*(L), 0.03 pigment{ color Yellow*1.1 }}

// Light_Vector L  at top S 
object{ Vector( S,S+L, Rl)  texture{pigment{ color rgb<1,0.4,0> } finish{ambient 0.5}} }
//------------------------------------------------------------------------------------
// light beam through S 
light_source{S-50*(L) color White*0.9 }  // sun

// F = Spurpunkt des Lichtstrahl durch S 
sphere{ F , 0.1 texture{ pigment{ color rgb<1,0.2,0> } finish{ambient 0.8}} no_shadow }
// show F 
object{ Show_Yxz( F, 0.05) texture{ pigment{ color rgb<0.7,0.3,1>*0.5} finish{ambient 0.8}} no_shadow }

//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------

