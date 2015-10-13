// POV-Ray 3.6 / 3.7 Scene File "povarc0.pov"
// author: Friedrich A. Lohmueller, Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

global_settings {  noise_generator 1 }
#include "colors.inc"
#include "textures.inc"
// camera ----------------------------------------------------------
#declare Cam0 =camera {ultra_wide_angle angle 90
                       location  <0.0 , 1.0 ,-3.0>
                       right x*image_width/image_height
                       look_at   <0.0 , 1.0 , 0.0>}
#declare Cam1 =camera {ultra_wide_angle angle 65
                       location  <2.0 , 1.8 ,-2.0>
                       right x*image_width/image_height
                       look_at   <0.0 , 0.0 , 0.0>}
camera{Cam1}
// sun --------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky --------------------------------------------------------------
sphere{<0,0,0>,1 hollow
       texture{pigment{gradient <0,1,0>
                       color_map{[0 color rgb<0.35,0.4,1>]
                                 [1 color rgb<0.45,0.0,1>]}
                       quick_color White }
               finish {ambient 0.6 diffuse 0} }
       scale 10000}
// ground -----------------------------------------------------------
#global_settings { noise_generator 1 }
plane{<0,1,0>, 0
  texture{checker
          texture{ Polished_Chrome
                   normal { waves 0.3 frequency 2 scale 0.1}}
          texture{ pigment{ color rgb<1,0.8,0>  }
                   normal { bumps 0.3 scale 0.05 }
                   finish { phong 1}}
                 } }
//-------------------------------------------- arch ---------
difference{
   box {<-1,0,-0.1>,< 1,1,0.1>}
   cylinder {<0,0,-0.15><0,0,0.15>,0.9 }
   texture{pigment{ color White}
           normal { bumps 0.4 scale 0.007}
           finish { phong 1}}
   scale <1,1,2>
   rotate <0,0,0>
   translate <0,0,0>}
//---------------------------------------------------------- end ----