// POV-Ray 3.6/3.7 Scene File "While_demo2.pov"
// author: Friedrich A. Lohmueller, March-2010 / Jan-2014
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{assumed_gamma 1.0}
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}
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
//------------------------------------------------------------- Camera_Position, Camera_Look_at, Camera_Angle
#declare Camera_Number = 0 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.50, 1.50, -7.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.70,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (1)
  #declare Camera_Position = < 5.00, 5.00, -5.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.00, 1.00,  2.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (2)
  #declare Camera_Position = < 0.00,25.00, 6-0.001>;  // top view
  #declare Camera_Look_At  = < 0.00, 1.00, 6.00> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-10.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
// sun --------------------------------------------------------------
light_source{<-1500,1000,-1800> color White*0.7}         // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.2  shadowless}//flash light

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
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72}
                 normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
#declare CH = 3.0; //altezza colonna
#declare Column =
union{
 cone{<0,0,0>,0.40,<0,CH,0>,0.30}
 torus{0.4,0.05 translate<0,0.05,0>}
 torus{0.3,0.05 translate<0,CH-0.05,0>}
 texture{ pigment{ color rgb<1,0.95,0.8>} 
          normal { bumps 0.5 scale 0.01}
          finish { phong 0.1 }
        } // end of texture
 }// end Column
//--------------------------------------
union{ //-------------------------------
 #local Nr = 0;     // start
 #local EndNr = 10; // end
 #while (Nr < EndNr)
  object{ Column translate<-2,0,Nr*2.5>}
  object{ Column translate< 2,0,Nr*2.5>}
 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop
rotate<0,0,0>
translate<0,0,0>
} // end of union -----------------------


//--------------------------------------------------------------------------
//--------------------------------------------------------------------------





