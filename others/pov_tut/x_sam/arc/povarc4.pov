// POV-Ray 3.6 / 3.7 Scene File "povarc4.pov"
// author: Friedrich A. Lohmueller, Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
#include "stones.INC"
#include "stones2.INC"
// camera ----------------------------------------------------
#declare Cam0 =camera {/*ultra_wide_angle*/ angle 48
                       location  <4.0 , 1.0 ,-6.0>
                       right x*image_width/image_height
                       look_at   <0.0 , 1.5 , 0.0>}
camera{Cam0}
// sun -------------------------------------------------------
light_source{<1500,2500,-1000> color White}
// sky -------------------------------------------------------
sphere{<0,0,0>,1 hollow
       texture{pigment{gradient <0,1,0>
                       color_map{[0 color White]
                                 [1 color Blue ]}
                       quick_color White }
               finish     {ambient 1 diffuse 0} }
      scale 10000}
// ground ----------------------------------------------------
plane{ <0,1,0>, 0
       texture{ pigment { color rgb <0.80,0.55,0.35>}
                normal  { bumps 0.75 scale 0.065  }
                finish  { phong 0.1 }
              } // end of texture
     } // end of plane
//============================================================
//---------------- arch -------------------------------
#declare Arch = difference{
 box {<-1.1,0,-0.1>,< 1.1,1.1,0.1>}
 cylinder {<0,0,-0.11>,<0,0,0.11>,0.9 }
 texture{pigment{ color White}
         normal { bumps 0.4 scale 0.007}
         finish { phong 1}}
}//-----------------------------------------------------------
//------------- pillars --------------------------------------
#declare Pillar = union{
 torus{0.10,0.05 translate<0,1.45,0>}
 torus{0.12,0.05 translate<0,0.04,0>}
 cone {<0,0,0>,0.12,<0,1.5,0>,0.1}
 texture{pigment{color White}
         normal{bumps 0.4 scale 0.007}
         finish {ambient 0.1 diffuse 0.8 phong 1}}
}//-----------------------------------------------------------
union{
union{// --------arch upon pillars ---------------------------
object{Pillar translate<-1,0,-1>}
object{Pillar translate< 1,0,-1>}
object{Pillar translate<-1,0, 1>}
object{Pillar translate< 1,0, 1>}
object{Arch rotate<0, 0,0> translate< 0,1.5, 1>}
object{Arch rotate<0, 0,0> translate< 0,1.5,-1>}
object{Arch rotate<0,90,0> translate< 1,1.5, 0>}
object{Arch rotate<0,90,0> translate<-1,1.5, 0>}
translate<0,0.45,0>} // ------------------------ -------------

union{ // -------------------- steps -------------------------
box{<-1.20,0.30,-1.20>,<1.20,0.45,1.20>}
box{<-1.50,0.15,-1.50>,<1.50,0.30,1.50>}
box{<-1.80,0.00,-1.80>,<1.80,0.15,1.80>}
 texture{T_Stone8 scale 0.3 pigment{quick_color White}
         normal{bumps 0.4 scale 0.007}
         finish {ambient 0.05 diffuse 0.9 phong 1}}
 }//----------------------------------------------------------
scale <1,1,1> rotate<0,0,0> translate<0,0,0>}

//-------------------------------------------------end -------