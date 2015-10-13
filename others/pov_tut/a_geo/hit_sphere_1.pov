// PoVRay 3.7 Scene File "hit_sphere_1.pov"
// created by Friedrich A. Lohmueller, 2005/2009/2011

// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
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
//--------------------------------------------------------------------------
//------------------------------------------------------------------------
#declare Camera_0 = camera {                                 // xy view
                             angle 20
                             location  <0.0 , 0.0 ,-40.0>
                             right     x*image_width/image_height
                             look_at   <0.0, 0.0 , 0.0>
                           }

#declare Camera_1 = camera {                                // diagonal view
                             angle 10
                             location  <40.0 ,40.5 ,-40.0>
                             right     x*image_width/image_height
                             look_at   <0.3 , 1.5 ,-0.5>
                           }
#declare Camera_2 = camera {                               // yz view
                             angle 20
                             location  <31.0 , 7.0 ,1.0>
                             right     x*image_width/image_height
                             look_at   <1.5 , 1.4 , 1.0>
                           }
#declare Camera_3 = camera {                               // top view
                             angle 20
                             location  < 0.0 , 37.5 ,-0.0001>
                             right     x*image_width/image_height
                             look_at   <0 , 0 , 2.0>
                           }

camera{Camera_1}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<500,1500,-1500> color White}
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
    cylinder { <0,-AxisLen-3,0>,<0,AxisLen,0>,0.05
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
                               pigment{color rgb<1,0.35,0>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }
#declare Texture_A_Light = texture {
                               pigment{color rgb<1,1,1>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }

object{ AxisXYZ( 6.0, 4.5, 7.0, Texture_A_Dark, Texture_A_Light)} // <<<<<<<<<<<<<<<<< adapt the axes here !!!
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

#declare A  = <-2.0, 2,-3.0>;
#declare B  = < 3.0, 2, 3.0>;


// Sphere:
#declare M  = < -1, 2.0, 0.0>;
#declare Radius = 1.5 ;


//------------------------------------------------------------------------------------
// --------------------------------------------------------------- Zeichnen ----------
// ---------------------------------------------------------------- Drawing ----------

// the point A
sphere{ A, Rp              pigment{ color Green*0.5 }}
object{ Show_Yxz( A, Rl/2) pigment{ color Yellow }}
text  { ttf "arial.ttf",
        concat( "A = (",
           vstr(3, A, "/", 0, 1),
          ")"
         ),0.1,0
        scale 0.4 rotate<20,-45,0>
        translate A+<-1.3,0.3,-1.2> pigment{ color Green*0.5 } no_shadow}

// the point B
sphere{ B, Rp              pigment{ color Green*0.5 }}
object{ Show_Yxz( B, Rl/2) pigment{ color Yellow }}
text  { ttf "arial.ttf",
        concat( "B = (",
           vstr(3, B, "/", 0, 1),
          ")"
         ),0.1,0
        scale 0.4 rotate<20,-45,0>

        translate B+< 0.0, 0.3,-2.0> pigment{ color Green*0.5 } no_shadow }

//-------------------------------------------------------------------------------------

// vector AB
object{ Vector( A,B, Rl) pigment{ color Green }}

// Gerade - straight line AB
cylinder{ A-10*(B-A), B+10*(B-A), Rl/2 pigment{ color Green*0.5}}

//------------------------------------------------------------------------------------
// the point M
sphere{ M, Rp  pigment{ color Orange } }
object{ Show_Yxz( M, Rl/2) pigment{ color Yellow }}
text  { ttf "arial.ttf",
        concat( "M = (",
           vstr(3, M, "/", 0, 0),
          ")"
         ),0.1,0
        scale 0.4 rotate<20,-45,0>
        translate M+< 0.8,2.4,-2.75>  pigment{ color Green*0.5 } no_shadow }
// Radius r
text  { ttf "arial.ttf",
        concat( "  r = ",
            str(Radius, 0, 2)
         ),0.1,0
        scale 0.4 rotate<20,-45,0>
        translate M+< 0.8,1.9,-2.75>  pigment{ color Green*0.5 } no_shadow }

// Sphere
#declare Sphere_1 =
sphere{ o, Radius
        translate M
        pigment{ color Green transmit 0.4 } finish {phong 1}}


object{ Sphere_1}

//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------


// prepare a vector to store in the normal vector
#declare Hit_Normal = <0,0,0>;


// point of intersection and normal vector at the point of intersection
// Schnittpunkt und Normalenvektor
#declare Hit_the_Object =  trace ( Sphere_1, A, B-A, Hit_Normal );

// if trace ( Objcect, ...) does find No point of intersection
// the normal vector (here: Hit_Normal) is <0,0,0> !!!!

// point of intersection:
 sphere{ Hit_the_Object, Rp  pigment{ color Red } }  // shows the point of intersection
 object{ Show_Yxz( B, Rl/2)  pigment{ color Yellow }} // shows relative position
 text{ ttf "ARIAL.TTF"
       concat( "S1=(",
               vstr(3, Hit_the_Object, "/", 0, 1),
               ")"
             ),0.1,0
       scale 0.45 rotate<20,-45,0>
       translate   <0.6,1,-7.2>
       pigment{ color Red }  no_shadow }


// normal vector at the point of intersection (twice as long for better view!)
object{ Vector( Hit_the_Object, Hit_the_Object + 2*Hit_Normal, Rl)
        pigment{ color Magenta*0.5 }}

text{ ttf "ARIAL.TTF"
  concat( "N1 = <",
           vstr(3, 2*Hit_Normal, "/", 0, 1),
          ">"
         ),0.1,0
  scale 0.40 rotate<20,-45,0>
  translate   <0.6,0.5,-7.2>
  pigment{ color Magenta*0.5 }  no_shadow }

// the angle between line and plane - calculated with the normal vector
text{ ttf "ARIAL.TTF"
  concat( "angel1 = ",
           str(90 - VAngleD(B-A, Hit_Normal), 0, 1),
           " degrees"
         ),0.1,0
  scale 0.40 rotate<20,-45,0>
  translate   <0.6,0.0,-7.2>
  pigment{ color Magenta*0.5 }  no_shadow }

//-------------------------------------------------------------------------------
//-------------------------------------------------------------- 2nd intersection
//-------------------------------------------------------------------------------

#declare Hit_Normal2 = <0,0,0>; // prepare a vector to store in the normal vector
#declare Hit_the_Object2 =  trace ( Sphere_1, B, A-B, Hit_Normal2 );

// point 2 of intersection:
 sphere{ Hit_the_Object2, Rp  pigment{ color Red } } // shows the point of intersection
 object{ Show_Yxz( B, Rl/2)   pigment{ color Yellow }} // shows relative position
 text{ ttf "ARIAL.TTF"
       concat( "S2=(",
               vstr(3, Hit_the_Object2, "/", 0, 1),
               ")"
             ),0.1,0
       scale 0.45 rotate<20,-45,0>
  translate   <4,1.0,-3.8>
       pigment{ color Red }  no_shadow }

// normal vector at the point of intersection (twice as long for better view!)
object{ Vector( Hit_the_Object2, Hit_the_Object2 + 2*Hit_Normal2, Rl)
        pigment{ color Magenta*0.5 }}

text{ ttf "ARIAL.TTF"
  concat( "N2 = <",
           vstr(3, 2*Hit_Normal2, "/", 0, 1),
          ">"
         ),0.1,0
  scale 0.40 rotate<20,-45,0>
  translate   <4,0.5,-3.8>
  pigment{ color Magenta*0.5 }  no_shadow }

// the angle between line and plane - calculated with the normal vector
text{ ttf "ARIAL.TTF"
  concat( "angel2 = ",
           str(90 - VAngleD(A-B, Hit_Normal2), 0, 1),
           " degrees"
         ),0.1,0
  scale 0.40 rotate<20,-45,0>
  translate   <4,0.0,-3.8>
  pigment{ color Magenta*0.5 }  no_shadow }




//--------------------------------------------------------------------------- end

