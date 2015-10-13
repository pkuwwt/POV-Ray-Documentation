// POV-Ray 3.6 / 3.7 Scene File "Tubes_000_2.pov"
// author: Friedrich A. Lohmueller, June-2009
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#if (version < 3.7) global_settings{ assumed_gamma 1.0 } #end
#default{ finish{ ambient 0.11 diffuse 0.9 }}
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <0.0 , 1.0 ,-7.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 40   // diagonal view
                            location  <9.00, 8.00,-10.00>
                            right     x*image_width/image_height
                            look_at   < 2.00, 2.50,  0.00>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<-500,2500,-2500> color White}
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
fog { fog_type   2
      distance   150
      color      White*0.8
      fog_offset 0.1
      fog_alt    5.5
      turbulence 1.8
    }
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0
       texture{ pigment{ color rgb <1.00,0.95,0.8>}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 }
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

// ------------------------------------------- optional textures
#declare Tube_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { pigment_pattern{radial frequency 120 ramp_wave
                                         color_map {[0.0, rgb 0]
                                                    [0.5, rgb 0.05]
                                                    [1.0, rgb 0]}
                                         rotate<90,0,0> scale 0.5} 0.05}
                  //  normal { bumps 0.01 scale <0.005,0.15,0.15> }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Tube_Inside_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Flange_Texture_1 =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Flange_Texture_2 =
          texture { pigment{ color rgb< 1, 1, 1>*0.65 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Flange_Hole_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Nut_Texture_1 =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Nut_Texture_2 =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
//-------------------------------------------------------------------------------
#include "Tube_Round_000.inc"
//-------------------------------------------------------------------------------
#declare Tube_Rmaj1 = 1.20;
#declare Tube_R1   = 0.500;
#declare Flange_R1 = 0.650;
#declare Flange_D = 0.050;
#declare Tube_L1 = 5;
#declare Tube_L2 = 2.0;
#declare Tube_LT = 1;

#declare Tube_90 =
object{ Tube_Round_000 (
                   90, // Tube_Angle
                   Tube_Rmaj1, // T_Rmaj, // tube  major radius around z (lefthanded!)
                   0.015, // T_D, // tube material thickness
                   Tube_R1, // T_R, // radius
                   Flange_R1, // F_R, // flange radius
                   Flange_D, // F_D, // flange thickness
                   0.005, // FB_R, // Flange_Border_Radius
                   1, // Nuts_ON  // 0 = no nuts but holes; 1 = nuts - no holes
                   0.065, // Nut_Scale
                   16, // Number_of_Nuts
                ) // ------------------------------------
      }//--------------------------------------------------------------------------
//--------------------------------------------------------------------------------
// ------------------------------------------- optional textures
#declare Tube_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.005 scale <0.005,0.15,0.15> }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
//-------------------------------------------------------------------------------
#include "Tube_Linear_000.inc"
//-------------------------------------------------------------------------------
#declare Tube_Lin1=
object{ Tube_Linear_000 (
                   Tube_L1 , // T_L, // tube lenght in x
                   0.015, // T_D, // tube material thickness
                   Tube_R1, // T_R, // radius
                   Flange_R1, // F_R, // flange radius
                   Flange_D, // F_D, // flange thickness
                   0.005, // FB_R, // Flange_Border_Radius
                   1, // Nuts_ON  // 0 = no nuts but holes; 1 = nuts - no holes
                   0.065, // Nut_Scale
                   16, // Number_of_Nuts
                ) // ------------------------------------
      }//--------------------------------------------------------------------------
#declare Tube_Lin2=
object{ Tube_Linear_000 (
                   Tube_L2 , // T_L, // tube lenght in x
                   0.015, // T_D, // tube material thickness
                   Tube_R1, // T_R, // radius
                   Flange_R1, // F_R, // flange radius
                   Flange_D, // F_D, // flange thickness
                   0.005, // FB_R, // Flange_Border_Radius
                   1, // Nuts_ON  // 0 = no nuts but holes; 1 = nuts - no holes
                   0.065, // Nut_Scale
                   16, // Number_of_Nuts
                ) // ------------------------------------
      }//--------------------------------------------------------------------------
#declare Tube_LinT=
object{ Tube_Linear_000 (
                   Tube_LT , // T_L, // tube lenght in x
                   0.015, // T_D, // tube material thickness
                   Tube_R1, // T_R, // radius
                   Flange_R1, // F_R, // flange radius
                   Flange_D, // F_D, // flange thickness
                   0.005, // FB_R, // Flange_Border_Radius
                   1, // Nuts_ON  // 0 = no nuts but holes; 1 = nuts - no holes
                   0.065, // Nut_Scale
                   16, // Number_of_Nuts
                ) // ------------------------------------

        rotate<0,0,0>
        translate<0,0,0>
      }//--------------------------------------------------------------------------
//--------------------------------------------------------------------------------

// all together
#declare Line =
union{
object{ Tube_Lin1 translate<-9*Tube_L1, 0,0> }
object{ Tube_Lin1 translate<-8*Tube_L1, 0,0> }
object{ Tube_Lin1 translate<-7*Tube_L1, 0,0> }
object{ Tube_Lin1 translate<-6*Tube_L1, 0,0> }
object{ Tube_Lin1 translate<-5*Tube_L1, 0,0> }
object{ Tube_Lin1 translate<-4*Tube_L1, 0,0> }
object{ Tube_Lin1 translate<-3*Tube_L1, 0,0> }
object{ Tube_Lin1 translate<-2*Tube_L1, 0,0> }
object{ Tube_Lin1 translate<-1*Tube_L1, 0,0> }

object{ Tube_90  translate<      0, Tube_Rmaj1,0>}
object{ Tube_Lin2 rotate<0,0,90 > translate< Tube_Rmaj1  , Tube_Rmaj1        ,0> }
object{ Tube_90  rotate<0,0,180 > translate< Tube_Rmaj1*2, Tube_Rmaj1+Tube_L2,0> }

object{ Tube_LinT rotate<0,0,0 > translate< Tube_Rmaj1*2 , Tube_Rmaj1*2+Tube_L2,0> }

object{ Tube_90   rotate<0,0, 90 > translate< Tube_Rmaj1*2+Tube_LT, Tube_Rmaj1+Tube_L2,0> }
object{ Tube_Lin2 rotate<0,0, 90 > translate< Tube_Rmaj1*3+Tube_LT, Tube_Rmaj1,0> }
object{ Tube_90   rotate<0,0,-90 > translate< Tube_Rmaj1*4+Tube_LT, Tube_Rmaj1,0> }

union{
 object{ Tube_Lin1 translate<0*Tube_L1, 0,0> }
 object{ Tube_Lin1 translate<1*Tube_L1, 0,0> }

 translate<Tube_Rmaj1*4+Tube_LT, 0,0> }
} // end union
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------

object{ Line translate<0,0.65,0>}
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------






