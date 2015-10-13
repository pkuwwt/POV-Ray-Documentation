// POV-Ray 3.7 Scene File "random_trees3.pov"
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
#declare Camera_0 = camera {ultra_wide_angle angle 75          // front view
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90       // diagonal view
                            location  <5.0 , 4.5 ,-6.0>
                            right     x*image_width/image_height
                            look_at   <5 , 3.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 110        // higher view
                            location  <0.0 , 6.0 , -7.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 4.0 , 0.0>}
#declare Camera_3 = camera {ultra_wide_angle angle 90            // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_2}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
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
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
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

#declare Tree =
union{

 isosurface {

    function{ sqrt( x*x + y*y+ z*z) - 1
              - f_noise3d( x*7, y*7, z*7 )*1.05
             }

    contained_by { box { -2, 2 } }
    accuracy 0.002
    max_gradient 22

    texture { pigment{ gradient <0,1,0> turbulence 1.5
                       color_map{
                          [0.0 color rgb<0.07,0.5,0.0>]
                          [0.2 color rgb<0.10,0.7,0.0>]
                          [0.4 color rgb<0.16,0.5,0.1>]
                          [0.6 color rgb<0.20,0.8,0.1>]
                          [0.7 color rgb<0.10,0.3,0.0>]
                          [0.9 color rgb<0.02,0.4,0.0>]
                          [1.0 color rgb<0.06,0.5,0.0>]
                         } // end of color_map
                        scale 0.1
                      } // end of pigment
              normal { bumps 0.5 scale 0.015}
              finish { phong 0.6}
            } // end of texture
    scale 0.9
    translate <0,2.5,0>
  } // end of isosurface ----------------------------------------


 cylinder{ <0,0,0>,<0,2.0,0>,0.2
           texture { pigment { color rgb<0.40,0.25,0.15>}
                     normal  { bumps 0.5 scale <0.005,0.25,0.005>}
                     finish  { phong 0.5}
                   } // end of texture
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
  } // end of cylinder --------------------------------------
} // --------------------------------------------------- end of Tree

// planting the trees ----------------------------------------------

// Choosing random series
#declare Random_0 = seed ( 342);
#declare Random_1 = seed (2655);
#declare Random_2 = seed (1153);
#declare Random_3 = seed (6432);

union{
 #declare NrX = - 3;     // start x
 #declare EndNrX =  3; // end   x
 #while (NrX< EndNrX+1)
    // inner loop
    #declare NrZ = 0;     // start z
    #declare EndNrZ =  4; // end   z
    #while (NrZ< EndNrZ+1)

      object{Tree
             rotate<10*2*(0.5-rand(Random_3)),0,0>
             rotate<0,360*rand(Random_0),0>

             scale  1+0.5*rand(Random_1)

             //translate <NrX*2.75 , 0, NrZ*2.75 >}

             translate <NrX*2.75+2*(-0.5+rand(Random_2)), 0, NrZ*2.75+2*(-0.5+rand(Random_2))>}

    #declare NrZ = NrZ + 1;  // next Nr z
    #end // --------------- end of loop z
    // end inner loop
 #declare NrX = NrX + 1;  // next Nr x
 #end // --------------- end of loop x
 // end of outer loop
rotate<0,0,0>
translate<0,0,0>} // end of union --------------------------
//-------------------------------------------------------end