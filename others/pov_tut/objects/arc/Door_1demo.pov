// POV-Ray 3.6 / 3.7 Scene File "Door_1_demo.pov"
// author: Friedrich A. Lohmueller, Jan-2006/Aug-2009/Jan-2011
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
#declare Camera_0 = camera { /*ultra_wide_angle*/ angle 50
                            location<-1.7,1.0,-3.5>
                            right     x*image_width/image_height
                            look_at < -0.2, 0.9, 0.75>}
camera{ Camera_0 }
// sun --------------------------------------------------------------------
light_source{<1500,1500,-1500> color White}
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

//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Door_Texture =
   texture { // pigment{ color rgb< 0.75, 0.5, 0.30>*0.5 } // brown
             pigment{ color rgb<1,1,1> }
             finish { phong 0.1}
           } // end of texture
//---------------------------------------------------------------------------------------
#include "Door_1.inc"
//-------------------------------------------------------------------------------------//
union{
object{ Door_1
        texture { Door_Texture }
        scale <1,1,1>*0.99
        rotate<0, 0,0>
        translate<-0.50,0.00,0.00>}

object{ Door_1
        texture { Door_Texture }
        scale <1,1,1>*0.99
        rotate<0,40,0>
        translate<-0.50,0.00,0.00> scale<-1,1,1>}
translate<-0.60,0.00,-0.70>
} // end of union
// #declare Door_Hole = object { Door_1_Hole } // use it with wall texture!
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------






