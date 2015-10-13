// POV-Ray 3.6 / 3.7 Scene File "Window_1_demo.pov"
// author: Friedrich A. Lohmueller, Jan-2006/Aug-2009/Jan-2011/May-2014
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7; 
global_settings{ assumed_gamma 1.0 } 
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
#include "glass.inc" // !!!
// camera -----------------------------------------------------------------
#declare Camera_0 = camera { /*ultra_wide_angle*/ angle 47
                            location<-1.7,1.0,-2.5>
                            right     x*image_width/image_height
                            look_at < -0.2, 1.0, 0.75>}
camera{ Camera_0 }
// sun --------------------------------------------------------------------
light_source{<1500,1500,-2000> color White}
// sky --------------------------------------------------------------------
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
        texture{ pigment{ color rgb<0.35,0.65,0.0>}
	         normal { bumps 0.75 scale 0.015}
                 finish { phong 0.1}
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//----------------------------------------------------------------------------- textures
#declare Window_Texture =
   texture { // pigment{ color rgb< 0.75, 0.5, 0.30>*0.5 } // brown
             pigment{ color rgb<1,1,1> }
             finish { phong 0.1}
           } // end of texture
//---------------------------------------------------------------------------------------
#include "Window_1.inc"
//-------------------------------------------------------------------------------------//
object{ Window_1
        texture { Window_Texture }
        rotate<0, 0,0>
        translate<0.00,0.00,0.00>}

object{ Window_1
        texture { Window_Texture }
        translate<0,-0.80,0>
        rotate<40,0,0>
        translate<-0.75,0,-0.50>}

// #declare Window_Hole = object { Window_1_Hole }
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------


//-------------------------------------------- end





