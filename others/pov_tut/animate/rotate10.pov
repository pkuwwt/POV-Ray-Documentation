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
#declare Camera_0 = camera { /*ultra_wide_angle*/ angle 15          // front view
                            location  <0.0 , 5.0 ,-12.7>
                            right     x*image_width/image_height
                            look_at   <-0.2 , 0.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{< 1500,2500,-  1500> color White }
// sky ---------------------------------------------------------------------
sky_sphere { pigment { color  rgb <1,0.8,0.3> }} 
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

                              
    
box {   <-1,-1,-1>,< 1,1,1>  scale 0.4
        texture { pigment{color White*1.1}
                finish {ambient 0.15 diffuse 0.85 phong 1}
              } // end of texture
       
        rotate<0,-90*(clock+0.20),0> 
        translate <-1,0.5,0>
        no_shadow
      } // end of box --------------------------

object{ Hexagon  
        scale <0.25,1,1> scale <1,1,1>*0.65  rotate<0,0,90>
        
        texture { pigment{color White}
                  finish {ambient 0.15 diffuse 0.85 phong 1}
                }
        
        rotate<0,-60*(clock+0.20),0> 
        translate<0,-0.5,-0.5>
       no_shadow
       } // end of object


#include "shapes_lo.inc"
// Round_N_Pyramid (N, Wire_Radius, Pyramid_R, Pyramid_R2, Pyramid_Height, Fill_On, Merge_On)  
object{ Round_N_Pyramid (7, 0.10 , 1.00, 0.70, 0.55 , 1, 0)         
        texture{ pigment{color rgb<1,1,1>}
                 normal {bumps 0.25 scale 0.015}
                 finish {ambient 0.1 diffuse 0.85 phong 1}}
         scale <1,1,1>*0.8

        rotate<0,-360/7*(clock+0.20),0> 

         translate<0.65,0.25, 0.65 >
       no_shadow
       } //-------------------------------------------------------------------------------end
 


      
