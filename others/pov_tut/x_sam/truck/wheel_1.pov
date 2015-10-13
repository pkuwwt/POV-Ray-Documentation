// POV-Ray 3.6 / 3.7 Scene File "wheel_1.pov"
// author: Friedrich A. Lohmueller, June-2009/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de

// wheel - with and without #while statement
// Rad   - mit  und ohne #while-Anweisung
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
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.2 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 55   // diagonal view
                            location  < 2.50, 1.00,-2.50>
                            right     x*image_width/image_height
                            look_at  < 0.00, 1.20,  0.00>}
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
light_source{<-1500,2500,-2500> color White}
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


//-------------------------------------------------- wheel textures                            
#declare Tire_tex  =   // tires - Reifen - pneu - gomma - neumático
 texture{ pigment{ color rgb<1,1,1>*0.05}
          finish { phong 0.1 } }
#declare Rim_tex =     // rim - Felge - jante - cerchione - llanta
 texture{ Polished_Chrome        
          finish { phong 1.0 }}                        
#declare Spoke_tex =    // spokes - Speiche - rayon - raggio - rayo
 texture{ Polished_Chrome        
          finish { phong 1.0 }}                        
#declare Hub_tex =      // hub - Nabe - moyeu - mozzo - cubo
 texture{ Polished_Chrome        
          finish { phong 1.0 }}                        
//------------------------------------------------------------------------------

#declare Number_of_spokes = 12;
#declare W = 360/Number_of_spokes; // only without loop

//-------------------------------------------------- wheel, Rad,
union{ // (a)
torus{0.9,0.20 scale <1,1,1> rotate<90,0,0>
         texture{Rim_tex}} // rim
torus{1.0,0.25 scale <1,1,1> rotate<90,0,0>
         texture{Tire_tex}} // tire
cylinder {<0,0,-0.10>,<0,0, 0.10>,0.20
         texture{Hub_tex}} // hub
cylinder {<0,0,-0.12>,<0,0, 0.12>,0.15
         texture{Hub_tex}} // hub
//------------------- without #while loop: -----------<<1

 union{ // (b)
  #local Nr = 0;                    // start
  #local EndNr = Number_of_spokes; // end
  #while (Nr< EndNr) 
   cylinder{ <0,0,0>,<1,0,0>,0.05 
             texture{Spoke_tex} 
             rotate<0,0,Nr * 360/EndNr>} 
  #local Nr = Nr + 1;    // next Nr
  #end // ---------------  end of loop 
 } // end of union (b) 


//------------------- without #while loop: -----------<<1
/*
 union{ // (b)
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 0*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 1*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 2*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 3*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 4*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 5*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 6*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 7*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 8*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0, 9*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0,10*W>}
  cylinder {<0,0,0>,<1,0, 0>,0.05 rotate<0,0,11*W>}
  texture{Spoke_tex}
 } // end of union (b)
//----------------------------------------------------<<2
*/

translate<0,1.25,0> 
rotate<0, 0, 0>
} // end of union (a)
//---------------------------------------------- end ----














