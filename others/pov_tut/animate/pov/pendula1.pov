// POV-Ray 3.6/3.7 Scene File "pendula1.pov"
// created by Friedrich A. Lohmueller, 2003 / 2010/Jan-2011
// Demonstates the animation of swinging pendula.
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//#include "metals.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle  60          // front view
                            location  <0.0 , 1.0 ,-3.5>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{< -3000, 3000, -3000> color White}
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1,1,1.0>]
                                   [0.35 rgb <0.5,0.6,0.8>]
                                   [0.65 rgb <0.5,0.6,0.8>]
                                   [1.00 rgb <1,1,1.0>]
                                 }
                       scale 2
                     } // end of pigment
           } //end of skysphere
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
#declare Pendula = //------------------------------------------------------- Pendula
union{ // outer union
cylinder { <0,-2,0>,<0,0,0>,0.04
           texture { pigment { color rgb<0.40,0.25,0.15>}
                    //normal { bumps 0.5 scale <0.005,0.25,0.005>}
                     finish  { phong 0.5}
                   } // end of texture
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         } // end of cylinder
 union{ // inner union   -------------------------------------------------------
  sphere { <0,0,0>, 0.25
           texture { Polished_Chrome pigment{ color rgb< 1, 0.65, 0.0>}
                     finish { phong 1 reflection 0.3}
                 } // end of texture
           scale<1,1,1>  rotate<0,0,0>  translate<0,0,0>
         }  // end of sphere ---------------------------------------------------
  cone { <0,-0.55,0>,0,<0,0,0>,0.105
         texture { Polished_Chrome  pigment{color rgb<1,0.65,0.0>}
                   finish { phong 1 reflection 0.3}
               } // end of texture
       scale <1,1,1> rotate<0,0,0> translate<0,0,0>
     } // end of cone ----------------------------------------------------------
  scale <1,1,1> rotate<0,0,0> translate<0,-2,0>
  }// end of inner union
}  // end of outer union
 // ----------------------------------------------------------------------------------

#declare Amplitude = 40 ;// in degrees  -  in Grad

object { Pendula

         rotate< 0, 0, Amplitude*sin( clock*2*pi) >

         translate<0,2.15,0>
        }
// ----------------------------------------------------------- end