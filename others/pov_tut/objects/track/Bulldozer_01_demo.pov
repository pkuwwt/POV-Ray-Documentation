// PoVRay 3.7 Scene File "Bulldpzer_01_demo.pov"
// author: Friedrich A. Lohmueller, Nov-2006/Aug-2009/Jan-2011
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 40      // front view
                            location < 0.00, 3.00,-5.00>
                            right     x*image_width/image_height
                            look_at   < 0.10, 1.30, 0.00>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <2.0 , 2.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<-1500,2500,-2500> color White}
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
fog{fog_type   2
    distance   100
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
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





//-----------------------------------------------------------------------------
//----------------------------------------------------------------------------- bulldozer textures
#local Body_Texture =  
        texture { pigment{ color rgb< 1.0, 0.65, 0.0> } //  deep yellow 
               // normal { bumps 0.5 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Chassis_Texture =  
        texture { pigment{ color rgb< 1.0, 1, 1>*0.35 } //  gray
                  normal { bumps 0.15 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Scoop_Texture = 
        texture{ Chrome_Metal
                 finish { diffuse 0.9 phong 1 }
                 normal { bumps 0.05 scale 0.0025}
               } // end of texture ---------------------------  
 

#local Chain_Color =  color rgb< 1, 1, 1>*0.65;     // base color of the chains
#local Wheel_Texture =  texture { pigment{ color rgb< 1, 0.75, 0.50>*0.5 } // brown 
                                  normal { bumps 0.5 scale 0.01 }
                                  finish { phong 1 reflection 0.00}
                                } // end of texture 

//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
#include "Bulldozer_01.inc"
//-----------------------------------------------------------------------------
object{ Bulldozer_01(  10, // Scoop_Angle_,  // 0~15  winkel der Baggerschaufel !!!
                       1, // Scoop_ON_, // 1= on, 0 = off
                       Body_Texture,  // 
                       Chassis_Texture,  // 
                       Scoop_Texture, // 
                       Chain_Color,  // base color of the chains  
                       Wheel_Texture //  texture of the wheels  
                    )  //------------------------------------------  
        scale <1,1,1> 
        rotate<0,60,0> 
        translate<1.75,0,5> }//---------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
object{ Bulldozer_01(  0, // Scoop_Angle_,  // 0~15  winkel der Baggerschaufel !!!
                       1, // Scoop_ON_, // 1= on, 0 = off
                       Body_Texture,  // 
                       Chassis_Texture,  // 
                       Scoop_Texture, // 
                       Chain_Color,  // base color of the chains  
                       Wheel_Texture //  texture of the wheels  
                    )  //------------------------------------------  
        scale <1,1,1> 
        rotate<0,40,0> 
        translate<-1,0,2> }//---------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------



object{ Bulldozer_01(  0, // Scoop_Angle_,  // 0~15  winkel der Baggerschaufel !!!
                       0, // Scoop_ON_, // 1= on, 0 = off
                       Body_Texture,  // 
                       Chassis_Texture,  // 
                       Scoop_Texture, // 
                       Chain_Color,  // base color of the chains  
                       Wheel_Texture //  texture of the wheels  
                    )  //------------------------------------------  
        scale <1,1,1> 
        rotate<0,-10,0> 
        translate<-2,0,8> }//---------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------







