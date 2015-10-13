// PoVRay 3.7 Scene File "Demo_cone01.pov"
// author:  .Friedrich A. Lohmueller, Jan-2014
// homepage: http://www.f-lohmueller.de/
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 45      // front view
                            location  <0.0 , 1  ,-5.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1 , 0.0>}
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
light_source{<-1500,1000,-2500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< -2,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   150
      color      White *0.7 
      fog_offset 0.1
      fog_alt    3.5
      turbulence 1.8
    }
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <1.00,0.95,0.8>}
                normal { bumps 1.25 scale 0.05  }
                finish { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

cone{ <0,0,0>, 1, <0,1.75,0>, 0.4 
      texture{
         pigment {color rgb<0.4,0.7,0> }
         finish { phong 1}
       } 
      translate<0,0.0,0>
    }
      
cone{ <0,0,0>, 0.50, <0,1.8,0>, 0.00 
      rotate<0, 0, 0>
      translate<1 , 0,-1.2>
      texture{ 
          pigment{ color rgb<1,0.6,0>} 
         // normal { bumps 0.7 scale 0.05 } 
          finish { phong 1} 
        } 
    }
//--------------------------------------------------------------------------
