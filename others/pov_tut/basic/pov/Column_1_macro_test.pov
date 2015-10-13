// POV-Ray 3.6/3.7 Scene File "Column_1_macro_test.pov"
// author: Friedrich A. Lohmueller,  Jan-2014
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
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
//--------------------------------------------------------------------------
//------------------------------------------------------------- Camera_Position, Camera_Look_at, Camera_Angle
#declare Camera_Number = 4 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.50, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  75 ;
#break
#case (1)
  #declare Camera_Position = < 3.00, 2.50, -5.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 1.70,  0.00> ;
  #declare Camera_Angle    =  60 ;
#break
#case (2)
  #declare Camera_Position = < 3.00, 1.00,  0.00>;  // right side view
  #declare Camera_Look_At  = < 0.00, 1.70,  0.00> ;
  #declare Camera_Angle    =  90 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 6.00, -0.001>;  // top view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  90 ;
#break
#case (4)
  #declare Camera_Position =  <0.00 , 1.50 ,-7.00>;  // additional view front 
  #declare Camera_Look_At  =  <0.00,  1.70 , 0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#else
  #declare Camera_Position = < 0.50, 1.00, -5.00> ;   
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  75 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }

// sun ---------------------------------------------------------------------
light_source{<-1500,1000,-1800> color White*0.7}         // sun light
light_source{<0.0 , 1.5 ,-7.0>  color rgb<0.9,0.9,1>*0.2 shadowless }//flash light

// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.25, 0.9>*0.6]
                                     [0.50 rgb <0.20, 0.25, 0.9>*0.6]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate<-1,0,0.5>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   150
      color      rgb<1,0.9,0.5>*0.8
      fog_offset 0.1
      fog_alt    3.5
      turbulence 1.8
    }

// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.62 }
                 normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


// defining an object as macro: --------------------

//----------------- macro Column_1(...)
#macro Column_1( H_C,  // column height
                 R_B,  // base radius
                 R_min,// border radius
                 T_S,  // top scale
               ) //---------------------
union{
 cone{ <0,0,0>,R_B,<0,H_C,0>,R_B*T_S}
 torus{ R_B,R_min translate<0,R_min,0>}
 torus{ R_B*T_S,R_min*T_S
        translate<0,H_C-R_min*T_S,0>}
 }// end Column
#end //------------------- end of macro ------------


// invoking the macro: -----------------------------

object{Column_1( 3.5, // height
                 0.5, // base r
                 0.06,// border r
                 0.75,// top scale
              ) //---------------
       texture{
          pigment{color rgb<1,0.9,0.8>}
          normal{ bumps 0.5 scale 0.01}
          finish{ phong 0.1 }
        } // end texture

       translate<0,0,0> 
} //--------------------------------------------------






