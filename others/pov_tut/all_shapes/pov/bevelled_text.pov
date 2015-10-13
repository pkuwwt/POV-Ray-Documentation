// POV-Ray 3.6/3.7 Scene File "bevelled_text.pov"
// author: Friedrich A. Lohmueller, June 2004/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de 
// homepage: http://www.f-lohmueller.de
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle 75          // front view
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
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
light_source{< 1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>]
                                   [0.30 rgb <0.0,0.1,1.0>]
                                   [0.70 rgb <0.0,0.1,1.0>]
                                   [1.00 rgb <1.0,1.0,1.0>] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <0.85,0.6,0.4>}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
//Bevelled_Text(Font, String, Cuts, BevelAng, BevelDepth, Depth, Offset, UseMerge)
object{ 
        Bevelled_Text("arial.ttf", "POVRAY", 10 , 35, 0.045, 1, 0.00, 0)
        texture{ pigment{ color rgb<1,0.70,0>} 
                 normal { bumps 0.5 scale 0.005}
                 finish { phong 0.1 specular 1 reflection 0.25}
               } // end of texture
        rotate<0,-40,0>
        scale<0.75,1.0,1>*3 
        translate<-1.2, 0.1,-0.5>
      } // end of Bevelled_Text object -------------------------------------------

//----------------------------------------------------------------------------------end










