// POV-Ray 3.7 Scene File "random_9.pov"
// author: Friedrich A. Lohmueller, 2004/Aug-2011/Jan-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 29
                            location  <0.0 , 25.0 , 5>
                            right     x*image_width/image_height
                            look_at   <0.0  ,0.0  , 5 >}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<2500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow
       texture{ pigment{ bozo turbulence 0.76
                         color_map { [0.5 rgb <0.20, 0.20, 1.0>]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }
       scale 10000}
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   100
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane { <0,1,0>, 0
        texture{ pigment{color rgb<0.35,0.65,0.0>*1.3}
                 //normal {bumps 0.75 scale 0.015}
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


// Choosing random series:
#declare Random_1 = seed (2655);
#declare Random_2 = seed (1153);

#declare Random_3 = seed (1432);
#declare Random_4 = seed (7242);
#declare Random_5 = seed (9912);

union{
 // outer loop
 #declare NrX = - 5;   // start x
 #declare EndNrX =  5; // end   x
 #while (NrX< EndNrX+1)
    // inner loop
    #declare NrZ = 0;     // start z
    #declare EndNrZ =  10; // end   z
    #while (NrZ< EndNrZ+1)

    sphere { <0,0,0>, 0.5
             texture {

                       pigment{ color rgb< 1*rand(Random_3),
                                           1*rand(Random_4),
                                           1*rand(Random_5)> }
                       finish { phong 1}
                     } // end of texture
             scale<1,1,1>  rotate<0,0,0>

             translate< 1*NrX , 0.5, 1*NrZ >

    } // end of sphere --------------------------------------------

    #declare NrZ = NrZ + 1;  // next Nr z
    #end // --------------- end of loop z
    // end inner loop
 #declare NrX = NrX + 1;  // next Nr x
 #end // --------------- end of loop x
 // end of outer loop
rotate<0,0,0>
translate<0,0,0>} // end of union --------------------------
//-------------------------------------------------------end