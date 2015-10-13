// POV-Ray 3.6 / 3.7 Scene File "povegg0.pov"
// author: Friedrich A. Lohmueller,2005/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
// camera ----------------------------------------------
camera { angle 55
         location  <0.0 , 1.5 ,-5.0>
         look_at   <0.0 , 1.3 , 0.0>}
// sun -------------------------------------------------
light_source{<1000,1500,-2500> color White}
// sky -------------------------------------------------
sphere{<0,0,0>,1 hollow
       texture{pigment{gradient <0,1,0>
                       color_map{[0.00 color Blue ]
                                 [0.25 color Blue ]
                                 [0.50 color White]
                                 [0.75 color Blue ]
                                 [1.00 color Blue ]}
                       scale 2 translate<0,-1,0>}
               finish {ambient 1 diffuse 0}} 
       scale 10000}
//------------------------------------------------------
#declare Egg_Tex =                            //  <-----1
   texture{ pigment{ color White}
            normal { bumps 0.4 scale 0.01}
            finish { phong 0.1}}
//-------------------------------------------//  <-----2
#declare Egg_upperpart =
intersection{
 sphere{<0,0,0>,1 scale<1,1.75,1>}
 box{<-1,0,-1>,<1,1.75,1>}
 }//--------------------------------
#declare Egg_lowerpart =
intersection{
 sphere{<0,0,0>,1 scale<1,1,1>}
 box{<-1,-1,-1>,<1,0,1>}
 }//--------------------------------
#declare Egg =
union{ object{Egg_upperpart}
          object{Egg_lowerpart}
          texture{Egg_Tex}
 }//----------------------------------------------------
object{ Egg_upperpart  translate<-1.1,1.1,0>        //  <----3
          texture{Egg_Tex}}

object{ Egg_lowerpart translate<-1.1,0.9,0>
        texture{Egg_Tex}}

object{ Egg       translate< 1.1,1.0,0>}
//--------------------------------------------- end ----
