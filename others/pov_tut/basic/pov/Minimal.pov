// PoV-Ray 3.6/3.7 Scene File "Minimal.pov"
// by Friedrich A. Lohmueller, March-2010 / Feb-2013
//-------------------------------------------
#version 3.6; // 3.7;
global_settings{assumed_gamma 1.0}
#default{ finish{ ambient 0.1 diffuse 0.9 }}
//------------------------------------------
#include "colors.inc"
#include "textures.inc"
//------------------------------------------
// camera ----------------------------------
camera{ location  <0.0 , 1.0 ,-3.0>
        look_at   <0.0 , 1.0 , 0.0>
        right x*image_width/image_height
        angle 75 }
// sun -------------------------------------
light_source{<1500,3000,-2500> color White}
// sky -------------------------------------
plane{ <0,1,0>,1 hollow
       texture{
         pigment{ bozo turbulence 0.92
           color_map{
                 [0.00 rgb<0.05,0.15,0.45>]
                 [0.50 rgb<0.05,0.15,0.45>]
                 [0.70 rgb<1,1,1>        ]
                 [0.85 rgb<0.2,0.2,0.2>  ]
                 [1.00 rgb<0.5,0.5,0.5>  ]
                       } //
           scale<1,1,1.5>*2.5
           translate<0,0,0>
           } // end of pigment
         finish {ambient 1 diffuse 0}
        } // end of texture
       scale 10000}
// fog on the ground -----------------------
fog { fog_type   2
      distance   50
      color      rgb<1,1,1>*0.8
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    } //
// ground ----------------------------------
plane{ <0,1,0>, 0
       texture{
          pigment{ color rgb<0.22,0.45,0>}
          normal { bumps 0.75 scale 0.015 }
          finish { phong 0.1 }
       } // end of texture
     } // end of plane
//------------------------------------------
//------------------------------------------
// objects in scene ------------------------
sphere{ <0,0,0>, 0.75
        texture{
          pigment{ color rgb<0.9,0.55,0>}
          finish { phong 1 }
        } // end of texture
        translate<0.85,1.1,0>
      } // end of sphere
//------------------------------------- end