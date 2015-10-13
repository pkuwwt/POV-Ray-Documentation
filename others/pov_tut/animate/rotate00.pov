// POV-Ray 3.6 Scene File "rotate00.pov"
// created by Friedrich A. Lohmüller, May 2003 
//--------------------------------------------------------------------------
#version 3.6;
global_settings {  assumed_gamma 1.1 }
global_settings { max_trace_level 10 }//(1...20) [default = 5]

//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera { /*ultra_wide_angle*/ angle 65          // front view
                            location  <0.0 , 1.0 ,-2.7>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{< 1500,2500,-  1500> color White*0.8}
light_source{<-1500,-500,-  1500> color White*0.5}
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>]
                                   [0.30 rgb <1,1,1.0>]
                                   [0.70 rgb <1,1,1.0>]
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
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

text { ttf "arial.ttf", "Rotation", 0.2 , 0 // thickness, offset
       texture{ pigment{ color rgb<1,0.65,0>} 
                normal { bumps 0.5 scale 0.005}
                finish { ambient 0.1 diffuse 0.75 specular 1}
              } // end of texture
       scale<1,1.8,1>*0.75 
       translate<-1.30 ,0.50, -0.0 >
       rotate<0,-360*(clock+0.00),0> 
                              
      } // end of text object ------------------------------------------ end

