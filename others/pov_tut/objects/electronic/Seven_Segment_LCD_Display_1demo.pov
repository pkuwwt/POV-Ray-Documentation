// POV-Ray 3.6 / 3.7 Scene File "Seven_Segment_LCD_Display_1demo.pov"
// author: Friedrich A. Lohmueller, Aug-2009/Jan-2011
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
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 2 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 5.00,-50.00> ;    // front view
  #declare Camera_Look_At  = < 0.00, 5.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 35.00, 35.00,-35.00> ;  // diagonal view
  #declare Camera_Look_At  = < -1, 4.5, -1> ;
  #declare Camera_Angle    =  30 ;
#break
#case (2)
  #declare Camera_Position = < 35.00, 35.00,-35.00> ;  // diagonal view
  #declare Camera_Look_At  = < -1, 2.5, -1> ;
  #declare Camera_Angle    =  35 ;
#break
#else
  #declare Camera_Position = < 35.00, 35.00,-35.00> ;  // diagonal view
  #declare Camera_Look_At  = < -1, 4.5, -1> ;
  #declare Camera_Angle    =  30 ;
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
// sun -------------------------------------------------------------------
light_source{<  00,2500,-1500> color rgb<1,1,1>*0.9} // sun
light_source{ Camera_Position   color rgb<0.9,0.9,1>*0.1} // flash light
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
          rotate<30,-40,0> scale 0.75 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}
           rotate<30,-40,0> scale 0.75 translate <-0.75,AxisLenY-0.30,-0.10>}
#end // of #if
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
           rotate<30,-40,0>     scale 0.75 translate <-0.75,0.2,AxisLenZ+0.10>}
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

object{ AxisXYZ( 7.5, 7.0, 12, Texture_A_Dark, Texture_A_Light) scale 2}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 2.54; // 0.1 inch
#declare RasterHalfLine  = 0.035;
#declare RasterHalfLineZ = 0.035;
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
        texture { pigment{color White*0.45} }
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
        translate<0,-1,0>
      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



// -------------------------------------------------------------------------------------

//------------------------------------------------------------------------- optional textures
/*
#declare SSBase_Texture_1 = texture{ pigment{ color rgb<1,0.36,0.6>*1.2}} // outer sides
#declare SSBase_Texture_2 = texture{ pigment{ color rgb<1,1,1>*0.8}} // inner base
#declare SSBase_Texture_3 = texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.5 }} // inner top
#declare SSB_Text_Texture = texture{ pigment{ color rgb<0.2,0,0> }} // name + manufacturer
#declare Active_LEDs_Texture = texture{ pigment{ color rgb<1,0.1,0.3>*0.6 }} //
#declare Inactive_LEDs_Texture=texture{ pigment{ color rgb<1,0.60,0.84> }} //
#declare DisplaySkin_Texture = texture{SSBase_Texture_1}   //
*/
// ------------------------------------------------------------------------------------------------
#declare Socket_Font_  = "courbd.ttf"
// ------------------------------------------------------------------------------------------------
// ------------------------------------------------------------------------------------------------
#include "Seven_Segment_LCD_Display.inc"
// ------------------------------------------------------------------------------------------------
object{  Single_Digit_Seven_Segment_Display (
      // choose Display_Type:
         5, //  SSB_Type, //  0 ~ 7
// Types of single digit Seven-Segment LED Displays:
// Types of single digit Seven-Segment LED Displays:
// SSB_Type 0 :  7.5 x  14.0  x  8.4, Pin_Dir= 0;Pin_Row_Dist= 2; "UVS-360"    , Unity Opto Technology Display: (0.36 inch)   9.14 mm
// SSB_Type 1 :  9.7 x  12.8  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 2; "UVS-4301"   , Unity Opto Technology Display: (0.40 inch)   10.0 mm
// SSB_Type 2 :  9.6 x  13.0  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 3; "LA-401DN"   , ROHM                  Display: (0.40 inch)   10   mm
// SSB_Type 3 :  9.7 x  12.9  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 3; "LTS-4301"   , LITE-ON               Display: (0.40 inch)   10   mm

// SSB_Type 4 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "UVS-546"    , UNi                   Display: (0.52 inch)   13.2 mm
// SSB_Type 5 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "LTS-547 AP" , LITE-ON               Display: (0.52 inch)   13.2 mm
// SSB_Type 6 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "SA52-11EWA" , KINGBRIGHT            Display: (0.52 inch)   13.2 mm
// SSB_Type 7 : 12.7 x  19.0  x  8.3, Pin_Dir= 1;Pin_Row_Dist= 6; "SA56-11EWA" , KINGBRIGHT            Display: (0.56 inch)   14.2 mm

// SSB_Type 8 : 18.6 x  25.0  x 10.6, Pin_Dir= 0;Pin_Row_Dist= 6;  "SA08-21EWA", KINGBRIGHT             Display: (0.80 inch)  20.3 mm
// SSB_Type 9 : 22.5 x  27.7  x 10.5, Pin_Dir= 1;Pin_Row_Dist= 12; "KW1-1001", Lucky Light              Display: (1.00 inch)  25.4 mm
// SSB_Type 10: 24.0 x  33.0  x 10.5, Pin_Dir= 1;Pin_Row_Dist= 12; "KW1-1002", Lucky Light              Display: (1.00 inch)  25.4 mm

// SSB_Type 11: 28.8 x  40.8  x  9.0, Pin_Dir= 1;Pin_Row_Dist= 14; "KW1-1201", Lucky Light              Display: (1.20 inch)  30.4 mm
// SSB_Type 12: 30.6 x  44.1  x  8.0, Pin_Dir= 1;Pin_Row_Dist= 16; "KW1-1501", Lucky Light              Display: (1.50 inch)  38.1 mm
// SSB_Type 13: 90.0 x 122.0  x 15.0, Pin_Dir= 1;Pin_Row_Dist= 42;Raster=2*2.54;"SA40-19SRWA",KINGBRIGHT Display: (4.00 inch) 100   mm

         1, // SS_Text_On, // [ 0 = off, 1 = on ]
         Socket_Font_ , // = "courbd.ttf"

         6, // DisplayIntegerNumber_, // [0, ..., 9, + hexnumbers: 10=A,11=b, 12=C, 13=d, 14=E, 15=F, degrees: 16="�", minus="-"]
         0, // Point_On_,                   // [ 0 = off, 1 = on ]
         3, // ActiveLED_Texture_Number,    // [ 0 = white, 1 = red, 2 = orange, 3 = amber ,4 = yellow, 5 =green, 6 = blue, 7= violet]
         4, // InactiveLED_Texture_Number,  // [ 0 = dark gray, 1 = light gray, 2 = transparent1, 3 = transparent2, 4 = amber]
         0, // DisplaySkin_Texture_Number_, // [ 0 = near black, 1 = dark gray, 2 = medium gray, 3 = light gray ]

         0, // Segment_Type_,  // 0 = angular, 1 = curved //


         1, //  PackageView_0n, //  = 0 or 1 )
         0, //  FootPrint_On, //  = 0 or 1 )
       ) // ---------------------------------------------------------------------------------------------------
//  rotate< 0,0,90> rotate<0,15,0>
// translate< 2, 6.25, 0>

  translate< 0, 0, 0>


  translate< 0, 0.8, 0>
} //-------------------------------------------------------
//---------------------------------------------------------------------------------------


// -------------------------------------------------------------------------------------
object{  Single_Digit_Seven_Segment_Display (
      // choose Display_Type:
         5, //  SSB_Type, //  0 ~ 7
// Types of single digit Seven-Segment LED Displays:
// SSB_Type 0 :  7.5 x  14.0  x  8.4, Pin_Dir= 0;Pin_Row_Dist= 2; "UVS-360"    , Unity Opto Technology Display: (0.36 inch)   9.14 mm
// SSB_Type 1 :  9.7 x  12.8  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 2; "UVS-4301"   , Unity Opto Technology Display: (0.40 inch)   10.0 mm
// SSB_Type 2 :  9.6 x  13.0  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 3; "LA-401DN"   , ROHM                  Display: (0.40 inch)   10   mm
// SSB_Type 3 :  9.7 x  12.9  x  7.0, Pin_Dir= 0;Pin_Row_Dist= 3; "LTS-4301"   , LITE-ON               Display: (0.40 inch)   10   mm

// SSB_Type 4 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "UVS-546"    , UNi                   Display: (0.52 inch)   13.2 mm
// SSB_Type 5 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "LTS-547 AP" , LITE-ON               Display: (0.52 inch)   13.2 mm
// SSB_Type 6 : 12.4 x  17.55 x  7.0, Pin_Dir= 1;Pin_Row_Dist= 6; "SA52-11EWA" , KINGBRIGHT            Display: (0.52 inch)   13.2 mm
// SSB_Type 7 : 12.7 x  19.0  x  8.3, Pin_Dir= 1;Pin_Row_Dist= 6; "SA56-11EWA" , KINGBRIGHT            Display: (0.56 inch)   14.2 mm

// SSB_Type 8 : 18.6 x  25.0  x 10.6, Pin_Dir= 0;Pin_Row_Dist= 6;  "SA08-21EWA", KINGBRIGHT             Display: (0.80 inch)  20.3 mm
// SSB_Type 9 : 22.5 x  27.7  x 10.5, Pin_Dir= 1;Pin_Row_Dist= 12; "KW1-1001", Lucky Light              Display: (1.00 inch)  25.4 mm
// SSB_Type 10: 24.0 x  33.0  x 10.5, Pin_Dir= 1;Pin_Row_Dist= 12; "KW1-1002", Lucky Light              Display: (1.00 inch)  25.4 mm

// SSB_Type 11: 28.8 x  40.8  x  9.0, Pin_Dir= 1;Pin_Row_Dist= 14; "KW1-1201", Lucky Light              Display: (1.20 inch)  30.4 mm
// SSB_Type 12: 30.6 x  44.1  x  8.0, Pin_Dir= 1;Pin_Row_Dist= 16; "KW1-1501", Lucky Light              Display: (1.50 inch)  38.1 mm
// SSB_Type 13: 90.0 x 122.0  x 15.0, Pin_Dir= 1;Pin_Row_Dist= 42;Raster=2*2.54;"SA40-19SRWA",KINGBRIGHT Display: (4.00 inch) 100   mm

         1, // SS_Text_On, // [ 0 = off, 1 = on ]
         Socket_Font_ , // = "courbd.ttf"

         4, // DisplayIntegerNumber_, // [0, ..., 9, + hexnumbers: 10=A,11=b, 12=C, 13=d, 14=E, 15=F, degrees: 16="�", minus="-"]
         0, // Point_On_,                   // [ 0 = off, 1 = on ]
         3, // ActiveLED_Texture_Number,    // [ 0 = white, 1 = red, 2 = orange, 3 = amber ,4 = yellow, 5 =green, 6 = blue, 7= violet]
         4, // InactiveLED_Texture_Number,  // [ 0 = dark gray, 1 = light gray, 2 = transparent1, 3 = transparent2, 4 = amber]
         0, // DisplaySkin_Texture_Number_, // [ 0 = near black, 1 = dark gray, 2 = medium gray, 3 = light gray ]

         0, // Segment_Type_,  // 0 = angular, 1 = curved //


         0, //  PackageView_0n, //  = 0 or 1 )
         1, //  FootPrint_On, //  = 0 or 1 )
       ) // ---------------------------------------------------------------------------------------------------
  rotate< 0,0,0>
  translate<0, 0, 0>
} //-------------------------------------------------------

//------------------------------------------------------------------------------
//------------------------------------------------------------------------------
//------------------------------------------------------------ optional textures
#declare  Bord_Texture =
         texture { pigment{ color rgb< 0.05, 0.3, 0.05> }// dark olive green
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.1}
                 } // end of texture
#declare  Contact_Texture =
         texture { Chrome_Metal
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 }
                 } // end of texture
#declare  Solder_Texture =
         texture { Polished_Chrome
                   normal { bumps 0.5 scale 0.2 }
                   finish { phong 1 }
                 } // end of texture
//-------------------------------------------------------------------------------
#include "Seven_Segment_Board_Example.inc"
// circuit board with 2 rows of 5 pins for seven-segment displays
//-------------------------------------------------------------------------------
union{ // the board
object{ Seven_Segment_Board_Example(
                  -10, // Board_Start_X, //   in mm
                    8, // Board_End_X,
                  -14, // Board_Start_Z, //   in mm
                   14, // Board_End_Z,

                    0, // Contacts_Active,  0/1
                    0, // Contact_Center_X,
                    0, // Contact_Center_Z,

                    6, // Contact_Raster_Distance,// in 2.54 mm raster (0.1 inch)
                    1, // Contact_Raster_Direction, // 0 = in z;  1 = in x

               ) // -------------------------------------------------------------
        // scale<1,1,1>
       }
  union{
   text { ttf "arial.ttf",
          concat("Made with POV-Ray"), // chr(169),
          0.02, 0.0 // thickness, offset

       texture{ pigment{ color rgb<1,1,1>*0.1 }
              //normal { bumps 0.5  scale 0.01 }
                finish { diffuse 0.9 phong 0.1 }
              } // end of texture

       scale<2,1.5,-1>*0.8
       rotate<90,0,0>
       translate<-0.50,0.00, +0.9>
      } // end of text object ---------------------------------------------
   text { ttf "arial.ttf",
          concat("by Friedrich A. Lohm",chr(252),"ller, 2009"), // chr(169),
          0.02, 0.0 // thickness, offset

       texture{ pigment{ color rgb<1,1,1>*0.1 }
              //normal { bumps 0.5  scale 0.01 }
                finish { diffuse 0.9 phong 0.1 }
              } // end of texture

       scale<2,1.5,-1>*0.5
       rotate<90,0,0>
        translate<0, 0,0>

      } // end of text object ---------------------------------------------
  // text
  scale 0.90
  translate<-4.70,0.00,-13.85>
  }// end Text


 //-------- for the whole union:
        rotate<0,0,0>

     // rotate<16,0,30>

        translate<0,0,0>
      } // end of object --------------------------------------------------------
//-------------------------------------------------------------------------------
//-------------------------------------------------------------------------------