// POV-Ray 3.7 Scene File "povctw_1.pov"
// author: Friedrich A. Lohmueller, 2005/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
// camera -----------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle 75       
                            location  <0.0 , 1.0 ,-12.0>
                            right x*image_width/image_height
                            look_at <0.0 , 5.0 , 0.0>}
#declare Camera_1 = camera {ultra_wide_angle angle 60       
                            location   <-9.0 ,15.0 ,-9.0>
                            right x*image_width/image_height
                            look_at   <0.0 , 5.0 , 0.0>}
camera{Camera_0} 
// sun --------------------------------------------------------
light_source{<1500,2500,-2500> color White}
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
    distance   150
    color      White
    fog_offset 0.1
    fog_alt    3.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment { color rgb <0.85,0.6,0.4>}
                normal  { bumps 0.75 scale 0.025  }
                finish  { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
//        ............. Turm - tower ...................

cylinder {<0,0,0>,<0,5,0>,2
          texture{pigment{ color White}
                  finish { phong 1}}}
cone{<0,0,0>,2.5,<0,2.5,0>,0  translate<0,5,0>
          texture{pigment{ color rgb<0.4,0.0,0.0>}
                  finish { phong 1}}}
cone{<0,0,0>,1.8,<0,5.5,0>,0  translate<0,5,0>
          texture{pigment{ color rgb<0.4,0.0,0.0>}
                  finish { phong 1}}}
//--------------------------------------------------------end--
