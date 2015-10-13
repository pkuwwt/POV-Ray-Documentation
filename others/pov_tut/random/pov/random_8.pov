// POV-Ray 3.7 Scene File "random_8.pov"
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
// camera ------------------------------------------------------------------
#declare Camera_Position_0 = <0.0 , 1.5 ,-1.5>;
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 115     // front view
                            location  Camera_Position_0
                            right     x*image_width/image_height
                            look_at   <0.0 , 2.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <5.0 , 4.5 ,-6.0>
                            right     x*image_width/image_height
                            look_at   <5 , 3.0 , 0.0>}
#declare Camera_Position_2 = <-1.0 , 8.0 , -10>;
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 25     // higher view
                            location  Camera_Position_2
                            right     x*image_width/image_height
                            look_at   <-0.1  ,1.7  , 2 >}
#declare Camera_3 = camera {ultra_wide_angle angle 90            // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_2}
// sun ---------------------------------------------------------------------
light_source{Camera_Position_0 color rgb<0.9,0.9,1.0>*0.2}

light_source{<800,2500,-1500> color White*0.8}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow
       texture{ pigment{ bozo turbulence 0.76
                         color_map { [0.5 rgb <0.20, 0.30, 0.8>*0.3]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }
       scale 10000}
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   200
    color      White
    fog_offset 0.1
    fog_alt    10.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane { <0,1,0>, 0
        texture{ pigment{color rgb<0.35,0.65,0.0>}
                 normal {bumps 0.75 scale 0.015}
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


// Choosing random series:
#declare Random_0 = seed (91125); // use: "rand(Random_0)"
#declare Random_1 = seed (52655); // use: "rand(Random_1)"
#declare Random_2 = seed (3133);  // use: "rand(Random_2)"


union{
 // outer loop
 #declare NrX = -3;   // start x
 #declare EndNrX = 3; // end   x
 #while (NrX< EndNrX+1)
    // more inner loop
    #declare NrY = -3;   // start y
    #declare EndNrY = 3; // end   y
    #while (NrY< EndNrY+1)
       // innerst loop
       #declare NrZ = -3;   // start z
       #declare EndNrZ = 3; // end   z
       #while (NrZ< EndNrZ+1)

       sphere{ <0,0,0>,0.15 scale <1,1,1>
               texture { pigment{ color rgb< 1.0, 0.65, 0.0> }
                         finish { phong 1}
                       } // end of texture

               // translate<NrX*0.5 NrY*0.5 NrZ*0.5>

               translate < 0.5*NrX + 0.25*(-0.5+rand(Random_0)) ,
                           0.5*NrY + 0.25*(-0.5+rand(Random_1)) ,
                           0.5*NrZ + 0.25*(-0.5+rand(Random_2))
                         >

       } // end of sphere --------------------------------------------

       #declare NrZ = NrZ + 1;  // next Nr z
       #end // --------------- end of loop z
       // end innerst loop
    #declare NrY = NrY + 1;  // next Nr y
    #end // --------------- end of loop y
    // end more inner loop
 #declare NrX = NrX + 1;  // next Nr x
 #end // --------------- end of loop x
 // end of outer loop

rotate<0,-40,0>
translate<0,2,2>} // end of union


//-------------------------------------------------------end