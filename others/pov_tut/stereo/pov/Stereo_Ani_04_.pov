// POV-Ray 3.6/3.7 Scene File "Stereo_Ani_04_.pov"
// author: Friedrich A. Lohmueller, Jan-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6;
global_settings{ assumed_gamma 1.1}
#default{ finish{ ambient 0.1 diffuse 0.9}} //
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
//--------------------------------------------------------------------------------------- stereo settings <<<<
#declare Stereo_On = 1;
// ------------------------------------------------------------
// ------------------------------------------------------------
#if( Stereo_On = 1 )
 #declare Eye_Distance = 0.08;
// Stereo Animations frame counting:
//---- odd frame_numbers  1, 3, 5, ... = right eye views
//---- even frame_numbers 2, 4, 6, ... =  left eye views
// stereo: frame 1 to 60 -> frame pair = 1 to 30 !!!
 #if(  (frame_number/2) != int( frame_number/2  ))
        // odd frame_number
  #declare Eye_Distance = -1*Eye_Distance;
  #declare Time  = clock  ;
  #declare Frame =  (frame_number+1)/2 ;
 #else  // even frame_number
  #declare Eye_Distance = +1*Eye_Distance;
  #declare Time     = clock - clock_delta ;
  #declare Frame =  (frame_number)/2 ;
 #end
 #declare EndFrame =  final_frame/2;
//-------------------------------------------------------------
#else // Stereo_On = 0
 #declare Eye_Distance = 0;
 #declare Time     = clock +0.0 ;
 #declare Frame    = frame_number  ;
 #declare EndFrame = final_frame ;
#end // of "#if( Stereo_On = 1 ) "
//-------------------------------------------------------------------------------- end of stereo settings <<<<
//--------------------------------------------------------------------------------------------------------<<<<

//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ; //
//--------------------------------
//--------------------------------
#macro  Cos_010( X )
       (0.5-0.5*cos(2*pi*X))
#end
//--------------------------------
//--------------------------------
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)  //
  #declare Camera_Position = vrotate( <4.3,1.6,-6> ,<0,-50*Cos_010(Time),0> ) ; //
  #declare Camera_Look_At  = < -1.2 ,1.6,  5.5> ;
  #declare Camera_Angle    = 65+7*Cos_010(Time) ;
#break
#case (2)
  #declare Camera_Position = < 0.00, 2.00, -4.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 2.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )"
//---------------------------------------------------------------------------------------------------------<<<<
//---------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position + Eye_Distance/2 * vnormalize(vcross(Camera_Look_At-Camera_Position,<0,1,0>))
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At//
      }// end of camera
//---------------------------------------------------------------------------------------------------------<<<<
//---------------------------------------------------------------------------------------------------------<<<<
// sun ----------------------------------------------------------------------------
light_source{< 1500,400,-210> color rgb<1,0.95,0.9>*0.8}              // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.2 shadowless}  // flash light

// sky ----------------------------------------------------------------------------
plane{<0,1,0>,1 hollow
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.24, 0.32, 1.0>*0.5]
                                     [0.50 rgb <0.24, 0.32, 1.0>*0.5]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5 rotate<0,-40,0> translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }
       scale 10000}

// fog on the ground --------------------------------------------------------------
fog { fog_type   2
      distance   350
      color      rgb<0.9,0.9,1>*0.8
      fog_offset 0.1
      fog_alt    3.5
      turbulence 1.8
    }

// ground -------------------------------------------------------------------------
plane{ <0,1,0>, 0
       texture{ pigment{ color rgb<0.35,0.65,0.0>*1.22 }
                    normal { bumps 0.75 scale 0.015 }
                finish { phong 0.1 }
              } // end of texture
     } // end of plane
//---------------------------------------------------------------------------------
//---------------------------- objects in scene -----------------------------------
//---------------------------------------------------------------------------------



//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Wall_Texture_Outside =
      texture { pigment{ color rgb< 1,1,1>*0.9 }// 0.87, 0.55>*1.0}
                normal { pigment_pattern{ gradient y  scallop_wave
                                           color_map {[0, rgb 0.8]
                                                      [0.975, rgb 0.8]
                                                      [1, rgb 0.2]}
                                           scale 0.10}
                         0.3 translate<0,-0.16,0>}
                finish { phong 0.1}
              } // end of texture
//--------------------------------------------------------
#declare Wall_Texture_Inside =
      texture { pigment{ color White*1.0}
                finish { phong 1}
              } // end of texture
//--------------------------------------------------------
#declare Roof_Texture =
// layered texture!!!
      texture { pigment{ color rgb<1,1,1>*0.65} //Scarlet*1.3
                normal { gradient z scallop_wave scale<1,1,0.10>}
                finish { phong 1}
              } // end of texture

      texture { pigment{ gradient x
                         color_map{[0.00 color Clear]
                                   [0.90 color Clear]
                                   [0.95 color White*0.1]
                                   [1.00 color White*0.1]}
                          scale 0.25}
                 finish { phong 1}
              } // end of texture

//--------------------------------------------------------
#declare Window_Texture =
         texture{ pigment{ color White*1.2}
                  finish { phong 0.1}}
//--------------------------------------------------------
#declare Base_Texture =  //texture{Wall_Texture_Outside}
         texture{ pigment{ brick color rgb< 0.75, 0.7, 0.60>*0.45  // color mortar
                                 color rgb< 0.75, 0.68, 0.66>*0.60  // color brick
                           brick_size <0.25, 0.05, 0.25> // format in x ,y and z- direction
                           mortar 0.0125                  // size of the mortar
                           scale 1.25
                        } // end of pigment
                  normal {wrinkles 0.75 scale 0.01}
                  finish {phong 0.2}
                  rotate<0,0,0>  translate< 0.00, 0.00, 0.00>
               } // end of texture
//--------------------------------------------------------
#declare Veranda_Texture =
      texture { pigment{ color rgb< 1, 1, 1>*1.2}
                normal { pigment_pattern{ gradient x  scallop_wave
                                           color_map {[0, rgb 0.8]
                                                      [0.99, rgb 0.8]
                                                      [1, rgb 0.3]}
                                           scale 0.3}
                         0.2 translate<-0.16,0,0>}
                finish { phong 0.5}
              } // end of texture
//--------------------------------------------------------
#declare Veranda_Beam_Texture1 =  //texture{Wall_Texture_Outside}
         texture{ pigment{ color rgb< 1, 1, 1>*1.15}
                  finish { phong 0.0}}
#declare Veranda_Beam_Texture2 =  //texture{Wall_Texture_Outside}
         texture{ pigment{ color rgb< 1, 1, 1>*1.05}
                  finish { phong 0.0}}
//--------------------------------------------------------
//----------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#include "House_50_0.inc"
//-------------------------------------------------------------------------------------//
object{ House_50_0( 4.00, // Half_House_Width_X, // >= 3.00
                    9.00, // Total_House_Width_Z,// >= 4.00
                    3.90, // House_Height_Y,     // >= 3.50
                    15,   // Roof___Angle, // ca. 10 ~ 60 degrees, adapt House_Height_Y !
                    // door and windows open/closed

                    0.7, //Window_Open_Frontside_1,  left: 0=closed  ~ 1=open
                    0.7, //Window_Open_Frontside_2,middle: 0=closed  ~ 1=open
                    0.3, //Window_Open_Frontside_3, right: 0=closed  ~ 1=open
                    0.2, //Window_Open_Backside_1,  left: 0=closed  ~ 1=open
                    0.0, //Window_Open_Backside_2,middle: 0=closed  ~ 1=open
                    0.0, //Window_Open_Backside_3, right: 0=closed  ~ 1=open
       #if (Time>0.5 )
            0.8*Cos_010((Time-0.5)*2), //Window_Open_RightSide_1
       #else        0.0, //Window_Open_RightSide_1, back: 0=closed  ~ 1=open
       #end
       #if (Time>0.35 & Time<0.85 )
              0.5*Cos_010((Time-0.35)*2), //Door_Open___Rightside_2,middle: 0=closed  ~ 1=open
       #else              0, //Door_Open___Rightside_2,middle
       #end
       #if (Time<0.5 )
           0.9*Cos_010(Time*2), //Window_Open_RightSide_3,front: 0=closed  ~ 1=open
       #else        0.0, //Window_Open_RightSide_3,front: 0=closed  ~ 1=open
       #end
                    0.3, //Window_Open_LeftSide_1,  back: 0=closed  ~ 1=open
                    1.0, //Window_Open_LeftSide_2,middle: 0=closed  ~ 1=open
                    1.0, //Window_Open_LeftSide_3, front: 0=closed  ~ 1=open
                    // textures
                    Wall_Texture_Outside ,
                    Wall_Texture_Inside  ,
                    Window_Texture       ,
                    Roof_Texture         ,
                    Base_Texture         ,
                    Veranda_Texture      ,
                    Veranda_Beam_Texture1 ,
                    Veranda_Beam_Texture2
                   ) //----------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0, 0,0>
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
