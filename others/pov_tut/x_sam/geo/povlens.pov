// POV-Ray 3.6 / 3.7 scene file  "povlens.pov"
// author: Friedrich A. Lohmueller 2005/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 


// biconvex optical lens
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"      //  !!!! ---> T_Glass3 
// camera -------------------------------------------------------
camera {angle 75
        location  < 0.0 , 1.0,-3.0>
        look_at   <-0.3 , 1.0 , 0.0>}
// sun ----------------------------------------------------------
light_source{<1000,2500,-2500> color White}
// sky ----------------------------------------------------------
object{sphere {<0,0,0>,1 hollow }
          texture{pigment{ gradient <0,1,0>
                           color_map{[0.0 color White]
                                     [0.5 color CadetBlue]
                                     [1.0 color CadetBlue] }
                           quick_color White }
                  finish { ambient 1 diffuse 0}}
       scale 10000} // end of sphere
// ground -------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment { color rgb <0.85,0.55,0.30>}
                normal  { bumps 0.75 scale 0.035  }
                finish  { phong 0.1 } 
              } // end of texture
     } // end of plane
//---------------------------------------------------------------
#declare Ball =
 sphere{<0,0,0>,0.35 
        texture{pigment{ color rgb<1,0.65,0>}
                finish { phong 1}}}
//---------------------------------------------------------------
union{ // --- nur zur Demonstration der Linsenwirkung!
       // --- just for demonstration of the lens effect! 
 object{Ball translate<0,0,0>}
 object{Ball translate<0,0,1>}
 object{Ball translate<0,0,2>}
 object{Ball translate<0,0,3>}
 object{Ball translate<0,0,4>}
 object{Ball translate<0,0,5>}
 object{Ball translate<0,0,6>}
 object{Ball translate<0,0,7>}
 object{Ball translate<0,0,8>}
 object{Ball translate<0,0,9>}
 object{Ball translate<0,0,10>}
 object{Ball translate<0,0,11>}
 object{Ball translate<0,0,12>}
 object{Ball translate<0,0,13>}
 object{Ball translate<0,0,14>}
 object{Ball translate<0,0,15>}
 object{Ball translate<0,0,16>}
 object{Ball translate<0,0,17>}
 object{Ball translate<0,0,18>}
 object{Ball translate<0,0,19>}
 scale <0.4,0.75,0.75>
 rotate <0, 5, 0> translate <-1.9,0.5,0.0>}
//----------------------------------------------------------------
// --- nur zur Demonstration der Linsenwirkung!
// --- just for demonstration of the lens effect! 
box {<-1,-1,-1>,< 1,1,1>
     scale <1.5,0.75,0.75>
     rotate <0,35, 0> translate <1.75,1.2,4.0>
     texture{pigment{ Candy_Cane 
                      scale 0.5 translate <-2.0,0,0>
                      quick_color Orange}
             finish { phong 1}}}

//----------------------------------------------------------------
//---------------------------------------------- Linse - lens ----
#declare R   = 6.0;   //sphere radius       - Kugelradius
#declare Over= 0.1;   //sphere overlapping  - Kugelueberlappung
intersection{
 sphere{<0,0,0>,R  translate <0,0,-R+Over>}
 sphere{<0,0,0>,R  translate <0,0, R-Over>}
 texture{T_Glass3}
 interior{I_Glass3}
 translate < 0,1.2,0>}
//------------------------------------------------------- end ----


   




  




