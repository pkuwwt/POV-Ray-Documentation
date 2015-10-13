// POV-Ray 3.6 / 3.7 Scene File "povroc1.pov"
// author: Friedrich A. Lohmueller, Aug-2005/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
global_settings { noise_generator 1 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
// camera -------------------------------------------
#declare Cam0 =
  camera {ultra_wide_angle angle 80
               location  <0.0 , 1.0 ,-3.0>
               right     x*image_width/image_height
               look_at   <0.0 , 1.0 , 0.0>}
camera{Cam0}
// sun ------------------------------------------------
light_source{<1500,2500,-2500>
                    color White}
// sky ------------------------------------------------
plane{<0,1,0>,1 hollow rotate<0.1,0,0>
//keep attention: 
//place sun lower than the sky
  texture{ pigment{Bright_Blue_Sky}
           finish {ambient 1 diffuse 0}}
   scale 10000}
// ground -------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment { color rgb <0.80,0.55,0.35>*1.1}
                normal  { bumps 0.5 scale 0.035  }
                finish  { phong 0.1 } 
              } // end of texture
     } // end of plane

fog { fog_type   2
      distance   100
      color      White  
      fog_offset 0.1
      fog_alt    2.5
      turbulence 1.8
    }
//----------------------------------------------------------------------
//------------ rocket --------------------------------------------------
union{
//------- the body ---------------------------------------------------
cone{<0,0,0>,0.5,<0,1.5,0>,0.25
        texture{Chrome_Metal}}
//-------- the controll surfaces -----------------------------------
prism { -0.01 ,0.01 , 4
          <-1.00, 0.00>, 
          < 1.00, 0.00>, 
          < 0.00, 1.50>, 
          <-1.00, 0.00>
   rotate<-90,0,0> translate<0,0,0>
   texture { pigment{ color White }
             finish { phong 1.0}}
  } // -------------- xy-direction -------------
prism { -0.01 ,0.01 , 4
 <-1.00, 0.00>,< 1.00, 0.00>,< 0.00,1.50>,<-1.00, 0.00>
  rotate<-90,90,0> translate<0,0,0>
  texture { pigment{ color White}
            finish { phong 1.0}}
  } // -------------- zy-direction ------------
//-------- the top of the rocket ---------------------
sphere{<0,0,0>,0.25 scale <1,1.5,1>
           translate<0,1.5,0>
           texture{ Chrome_Metal }}
//--------------------------------------------------------------------
//----------------- ready for take off:
rotate<0,0,0> translate<0,0,0>} //end of union
//--------------------------------------------------------------end---




