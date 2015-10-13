// PoVRay 3.7 Scene File "Tree_10demo.pov"
// author: Friedrich A. Lohmueller, Jan-2006 /Aug-2009/Jan-2011
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
#declare Cam_Positon_0 = <0.0 , 1.0 ,-3.0>;
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 65      // front view
                            location  Cam_Positon_0
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
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
light_source{<1500,2500,-2500> color White*0.9}
light_source{  Cam_Positon_0   color White*0.1}

// sky -------------------------------------------------------------- 
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
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------




// 
// a street 
box { <-2.00, 0.00, -1000>,< 2.00, 0.001, 1000>   

      texture{ pigment{ color rgb<1,1,1>*0.3}
               normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture

      scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
    } // end of box --------------------------------------
// middle line of the street
union{
 #declare Nr = -500;   // start
 #declare EndNr = 500; // end
 #while (Nr< EndNr) 

   box { <-0.05, 0.00, 0>,< 0.05, 0.0015, 1.00>   

      texture{ pigment{ color rgb<1,1,1>*1.1}
             //normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.5}
             } // end of texture

        translate<0,0,Nr*2.00>} 

 #declare Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 

rotate<0,0,0> 
translate<0,0,0>} // end of union

//-------------------------------------------------------------------------------------// 
#include "Tree_10.inc" 
//-------------------------------------------------------------------------------------// 
#declare Tree = 
object{ Tree_10 
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00, 0.00, 0.00>}
//-------------------------------------------------------------------------------------// 
//-------------------------------------------------------------------------------------// 

#declare Random_1 = seed (34053); // Use: "rand(Random_1)"
#declare Random_2 = seed (62853); // Use: "rand(Random_2)"
#declare Random_3 = seed ( 8353); // Use: "rand(Random_3)"

// planting a row of trees: 
union{
 #declare Nr = -2;   // start
 #declare EndNr = 20; // end
 #while (Nr< EndNr+1) 

 object{ Tree 
         // scaled by random 
         scale 1 + 0.5*(-0.5*rand(Random_1)) // (0.75 ~ 1.25)
         // rotated by random
         rotate<10*rand(Random_2),30*(-0.5+rand(Random_2)),0>
         // translate + Random
         translate< 0.25*(-0.5+rand(Random_2)),0, Nr*2.25+0.5*rand(Random_2)>

       } // end of sphere ----------------------


 #declare Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 

rotate<0,0,0> 
translate<3.00,0,0>
} // end of union ---- end of row of trees
//----------------------------------------------------------------------------------









