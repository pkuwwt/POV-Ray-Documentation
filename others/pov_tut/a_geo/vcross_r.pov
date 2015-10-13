// POV-Ray 3.7 Scene File "vcross_r.pov"
// right handed coordinate system

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
#declare Camera_0 = camera {                                // xy view
                             angle 18
                             right    -x*image_width/image_height
                             sky <0,0,1>                                // right handed!!!!!!!!
                             location  <20.0, 20.0, 20.0>
                             look_at   <0.0, 0.0, 0.5>
                           }

#declare Camera_1 = camera {                                // diagonal view
                             angle 18
                             right    -x*image_width/image_height
                             sky <0,0,1>                                // right handed!!!!!!!!
                             location  <20.0, 20.0, 20.0>
                             look_at   <0.0, 0.0, 0.5>
                           }

camera{Camera_1}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500, 2500, 2500> color White}
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
          rotate< 0,90,-90> scale 0.5 translate <AxisLenX+0.05,-0.4, 0.40>}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
          rotate<90, 0,0>  scale 0.5 translate <-0.40,AxisLenY+0.20,0.50>}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<90,0,180>  scale 0.5 translate <-0.4,0.0,AxisLenZ+0.10>}
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

object{ AxisXYZ( 6.0, 6.0, 4.0, Texture_A_Dark, Texture_A_Light)} // <<<<<<<<<<<<<<<<< adapt the axes here !!!
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 1.0/2;
#declare RasterHalfLine  = 0.035;  
#declare RasterHalfLineZ = 0.035; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,1>*0.4]
                          [0+HLine color rgbt<1,1,1,1>*0.4]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>*0.4]
                          [1.000   color rgbt<1,1,1,1>*0.4]} }
       finish { ambient 0.15 diffuse 0.85}
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,0,1>, 0    // plane with layered textures
        texture { pigment{color rgbt<1,1,1,0.7>*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,0,90>}
        rotate<0,0,0>
        no_shadow
      }
//------------------------------------------------ end of squered plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
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


//-----------------------------------------------------------------------------------
#declare Rl  = 0.055; // radius of lines  - Radius der Strecken 
#declare Rp  = 0.105; // radius of points - Radius der Punkte 

// 
//------------------------------------------------------------------------------------
#include "analytical_g.inc" 
//------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------- 

// ----------------------------------------------------------------------------------- 
// ---------------------  Punti e Vettori  - Punkte und Vektoren -  Points and Vectors
//------------------------------------------------------------------------------------

#declare V1 =  < 0, 0, 2>;  
#declare V2 =  <-2.5,1, 1>;   

#declare Start  = < 5.0,4.5, 2.0>;
 
union{
sphere{ V1, Rp   pigment{ color Red }}
sphere{ V2, Rp   pigment{ color Orange }}

object{ Vector( o,V1, Rl) pigment{ color Red }}
object{ Vector( o,V2, Rl) pigment{ color Orange }}
object{ Vector( o,vcross(V1,V2), Rl)  pigment{ color YellowGreen }}

triangle{ o, V1, V2      pigment{ color Green transmit 0.5 }}
triangle{ V1, V1+V2, V2  pigment{ color Green transmit 0.5 }}

text { ttf "ARIAL.TTF", "V1",0.1,0 
       scale 0.4 scale <-1,-1,1> rotate<-90,0,-45> translate V1/2+< 0.9,0.0, 0.8> pigment{ color Red } no_shadow}

text { ttf "ARIAL.TTF", "V2",0.1,0 
       scale 0.4 scale <-1,-1,1> rotate<-90,0,-45> translate V2/2+< 0.1,0.0,-0.5> pigment{ color Orange } no_shadow}


text { ttf "ARIAL.TTF", "V1 x V2",0.1,0 
       scale 0.4 scale <-1,-1,1> rotate<-90,0,-45>  translate vcross(V1,V2)+< 0.7,-0.7,0.2>pigment{ color YellowGreen } no_shadow}

translate Start}

// ------------------------------------------------------------------------------------------------------- end
