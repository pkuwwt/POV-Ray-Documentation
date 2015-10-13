// PoVRay 3.7 Scene File "steam_smoke_1.pov"
// author: Friedrich A. Lohmueller, Oct-2008/Aug-2009 / Jan-2011/ Sept-2014
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
global_settings{assumed_gamma 1.0}
#default{ finish{ ambient 0.1 diffuse 0.9 }}
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//-------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Position = < 0.00, 0.80,-3.0 >;
#declare Camera_look_at= < 0.00, 1.70, 0.00>;
#declare Camera_Angle = 85;
//--------------------------------------------------------------------------------------------------------<<<<
camera{ /*ultra_wide_angle*/
        location  Camera_Position
        right     x*image_width/image_height
        angle Camera_Angle
        look_at   Camera_look_at
      }
//------------------------------------------------------------------------------------------------------<<<<<
// sun ---------------------------------------------------------------------
light_source{<2500,2500,-2500> color White}

// sky --------------------------------------------------------------
plane{<0,1,0>,1 hollow
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,2>*2.5  translate<-0.9,0,0.5>
                       }
                finish {ambient 1 diffuse 0} }
       scale 10000 }
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   50
      color      White*0.9
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }

// ground ------------------------------------------------------------
plane { <0,1,0>, 0
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
                 normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

union{
//  Scattering media  - streuendes Medium
//  steam + smoke     - Dampf + Rauch
// A transparent sphere containing media
sphere{ <0,0,0>, 1.5  // increased from 1 to 1.5, because of the turbulent pattern !!!
        pigment { rgbt 1 }
        hollow

 interior{ //---------------------
    media{ method 3
           emission <1,1,1>*0.4
           scattering{ 1, // Type 1 = isotropic scattering, 2 = Mie haze, 3 = Mie murky
                          // Type 4 = Rayleigh scattering,  5 = Henyey-Greenstein scattering
                       <1,1,1>*6.00   // color of scattering haze
                       extinction  1.50  //  // 0 ~ 1 extinction
                       // how fast the scattering media absorbs light
                       // useful i.e. when the media absorbs too much light
                    // eccentricity i.e. -0.6 ~ +0.6 (if type>1 )
           } // end scattering

           density{ spherical // or: boxed
                    scale 0.9
                    turbulence 0.85
                    color_map {
                    [0.00 rgb 0] // density at the border of the media
                    [0.05 rgb 0]
                    [0.20 rgb 0.2]
                    [0.30 rgb 0.6]
                    [0.40 rgb 1]
                    [1.00 rgb 1] // densitiy at the center of the media
                               } // end color_map
           } // end of density

           samples 20    // >=1, higher = more precise
           //intervals 1     //
           //confidence 0.9  //
     } // end of media ----------------------------------------------------------------------
  } // ------------------ end of interior
 scale 1
 rotate<0,0,0>
 translate < -0.5, 1.50 + 0.20,0>
} //------------------ end of steam + smoke

// the smoke stack:

cone { <0,0,0>,0.1, <0,1.50,0>,0.08
           texture { pigment { color rgb<1,1,1> }
                     finish  { phong 0.5 }
                   } // end of texture
           scale <1,1,1> rotate<0,0,-6>
      } // end of cylinder -------------------------------------



translate<0.8,0,-0.8>
} // end of smoke stack + steam --------------------------------//





