// POV-Ray 3.7 Scene File "sphere.pov"
// author:  Friedrich A. Lohmueller
// Date: May 2009 / Aug-2009 / Jan-2011
//---------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
//---------------------------------------
camera{ ultra_wide_angle
        angle 75
        right x*image_width/image_height
        location <0.0 , 1.0 ,-3.0>
        look_at  <0.0 , 0.0 , 0.0>}
//---------------------------------------
light_source{ <1500,2500,-2500>
              color rgb<1,1,1> }
//---------------------------------------
sky_sphere{ pigment{color rgb<1,1,1>}}
//---------------------------------------
// La sfera rotante:
sphere{ <0,0,0>, 0.25
        texture { pigment{ rgb<1,0,0>}
                  finish { diffuse 0.9
                           phong 1}
                } // end of texture
        translate< 1.0, 0, 0>
        rotate < 0,360*clock 0>//  <-!!!!
       } // end of sphere ---------------
//----------------------------------- end
