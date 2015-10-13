// POV-Ray 3.7 Scene File "povctw_3.pov"
// author: Friedrich A. Lohmueller, 2003/Aug-2009/Jan-2011
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
#declare Camera_1 = camera {ultra_wide_angle angle 75       
                            location   <-9, 15,-15>
                            right x*image_width/image_height
                            look_at   < -2,  5.0,-5>}
camera{Camera_1} 
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
//-------------------------------------------------------------
#declare Walltex =  texture{ pigment{color White}
                    finish { phong 1}}
#declare Rooftex =  texture{ pigment{color rgb<0.4,0.0,0.0>}
                    finish { phong 1}}
#declare TR =  2.0;   //TurmRadius --- tower radius                            
#declare TH =  5.0;   //TurmHöhe   --- tower height                     
//-----------------------  Turm -- tower ----------------------
#declare Tower =  union{    
cylinder {<0,0,0>,<0,TH,0>,TR    texture{Walltex}}
cone{<0,0,0>,TR+0.5,<0,TR+0.5,0>,0
                    translate<0,TH,0>   texture{Rooftex}}
cone{<0,0,0>,TR -0.2,<0,2*TR+0.5,0>,0
                    translate<0,TH,0>   texture{Rooftex}}
}// -----------------------------------------------------------

object{ Tower translate<-6, 0,-6>}
object{ Tower translate< 6, 0,-6>}
object{ Tower translate< 6, 0, 6>}
object{ Tower translate<-6, 0, 6>}
//--------------------------------------------------------end--
