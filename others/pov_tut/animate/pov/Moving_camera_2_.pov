// POV-Ray 3.6 / 3.7 Scene File "Moving_camera_2_.pov"
// author: Friedrich A. Lohmueller, Jan-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6;
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
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//---------------------------
#declare Rapport = 1/1.5; // in z+ 
#declare Move = Rapport*clock;  
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 2.50, 3.00, -6.00+Move> ;  // diagonal view
  #declare Camera_Look_At  = <-0.50,-0.30,  0.00+Move> ;
  #declare Camera_Angle    =  45 ;
#break
#case (2)
  #declare Camera_Position = < 5.00, 1.00,  0.00> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 8.00, -0.001> ;  // top view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
// sun ---------------------------------------------------------------------
light_source{<-1500,1500,1000> color White*0.9}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light

// sky --------------------------------------------------------------
plane{<0,1,0>,1 hollow
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   500 
      color      White
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8

     }

// ground ------------------------------------------------------------
plane { <0,1,0>, 0
        texture{ pigment{ color rgb<1,1,1>*1.1 }// rgb<0.35,0.65,0.0>*0.72 }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//-------------------------------------------------------------------------------------//
#include "RT_System/RT_Track_Straight_00.inc"  // straight track in x
//-------------------------------------------------------------------------------------// 
#declare Rail_Spikes_On = 1; // optional, default = 0, 
//-------------------------------------------------------------------------------------// 

union{
 // railtrack
 object{ RT_Track_Straight_00( 100*2/3, // track length, in x+ in meter
                               1.5 , // number of ties per meter
                   ) //----------------------------------------------------------------//
         translate< -5.00,0.00, 0.00>
       } //----------------------------------------------------------------------------//
 rotate<0,-90,0> 
 translate<0.00, 0.00, 0.00>
 } //----------------------------------------------------------------------------------//
 // balast 
 object{ Round_Box(<-1.00,-2.00,-500>,< 1.00, 0.12, 500>, 0.80,0)   
         scale<3.5,1,1>  
         texture{ pigment{ color rgb< 0.75, 0.62, 0.45>*0.7 }  
               normal { bumps 0.5 scale 0.025}
               finish { phong 0.5}                                         
             } // end of texture
    }// end box
//-------------------------------------------------------------------------------------//

