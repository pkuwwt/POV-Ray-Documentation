// POV-Ray 3.6 / 3.7 Scene File "cam_rot1".pov"
// created by Friedrich A. Lohmüller, 2003-2013
// Demonstrates rotating camera
//--------------------------------------------------------------------------
#version 3.6;
global_settings { assumed_gamma 1.3 }
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera { angle 35
                             location  <3.0 , 1.0 ,-20.0>
                             right     x*image_width/image_height

                             look_at   <-1.0 , 3.5, 5.0>
                             rotate<0,-360*(clock+0.10),0>
                           }
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.95}
light_source{<1500,2500, 2500> color White*0.1}
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <0.6,0.7,1.0>]
                                   [0.35 rgb <0.0,0.1,0.8>]
                                   [0.65 rgb <0.0,0.1,0.8>]
                                   [1.00 rgb <0.6,0.7,1.0>]
                                 }
                       scale 2
                     } // end of pigment
           } //end of skysphere -------------------------------------
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
                 finish {ambient 0.1 diffuse 0.8}
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

union{     // a little church

box { <-1,0,-1>,< 1,5,1>
      texture { pigment{color White}
                finish {ambient 0.15 diffuse 0.85 phong 1}
              } // end of texture
      scale <1,1,1> rotate<0,0,0> translate<0,0,0>
    } // end of box

intersection{
// linear prism in x-direction: from ... to ..., number of points (first = last)
prism { -1.00 ,1.00 , 4
        <-1.00, 0.00>, < 1.00,  0.00>, < 0.00,1.50>, <-1.00, 0.00>
        rotate<-90,-90,0> //turns prism in x direction! Don't change this line!
        texture {pigment{color Scarlet}
                 finish {ambient 0.15 diffuse 0.85 phong 1.0}}
        rotate<0,0,0> translate<0,0,0>
     } // end of prism --------------------------------------------------------
// linear prism in z-direction: from ,to ,number of points (first = last)
prism { -1.00 ,1.00 , 4
       <-1.00, 0.00>, < 1.00,  0.00>, < 0.00,2.00>, <-1.00, 0.00>
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line!
       texture {pigment{color Scarlet}
                finish {ambient 0.15 diffuse 0.85 phong 1.0}}
       rotate<0,0,0> translate<0,0,0>
     } // end of prism --------------------------------------------------------
scale <1.1,0.5,1.1>
translate <0,5,0>
}

// linear prism in z-direction: from ,to ,number of points (first = last)
prism { -0.00 ,5.00 , 6

       <-2.00, 0.00>,
       < 2.00, 0.00>,
       < 2.00, 2.00>,
       < 0.00, 3.00>,
       <-2.00, 2.00>,
       <-2.00, 0.00>
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line!
       texture {pigment{color White}
                finish {ambient 0.15 diffuse 0.85 phong 1.0}}
       rotate<0,0,0> translate<-3,0,0>
     } // end of prism --------------------------------------------------------

// linear prism in z-direction: from ,to ,number of points (first = last)
prism { -0.05 ,5.05 , 7

       <-2.00, 2.00>,
       < 0.00, 3.00>,
       < 2.00, 2.00>,
       < 2.00, 2.05>,
       < 0.00, 3.05>,
       <-2.00, 2.05>,
       <-2.00, 2.00>
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line!
       texture {pigment{color Scarlet}
                finish {ambient 0.15 diffuse 0.85 phong 1.0}}
       rotate<0,0,0> translate<-3,0,0>
     } // end of prism --------------------------------------------------------

translate<2.0,0,-2> }
//-----------------------------------------------------------------------------


