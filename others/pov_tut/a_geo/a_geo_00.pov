// PoV-Ray 3.7 Scene File "a_geo_00.pov"
//
// author: Friedrich A. Lohmueller, 2005/2009/2011
/2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://wwww.f-lohmueller.de
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
                             look_at   <0.3 , 1.0 ,-0.5>
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
light_source{<2500,2500,-1500> color White}
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

object{ AxisXYZ( 6.0, 4.0, 7.0, Texture_A_Dark, Texture_A_Light)} // <<<<<<<<<<<<<<<<< adapt the axes here !!!
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 1.0 ;
#declare RasterHalfLine  = 0.045;
#declare RasterHalfLineZ = 0.045;
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine)
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,1>*0.6]
                          [0+HLine color rgbt<1,1,1,1>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>*0.6]
                          [1.000   color rgbt<1,1,1,1>*0.6]} }
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

// --------------------------------------------------------------- textures
#default{ finish {ambient 0.15 diffuse 0.85} } //


/* Some Sample rgb colors - Einige Beispiele f�r rgb Farben
                          - Qualche esempio per colori rgb
//===========================================================================
               pigment { color Green }
Black  rgb<0,0,0>  ;  Gray rgb<1,1,1>*0.5  ; White rgb<1,1,1> ;
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

#declare A  = < 4.0, 1.0,-3.0>;
#declare B  = <-3.0, 0.0,-4.0>;
#declare C  = < 2.0, 3.0, 3.5>;

#declare AB = B-A;
#declare AC = C-A;

#declare D = A + AB + AC;

//------------------------------------------------------------------------------------
// --------------------------------------------------------------- Zeichnen ----------
// ---------------------------------------------------------------- Drawing ----------
sphere{ A, Rp  pigment{ color Red } }
object{ Show_Yxz( A, Rl/2) pigment{ color Yellow }}
text  { ttf "arial.ttf", "A",0.1,0
        scale 0.5 rotate<20,-45,0> translate A+<-0.2,0.4,-0.2> pigment{ color Red} no_shadow}

sphere{ B, Rp  pigment{ color Red } }
object{ Show_Yxz( B, Rl/2) pigment{ color Yellow }}
text  { ttf "arial.ttf", "B",0.1,0
        scale 0.5 rotate<20,-45,0> translate B+<-0.2,0.3,-0.3> pigment{ color Red} no_shadow }

sphere{ C, Rp  pigment{ color Red } }
object{ Show_Yxz( C, Rl/2) pigment{ color Yellow }}
text  { ttf "arial.ttf", "C",0.1,0
        scale 0.5 rotate<20,-45,0> translate C+< 0.2,0.6,-0.3> pigment{ color Red} no_shadow }



//---------------------------------------------------------------------- vectors ------
// object{ Vector( o,A, Rl) pigment{ color Red }}

// object{ Vector( A,B, Rl) pigment{ color Green }}
// object{ Vector( A,C, Rl) pigment{ color Green }}


// cylinder { B, C,  Rl/2   pigment{ color Orange }}

// triangle { A, B, C       pigment{ color YellowGreen transmit 0.5 }}



//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------

/*
//------------------------------------------------------------------------------------ samples - Beispiele
// samples:  Macros from "analytical_g.inc"
//------------------------------------------------------------------------------------
//  Unambiguous marking of positions:
// xy projection of a Point A:
 sphere{ <A.x,A.y,0>, Rp pigment{ color Red*0.5 } }

 // 1) Wire_box-Method :
 object{ Wire_Box( o, P,Rl/2,0) pigment{ color Yellow }}

 // 2) Suporting cylinder in y direction:
 object{ Show_Y_( P, Rl/2) pigment{ color Yellow } }

 // 3) Suporting cylinder in y direction with projections of xz components:
 object{ Show_Yxz( P, Rl/2) pigment{ color Yellow } }

// vector
 object{ Vector( A,B, Rl) pigment{ color Green }}

// distance marker
 object{ Distance_Marker(P1, P2, Rl) pigment{ color Green}}

// straight line AB - Gerade AB
cylinder{ A-10*(B-A), B+10*(B-A), Rl*0.9 pigment{ color Green}}

// line BC
 cylinder { B, C,  Rl/2   pigment{ color Orange }}

// triangle ABC
 triangle { A, B, C       pigment{ color YellowGreen transmit 0.5> }}

// plane by Parameters:
 object{ Plane_Dir( Start, Dir1, Dir2, Start, End ) pigment{ color Green}}

// plane by normal representation, N=<A,B,C>, D: .....
 object{ Plane_Nor( Normal, D, Start, End) pigment{ color Green}}

// plane by normal representation, with normal vector N and a point P:
 object{ Plane_NoP( Normal, P, Start, End) pigment{ color Green}}

//------------------------------------------------------------------------------------
// point of intersection of straght line and plane
 // Line by i.e. start point and direction
 #declare P = <x1,x2,x3> #declare Dir = <d1,d2,d3>
 //  Plane declared as an object:
 #declare Plane = ...; s.o.
 #declare Point_of_intersection = trace ( Plane, A, Dir )
  // With normal vector in the point of intersection -
  // the name of the normal vector must be predeclared by:
 #declare Normal = <0,0,0>
 #declare Point_of_intersection = trace ( Plane, A, Dir, Normal)

//------------------------------------------------------------------------------------


// Circle (M,r) around axis:
 // Circle line: ...............
 object{ Circle_Line ( Center, Radius, Rl, Axis) pigment{ color Yellow }}
 // Circle area .............
 object{ Circle_Disc ( Center, Radius, Axis) pigment{ color Yellow transmit 0.5 }}
//Circum circle of a triangle P1P2P3:
 // Circle line: ...............
 object{ Circle_Line_out( P1, P2, P3, Rl) pigment{ color Yellow }}
 // Circle area .............
 object{ Circle_Disc_out( P1, P2, P3 ) pigment{ color Yellow transmit 0.5 }}
 // Circumcircle center.
 object{ Triangle_M_out( P1, P2, P3 ) pigment{ color Green }}
 // Circumcircle radius .........
 Triangle_R_out( P1, P2, P3 )
//Incircle of a triangle P1P2P3:
 // Circle line: ...............
 object{ Circle_Line_in ( P1, P2, P3, Rl) pigment{ color Yellow }}
 // Circle area .............
 object{ Circle_Disc_in ( P1, P2, P3 ) pigment{ color Yellow transmit 0.5 }}
 // Incircle center ..
 object{ Triangle_M_in ( P1, P2, P3 ) pigment{ color Green }}
  Incircle radius ...........   Triangle_R_in ( P1, P2, P3 )
// Incircle of a triangle P1P2P3:
 // Circle line: ...............
 object{ Circle_Line_in ( P1, P2, P3, Rl) pigment{ color Yellow }}
 //  Circle area .............
 object{ Circle_Disc_in ( P1, P2, P3 ) pigment{ color Yellow transmit 0.5 }}
 // Incircle center ..
 object{ Triangle_M_in ( P1, P2, P3 ) pigment{ color Green }}
 // Incircle radius ...........
 Triangle_R_in ( P1, P2, P3 )

// Tetrahedron
// Tetrahedron by edge vectors V1,V2,V3:
 object{ Tetrahedron_by_Edges ( V1,V2,V3, Rl,Rp, Filled) pigment{ color Green transmit 0.5}}
// Tetrahedron by corners P1P2P3P4: ....
 object{ Tetrahedron_by_Corners ( P0,P1,P2,P3, Rl,Rp, Filled) pigment{ color Green transmit 0.5}}

// Parallelepiped - box
// Parallelepiped by edge vectors V1,V2,V3:
 object{ Parallelepiped ( V1,V2,V3, Rl,Rp, Filled) pigment{ color Green transmit 0.5}}
// Parallelepiped by corners P1P2P3P4: ....
object{ Parallelepiped_P ( P0,P1,P2,P3, Rl,Rp, Filled) pigment{ color Green transmit 0.5}}

// sphere, ellipsoid, cylinder, cone:

// Sphere with center M and radius R:
 sphere { Center, R   pigment{ color White }
// Ellipsoid, center M, radii Rx,Ry,Rz:
 sphere { Center, R scale   pigment{ color Green transmit 0.5 }
// Cylinder, centers of the ends M1 and M2 and radius R:
 cylinder { M1,M1, R   pigment{ color Green transmit 0.5 }
// Cone with base center M1, base radius R1 and top at M2:
 cone { M1,R1, M2, 0   pigment{ color Green transmit 0.5 }
// Truncated cone, centers of the ends M1, M2 and radii R1 and R2:
  cone { M1,R1, M2, R2   pigment{ color Green transmit 0.5 }
*/
//-------------------------------------------------------------------------------- end samples

//-------------------------------------------------------------------------------- end