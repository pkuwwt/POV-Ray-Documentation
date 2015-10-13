// POV-Ray 3.7 Scene File "random_1.pov"
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <0.0 , 2.75 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 2.75 , 0.0>}
#declare Camera_1 = camera {ultra_wide_angle angle 90       // diagonal view
                            location  <2.0 , 2.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {ultra_wide_angle angle 90     // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {ultra_wide_angle angle 90            // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
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







#declare Random_1 = seed (1153); // Use: "rand(Random_1)"

#declare Ball_1 =
 sphere{<0,0,0>,0.25 scale <1,1,1> rotate<0,0,0> translate<0,0,0>
        texture{pigment{ color rgb<1,0.65,0>}
                finish { phong 1}}}


union{
 #declare Nr = -10;     // start
 #declare EndNr = 10; // end
 #while (Nr< EndNr+1)


   object{Ball_1 translate<Nr*0.5, rand(Random_1) ,0>}


 #declare Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop

rotate<0,0,0>
translate<0,0,4>} // end of union

//------------------------------------------------------------- end


