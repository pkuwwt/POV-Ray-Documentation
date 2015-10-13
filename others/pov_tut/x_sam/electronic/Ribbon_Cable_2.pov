// POV-Ray 3.6 / 3.7 Scene File "Ribbon_Cable_2.pov"
// author: Friedrich A. Lohmueller, Sept-2009/Jan-2011
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
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#case (1)
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = <20.00, 20.00,-17.00> ;  // front view
  #declare Camera_Look_At  = < 6.50, 2.00,  7.00> ;
  #declare Camera_Angle    =  43 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#case (2)
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 7.00, 33.00,-8.00> ;  // front view
  #declare Camera_Look_At  = < 3.00, 1.00, 11.50> ;
  #declare Camera_Angle    =  60 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#else
  #declare Ultra_Wide_Angle_On = 0;// don't use fish eye - for proper text
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
  #declare Camera_Rotate = <0,0,0>; // tilling of the camera!!
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
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
          scale 0.5 translate <AxisLenX+0.05,0.5,-0.10>}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
           scale 0.5 translate <-0.45,AxisLenY+0.50,-0.10>}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.75 translate <-0.75,0.2,AxisLenZ+0.10>}
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

object{ AxisXYZ(  6, 5, 18, Texture_A_Dark, Texture_A_Light) scale 2}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.03;
#declare RasterHalfLineZ = 0.03;
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

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

#declare Color_Type = 1 ;// 0 = gray with pin1=red, 1 = rainbow ribbon cable
#declare Number_of_Ways = 10;
#declare Wire_R = 0.30 ; // radius of cable + insulation
#declare Distance_of_Ways = 1.27/2; // 0.025  inch



// ---------------------------------------------------------------------
#declare Ribbon_Spline = // avoid any vertical parts
  spline {
    natural_spline
   -0.25, < 0.0,-5, -1>,
    0.00, < 0.0, 0.0, 0>,
    0.25, < 0.0, 5.0, 4>,
    0.50, < 1.5, 6.0,12>,
    0.75, < 8.0, 4.0,18.0>,
    1.00, <15.0, 5.0,20>,
    1.25, <20.0, 5.0,19.4>
  }
// --------------------------------------------------------------------- textures
#ifndef ( Cable_Base_Texture )
#declare  Cable_Base_Texture =
         texture{ pigment{ color rgb <1,1,1>*0.5}
                  finish { phong 0.3}
                }
#end //------------------------------------------

//------------------------------------------------------------------------------
// rainbow ribbon cable "hippie cable":
// Brown is pin 1 or pin 11 or pin 21, etc. Red is pin 2 or pin 12 or pin 22, etc
#macro Cable_Color ( Color_Number )
 #switch( Color_Number )
 #case(1)  color rgb< 0.30,0.12,0.08> #break // brown
 #case(2)  color rgb <0.60,0.00,0.00> #break // red
 #case(3)  color rgb <0.70,0.35,0.00> #break // orange
 #case(4)  color rgb <0.80,0.70,0.00> #break // yellow
 #case(5)  color rgb <0.00,0.50,0.00> #break // green
 #case(6)  color rgb <0.00,0.10,0.80> #break // blue
 #case(7)  color rgb <0.20,0.00,0.60> #break // violet
 #case(8)  color rgb <0.25,0.25,0.25> #break // grey
 #case(9)  color rgb <0.70,0.70,0.70> #break // white
 #case(10) color rgb <0.00,0.00,0.00> #break // black

 #else     color rgb <1,1,1>*0.45 #break// light grey
 #end // end of switch
#end // end of macro Cable_Color( Color_Number )
//---------------------------------------------------------------


//---------------------------------------------------------------
#declare Ribbon_Silhuette =  // in z-direction
union{ // ------------------------------------------------
 #local Nr = 0;
 #local EndNr = Number_of_Ways;
 #while ( Nr < EndNr )
 sphere{ <0,0,0>,Wire_R
         #if ( Color_Type = 0 )
            #if (Nr = 0)
              texture{ pigment{ Cable_Color( 2 )}
                       finish { phong 1 reflection 0.05}
                     }
            #else
              texture{ pigment{ Cable_Color( 0 )}
                       finish { phong 1 reflection 0.05}
                     }
            #end
         #end

         #if ( Color_Type = 1 )
         texture{ pigment{ Cable_Color( mod((Nr),10)+1 )}
                  finish { phong 1 reflection 0.05}
                }
         #end

         translate<Nr*Distance_of_Ways,0,0>
       } // ----------------------------------------------
 #local Nr = Nr + 1;
 #end // of loop
 cylinder{ <0,0,0>,<(Number_of_Ways-1)*Distance_of_Ways,0,0>,Wire_R/2
           texture{ Cable_Base_Texture }
         } // ----------------------------------------------
translate<-0.5*(Number_of_Ways-1)*Distance_of_Ways,0,0>
} // end of union  ----------------------------------------------

//---------------------------------------------------------------
// Don't forget, if not included before!
//#include "transforms.inc"  // for Spline_Trans macro by Rune S. Johansen.
//---------------------------------------------------------------
union{
 #local Nr = 0;     // start
 #local EndNr = 1; // end
 #while (Nr <=  EndNr)

 object {Ribbon_Silhuette
         Spline_Trans( Ribbon_Spline, // SplineName,
                       Nr,            // TimeValue,
                       y,             // Upwards,
                       0.05,          // ForeSight,
                       0.70           // Banking
                      )
        } // end of object





 #local Nr = Nr + 0.001;  // next Nr
 #end // --------------- end of loop

rotate<0,0,0>
translate<0,0.0,0>
} // end of union  ----------------------------------------

// markers
// start
sphere { <0,0,0>,0.25 pigment{ rgb<0.5,1,0>}}
// end
cylinder{<0,0,0>,<0,5,0>,0.25 translate <15, 0,20> pigment{ rgb<0.5,1,0>}}