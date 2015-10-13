// PoVRay 3.7 Scene File "Helicopter_01_demo.pov"
// author: Friedrich A. Lohmueller, Nov-2006/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <0.0 , 1.0 ,-30.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 5.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 35 // diagonal view
                            location   <30.0, 20.0,-25.0>
                            right     x*image_width/image_height 
                            look_at  < -1.20, 5.10, -3.00>
                            rotate <0,0, -32> }
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <30.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 30.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1>*5.5  translate< -1,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   250
      color      White  
      fog_offset 0.1
      fog_alt    3.5
      turbulence 1.8
    }
// sea ---------------------------------------------------------------------
plane{<0,1,0>, 0 
       texture{Polished_Chrome
               normal { crackle 0.15 scale <0.35,0.25,0.25> turbulence 0.5 } 
               finish { reflection 0.60}}}

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
#declare Body_Texture = 
         texture { //Chrome_Metal 
                   pigment{ color rgb< 1.0, 0.6, 0.05> } //  light orange
                   normal { bumps 0.15 scale 0.45 }
                   finish { phong 0.3 reflection 0.00}
                 } // end of texture 
#declare Inside_Texture = 
         texture { pigment{ color rgb< 1, 1, 1>*0.75 } //  color Gray75
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 0.1}
                 } // end of texture 
#declare Seat_Texture = 
         texture { pigment{ color rgb< 1, 0.85, 0.75>*1.1  }// very light brown  
                   normal { bumps 0.5 scale 0.025 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 

//--------------------------------------------------------------------------
#include "Helicopter_01.inc"
//--------------------------------------------------------------------------
object{ Helicopter_01 ( 10,// Rotor_Rotation, // main rotor 
                        100,// Backside_Rotor_Rotation, // main rotor 

                        Body_Texture, 
                        Inside_Texture, 
                        Seat_Texture
                      ) //-------------------------------------------
scale <1,1,1> 
rotate<8,0,-14> 
translate<10,4.5,-11>} 
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
object{ Helicopter_01 ( 10,// Rotor_Rotation, // main rotor 
                        100,// Backside_Rotor_Rotation, // main rotor 

                        Body_Texture, 
                        Inside_Texture, 
                        Seat_Texture
                      ) //-------------------------------------------
scale <1,1,1> 
rotate<0,0,-12> 
translate<-1,5.0,5>} 
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
object{ Helicopter_01 ( 10,// Rotor_Rotation, // main rotor 
                        100,// Backside_Rotor_Rotation, // main rotor 

                        Body_Texture, 
                        Inside_Texture, 
                        Seat_Texture
                      ) //-------------------------------------------
scale <1,1,1> 
rotate<0,0,-5> 
translate<-13,4.0,25>} 
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
