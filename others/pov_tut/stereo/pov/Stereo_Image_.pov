// POV-Ray 3.6/3.7 Scene File "Stereo_Image_.pov"
// author: Friedrich A. Lohmueller, Jan-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6;
global_settings{ assumed_gamma 1.1}
#default{ finish{ ambient 0.1 diffuse 0.9}} // conserve_energy}}
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
// stereo view:
#declare Eye_Distance =  pow(-1,frame_number) * 0.4;  // "-"= left eye's view ,  "+"= right eye's view;
// stereo starts with frame_number = 1
// odd frame_numbers  1, 3, 5, ... = right eye views
// even frame_numbers 2, 4, 6, ... = left eye views

// normal non stereo view (frame_number = 0 )
#if( frame_number = 0 )
#declare Eye_Distance = 0;
#end //------------------------------------------



//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ; // 2 = rotate
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 2.00, -4.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 2.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)  //
  #declare Camera_Position =  <2.50, 3.50,-1.50> ;  // ~diagonal view
  #declare Camera_Look_At  = < 0.00, 1.50, 0.00 > ;
  #declare Camera_Angle    =  65 ;
#break
#case (2)
  #declare Camera_Position = < 4.00, 2.00,  0.00> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 2.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 6.00, -0.00001> ;  // top view // !!! not totally vertical!
  #declare Camera_Look_At  = < 0.00, 2.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 2.00, -4.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 2.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//---------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position + Eye_Distance/2 * vnormalize( vcross( Camera_Look_At-Camera_Position, <0,1,0> ) )
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At//
    }// end camera
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<

// sun --------------------------------------------------------------
light_source{<-1500,2500,-1500> color White*0.9}                      // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1 shadowless }  // flash light

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
      distance   100
      color      White*0.8
      fog_offset 0.1
      fog_alt    3
      turbulence 1.8
    }

// ground ------------------------------------------------------------
plane { <0,1,0>, 0
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
                 normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane

//---------------------------------------------------------------------
//---------------------------- objects in scene -----------------------
//---------------------------------------------------------------------



object{ // Wire_Box(A, B, WireRadius, UseMerge)
        Wire_Box(<-1,-1,-1>,<1,1,1>,  0.10,  0)

        texture{ pigment{ color rgb<1,1,1>*1.2} //rgb<1,0.65,0.0>}
               }

     scale<1,1,1>  rotate<0, 0,0> translate<0,2,0>
      } // ---------------------------------------------







