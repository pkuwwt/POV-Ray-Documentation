// POV-Ray 3.6/3.7 Scene File "westernwheel.pov"
// created by  Friedrich A. Lohmueller, 2003/Jan-2011
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle 75          // front view
                            location  <0.0 , 1.0 ,-3.25>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}


// sky ---------------------------------------------------------------------
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
#declare Wheel_Radius = 1.00; 


plane { <0,1,0>, 0 
        texture{ pigment{color rgb<0.35,0.65,0.0>}
	         normal {bumps 0.75 scale 0.015}
                 finish {ambient 0.1 diffuse 0.8}
                } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------







#declare Rad_Tex =
 texture{pigment{color LightWood}
         //normal { radial 2 frequency 72 scallop_wave }
         finish {ambient 0.15 diffuse 0.85 phong 1}}
#declare Speichen_Tex =
 texture{pigment{color MediumWood}
         finish {ambient 0.15 diffuse 0.85 phong 1}}

#declare Rad = union {          // radius = 1.00 
difference{
 cylinder {<0,0,-0.05>,<0,0,0.05>,Wheel_Radius}
 cylinder {<0,0,-0.06>,<0,0,0.06>,Wheel_Radius - 0.10}
 texture{Rad_Tex}}

 cylinder { <0, 0,-0.06> <0, 0, 0.06>,0.20 texture{Rad_Tex}}
 cone { <0, 0,-0.12>,0.08, <0, 0, 0.00>,0.15 texture{Speichen_Tex}}
 cone { <0, 0, 0.00>,0.15, <0, 0, 0.12>,0.08 texture{Speichen_Tex}}
 cylinder { <0, 0,-0.14> <0, 0, 0.14>,0.04  texture{Rad_Tex}}

  cylinder { <-1, 0, 0>, <1, 0, 0>,0.03 scale Wheel_Radius rotate   0*z texture {Speichen_Tex} }
  cylinder { <-1, 0, 0>, <1, 0, 0>,0.03 scale Wheel_Radius rotate  30*z texture {Speichen_Tex} }
  cylinder { <-1, 0, 0>, <1, 0, 0>,0.03 scale Wheel_Radius rotate  60*z texture {Speichen_Tex} }
  cylinder { <-1, 0, 0>, <1, 0, 0>,0.03 scale Wheel_Radius rotate  90*z texture {Speichen_Tex} }
  cylinder { <-1, 0, 0>, <1, 0, 0>,0.03 scale Wheel_Radius rotate 120*z texture {Speichen_Tex} }
  cylinder { <-1, 0, 0>, <1, 0, 0>,0.03 scale Wheel_Radius rotate 150*z texture {Speichen_Tex} }
}
//---------------------------------------------------
object{ Rad  rotate <0,0,-30*clock>
        
        rotate <0,30,0> 
        translate <0,1,-1>
      }



//---------------------------------------------------------- end -----------

