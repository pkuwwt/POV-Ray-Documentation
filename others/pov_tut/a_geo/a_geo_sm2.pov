// POV-Ray 3.7 Scene File "a_geo_sm2.pov"
// Author: Friedrich A. Lohmueller, 2005/2009/2011

// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://wwww.f-lohmueller.de
//
//------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
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
#declare Camera_0 = camera {                                 // xy-view
                             angle 20
                             location  <0.0 , 0.0 ,-38.0>
                             right     x*image_width/image_height
                             look_at   <0.0 , 0.0 , 0.0>
                           }

#declare Camera_1 = camera {                                // diagonal view
                             angle 18
                             location  <20.0 , 20.5 ,-20.0>
                             right     x*image_width/image_height
                             look_at   <0.5 , 0.7 , 0.0>
                           }
#declare Camera_2 = camera {                               // yz-view
                             angle 20
                             location  <31.0 , 7.0 ,1.0>
                             right     x*image_width/image_height
                             look_at   <1.5 , 1.4 , 1.0>
                           }
#declare Camera_3 = camera {
                             angle 20
                             location  < 0.0 , 37.5 ,-0.0001>
                             right     x*image_width/image_height
                             look_at   <0 , 0 , 2.0>
                           }

camera{Camera_1}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<1,1,1>]//~Navy
                                [0.6 color rgb<1,1,1>]//<0.14,0.14,0.56>]//~Navy
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
                               pigment{color rgb<1,0.25,0>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }
#declare Texture_A_Light = texture {
                               pigment{color rgb<1,1,1>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }

object{ AxisXYZ( 6.0, 4.0, 6.0, Texture_A_Dark, Texture_A_Light)} // <<<<<<<<<<<<<<<<< adapt the axes here !!!
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 1.0/2;
#declare RasterHalfLine  = 0.035/2;
#declare RasterHalfLineZ = 0.035/2;
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


plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color rgbt<1,1,1,0.7>*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
        no_shadow
      }
//------------------------------------------------ end of squered plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------

#default{ finish {ambient 0.15 diffuse 0.85} } // 

/* Some Sample rgb colors - Einige Beispiele f�r rgb Farben
                          - Qualche esempio per colori rgb     
//===========================================================================
               pigment { color Green } 
Black  rgb<0,0,0>  ;  Gray  rgb<1,1,1>*0.5 ; White rgb<1,1,1> ; 
Red    rgb<1,0,0>  ;  Green rgb<0,1,0>     ; Blue rgb<0,0,1>  ;  Yellow rgb<1,1,0> ;
Orange rgb<1,0.5,0>;  Cyan rgb<0,1,1>      ; Magenta<1,0,1,>  ;
orange yellow  rgba<1,0.65,0> ;  YellowGreen rgb<0.5,1,0> ; 
Dark Red rgb<0.5,0,0> ; dark green rgb<0,0.5,0> ; dark blue rgb<0,0,0.5>

transparent colors - halbtransparente Farben - colori semi trasparenti: 
Red  semi transparent:          
                pigment{ color Red transmit 0.5 } = pigment { color rgbt<1,0,0,0.5>}
*/


//---------------------------------------- Radien der Geraden und Pfeile
#declare Rl  = 0.050; // radius of lines  - Radius der Strecken
#declare Rp  = 0.100; // radius of points - Radius der Punkte
//

//----------------------------------------------------------- macro "Vector(...)"!
#include "analytical_g.inc"


// --------------------------------------------------------------
// Points and Vectors  -  Punti e Vettori  -  Punkte und Vektoren

//--------------------------------------------------


// S und R vertauscht
#declare P  = < 1.5, 0.0,-4.0>;
#declare Q  = < 4.0, 1.0, 3.5>;
#declare S  = < 0.0, 1.5, 3.5>;
#declare R  = <-3.0, 4.0,-2.5>;

// --------------------------------------------------------------

// ------------------------------------------- Zeichnen ---------
// ------------------------------------------- Drawing ----------

sphere{ P, Rp  pigment{ color Red } }
        // Wire_Box(A, B, WireRadius, UseMerge)
object{ Wire_Box( o, P, Rl/2 , 0) pigment{ color Yellow } }
//object{ Y_( P, Rl/2) pigment{ color Yellow } }



sphere{ Q, Rp  pigment{ color Red } }
object{ Show_Yxz( Q, Rl/2) pigment{ color Yellow } }

sphere{ R, Rp  pigment{ color Red } }
object{ Show_Yxz( R, Rl/2) pigment{ color Yellow } }

sphere{ S, Rp  pigment{ color Red } }
object{ Show_Yxz( S, Rl/2) pigment{ color Yellow } }






object{ Vector( o,Q, Rl) pigment{ color rgb<0.6,1,0> } }
object{ Vector( o,R, Rl) pigment{ color rgb<0.6,1,0> } }
object{ Vector( o,P, Rl) pigment{ color rgb<0.6,1,0> } }
object{ Vector( o,S, Rl) pigment{ color rgb<0.6,1,0> } }

text { ttf "arial.ttf", "P",0.1,0
       scale 0.5 rotate<20,-40,0> translate P+<-0.1,0.0,-0.6> pigment{ color Red } }

text { ttf "arial.ttf", "Q",0.1,0
       scale 0.5 rotate<20,-40,0> translate Q+<-0.2,0.3,0> pigment{ color Red } }

text { ttf "arial.ttf", "R",0.1,0
       scale 0.5 rotate<20,-40,0> translate R+<-0.2,0.3,0> pigment{ color Red } }

text { ttf "arial.ttf", "S",0.1,0
       scale 0.5 rotate<20,-40,0> translate S+<-0.4,0.1,0> pigment{ color Red } }


object{ Vector( P,Q, Rl) pigment{ color Orange } }
object{ Vector( Q,R, Rl) pigment{ color Orange } }
object{ Vector( R,S, Rl) pigment{ color Orange } }
object{ Vector( S,P, Rl) pigment{ color Orange } }

#declare M_PQ = (P+Q)/2;
#declare M_QR = (Q+R)/2;
#declare M_RS = (R+S)/2;
#declare M_SP = (S+P)/2;


object{ Vector( M_PQ,M_QR, Rl) pigment{ color Green } }
object{ Vector( M_SP,M_RS, Rl) pigment{ color Green } }
object{ Vector( M_PQ,M_SP, Rl) pigment{ color Green } }
object{ Vector( M_QR,M_RS, Rl) pigment{ color Green } }

sphere{ M_PQ,Rp pigment{ color Green*0.5 } }
sphere{ M_QR,Rp pigment{ color Green*0.5 } }
sphere{ M_RS,Rp pigment{ color Green*0.5 } }
sphere{ M_SP,Rp pigment{ color Green*0.5 } }

triangle { M_QR, M_PQ, M_SP  pigment{ color Green transmit 0.5 } }
triangle { M_QR, M_RS, M_SP  pigment{ color Green transmit 0.5 } }
