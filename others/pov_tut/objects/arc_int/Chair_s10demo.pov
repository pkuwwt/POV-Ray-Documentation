// PoVRay 3.7 Scene File "Chair_s10demo.pov"
// author: Friedrich A. Lohmueller, May-2006/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
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
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 65          // front view
                            location  <0.0 , 1.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.3 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 22       // diagonal view
                            location <-2.00, 2.00,-3.00>
                            right     x*image_width/image_height
                            look_at   < 0.00, 0.90, -1.00>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90     // right side view
                            location  <2.90 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera { ultra_wide_angle  angle 210            // top view
                            location  <0.50 , 2.40 , 0.500>
                            right     x*image_width/image_height
                            look_at   <0.50 , 1.0  , 0.501>}
camera{Camera_1}

// sun -------------------------------------------------------------------------
//light_source{<1500,2500, 2500> color White*0.7}

// sky ---------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   50
      color      White  
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }

// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72}
	         normal { bumps 0.75 scale 0.015}
                 finish { phong 0.1}
               } // end of texture
      } // end of plane


//------------------------------------------------------------- inside:
#declare Room_Height = 2.50;
#declare Room_X_half = 3.00;
#declare Room_Z_half = 3.00;
#declare Wall_D = 0.20;

// the room 
difference{ 
box { <-Room_X_half -Wall_D, 0.00,-Room_Z_half -Wall_D>,< Room_X_half + Wall_D, Room_Height+Wall_D, Room_Z_half +Wall_D>   
      hollow 
      texture { pigment{ color rgb<1,1,1>}
                normal { bumps 0.5 scale 0.002}
                finish { phong 0.1}
              } // end of texture

      scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
    } // end of box --------------------------------------
box { <-Room_X_half, 0.00, -Room_Z_half>,< Room_X_half, Room_Height,  Room_Z_half>   
      hollow 
      texture { pigment{ color rgb<1,1,1>}
                normal { bumps 0.5 scale 0.002}
                finish { phong 0.1}
              } // end of texture

      scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
    } // end of box --------------------------------------

// the door hole
box { <-0.50 0.00, -0.01>,< 0.50, 2.00,  Wall_D+0.01>   
      texture { pigment{ color rgb<1,1,1>}
                normal { bumps 0.5 scale 0.002}
                finish { phong 0.1}
              } // end of texture

      scale <1,1,1> rotate<0,0,0> translate<-1.50, 0, Room_Z_half> 
    } // end of box --------------------------------------

// the window hole
box { <-1.00 0.80, -0.01>,< 1.00, 2.00,  Wall_D+0.01>   
      texture { pigment{ color rgb<1,1,1>}
                normal { bumps 0.5 scale 0.002}
                finish { phong 0.1}
              } // end of texture

      scale <1,1,1> rotate<0,0,0> translate<0.50, 0, Room_Z_half> 
    } // end of box --------------------------------------

}// end of difference ------------------------------------

// ----------------------------
// floor inside
box { <-Room_X_half, 0.00, -Room_Z_half>,< Room_X_half, 0.001, Room_Z_half>   
      hollow 
      texture { pigment{ checker color rgb <1,1,1>*1.1 color rgb<1,1,1>}
                finish { phong 0.1}
                scale 0.25
              } // end of texture

      scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
    } // end of box --------------------------------------
//  ceiling 
box { <-Room_X_half,-0.001, -Room_Z_half>,< Room_X_half, 0.00, Room_Z_half>   
      hollow 
      texture { pigment{ color rgb <1,1,1>*1.0}
                normal { bumps 0.15 scale 0.005}
                finish { ambient 0.4 diffuse 0.5 phong 0.1}
                scale 0.25
              } // end of texture

      scale <1,1,1> rotate<0,0,0> translate<0,Room_Height,0> 
    } // end of box --------------------------------------

// soft light (areal_light) ---------  An area light (creates soft shadows)
// WARNING: This special light can significantly slow down rendering times!
light_source { <0,0,0>          
               color rgb <1,1,1>     // light's color 
               area_light            // kind of light source (Art der Lichtquelle)
               <-1, 0, -1> <1, 0,1> // lights spread out across this distance (x * z)
               5, 5                // total number of lights in grid (4x*4z = 16 lights)
               adaptive 4          // 0,1,2,3...
               jitter              // adds random softening of light
               translate <0, 2, -0>   // <x,y,z> position of light
             } //---------------- end of area_light 




//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


//----------------------------------------------------------------------------
//----------------------------------------------------------------- textures
#declare Chair_Texture = 
       texture{ pigment{ color rgb< 0.75, 0.6, 0.45>*0.55 }  
                finish { phong 1 } 
              } // end of texture  
//----------------------------------------------------------------------------
#include "chair_s10.inc"
//----------------------------------------------------------------------------
object{ Chair_s10 ( 0.45, // Seat_Height, 
                    0.225,// Chair_Half_Width 
                    0.015,// Chair_Feet_Radius,
                  ) //---------------------------- 
        texture{ Chair_Texture } 
        scale <1,1,1> rotate<0,0,0> translate< 0.50,0.00,0.00>
      } //--------------------------------------------------------------------
//----------------------------------------------------------------------------
object{ Chair_s10 ( 0.45, // Seat_Height, 
                    0.225,// Chair_Half_Width 
                    0.015,// Chair_Feet_Radius,
                  ) //------------------------------------------
        texture{ Chair_Texture } 
        scale <1,1,1> rotate<0,60,0> translate< 1.500,0.00,0.00>}
//----------------------------------------------------------------------------
