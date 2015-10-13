// PoVRay 3.7 Scene File "IsoWater_001.pov"
// author: Friedrich A. Lohmueller, April-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <0.0 , 3.0 ,-9.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.5 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <10.0 , 12.5 ,-5.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 50        // top view
                            location  <0.0 , 30.0 ,-0-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<-1500,1500,-1500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.25, 0.30, 1.0>*0.7]
                                     [0.50 rgb <0.25, 0.30, 1.0>*0.7]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   150
      color      White
      fog_offset 0.1
      fog_alt    2.5
      turbulence 1.8
    }
// -------------------------------------------------------------------



//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#declare Water_Texture = //texture{pigment{ White} } //
                         texture{Polished_Chrome }
// pigment for isosurface modulation
// and pigment pattern for normal
#declare Pigment_01 =
pigment { bumps
          turbulence 0.2
          scale <3,1,1>
          translate<-1.25,0,-0.7>
          //rotate<0,-30,0>
} // end pigment
//---------------------------------------
#declare Pigment_Function_01 =
function {
  pigment { Pigment_01 }
} // end of function
//---------------------------------------
// sizes x/z of isosurface container box
#local Scale_x = 10;
#local Scale_z = 7;
#local Iso_Start =<-Scale_x,-1.0,-Scale_z>;
#local Iso_End   =< Scale_x, 1.0, Scale_z>;
//---------------------------------------

isosurface {

  function{
    y
   -Pigment_Function_01(x, y, z).gray* 0.95
  } //

  contained_by { box {Iso_Start,Iso_End} }
  accuracy 0.01
  max_gradient 2

  texture{ Water_Texture  // pigment{ White}
           normal { pigment_pattern {  Pigment_01 } }
         // finish { phong 1}
         }
  // dont scale this isosurface!
  // scale the Pigment_01 if necessary!
translate <0, -0.3 , 0>}
// end of isosurface ------------------------------

//---------------------------------------------------



difference{

plane{<0,1,0>, 0 }
box { Iso_Start,Iso_End  }

      texture{  Water_Texture // pigment{ White }
               normal { pigment_pattern {  Pigment_01 }, 5 }
              //  finish { phong 1 }
              }
     translate<0,0.0,0>
     }
/*
// isosurface borders shown by wire frame
object{ // Wire_Box(A, B, WireRadius, UseMerge)
        Wire_Box(Iso_Start,Iso_End , 0.05 , 0)

        texture{ pigment{ color rgb<1,0.65,0.0>}
               }
        scale<1,1,1>  rotate<0, 0,0> translate<0,0.1,0>
      } // ---------------------------------------------
  */
// shape of a ship
#declare S_Shape_1 =
// linear prism in y-direction: from .. ,to ..,number of points (first = last)
prism { conic_sweep
        cubic_spline
        0.00 ,4.00 , 9

        <-0.50,  1.00>,
        <-0.50,  0.50>,
        < 0.00, -0.75>,
        < 0.50,  0.00>,
        < 0.20,  1.50>,
        < 0.00,  1.70>,
        <-0.20,  1.50>,
        <-0.50,  0.50>,
        < 0.00, -0.75>
        scale <1,0.25,1>
      } // end of prism --------------------------------------------------------

#declare S_Shape_2 =
// linear prism in y-direction: from .. ,to ..,number of points (first = last)
prism { conic_sweep
        cubic_spline
        0.00 ,2.01 , 9

        <-0.50,  1.00>,
        <-0.50,  0.50>,
        < 0.00, -0.75>,
        < 0.50,  0.00>,
        < 0.20,  2.00>,
        < 0.00,  2.50>,
        <-0.20,  2.00>,
        <-0.50,  0.50>,
        < 0.00, -0.75>
        scale <1,1,1> translate<0,-1.00,0>
      } // end of prism --------------------------------------------------------



// ship
intersection{
  object{ S_Shape_1 }
  object{ S_Shape_2 }
  box{<-2,-0,-2>,<2,1.1,3.80>
     matrix<1, 0,   0, // matrix-shear_y_to_z
            0, 1,-0.15,
            0, 0, 1,
            0, 0, 0>
     }
  texture{ pigment{ color White*1.2}
           finish { phong 1.0 reflection{ 0.3 metallic 0.3}}
         }
  scale <2,3,2>*1
  rotate<2,0, 2>
  rotate< 0,-60,0>
  translate<1.20,-1.50,-2.00>
} // end of union
