// POV-Ray 3.6 / 3.7 Scene File "povroc2.pov"
// author: Friedrich A. Lohmueller, Aug-2005/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
global_settings { noise_generator 1 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
// camera -----------------------------------------------------
#declare Cam0 =camera {ultra_wide_angle angle 115
                       location  <0.0 , 1.0 ,-4.0>
                       right     x*image_width/image_height
                       look_at   <0.0 , 3.0 , 0.0>}
camera{Cam0}
// sun --------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky --------------------------------------------------------
plane{ <0,1,0>,1 hollow rotate<0.1,0,0>
       //keep attention: place sun lower than the sky
       texture{ pigment{ Bright_Blue_Sky translate <2,0,0>}
                finish { ambient 1 diffuse 0}} 
       scale 10000}
// ground -----------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment { color rgb <0.80,0.55,0.35>}
                normal  { bumps 0.5 scale 0.025  }
                finish  { phong 0.1} 
              } // end of texture
     } // end of plane

fog { fog_type   2
      distance   100
      color      White  
      fog_offset 0.1
      fog_alt    2.5
      turbulence 1.8
    }
//-------------------------------------------------------------
//-------------------------------------------------------------
#declare Engine =
union{
cone{<0,0,0>,0.5,<0,1.5,0>,0.25
      scale<1,1,0.7>  translate<0,0.5,0>
      texture{Chrome_Metal}}
prism{ -0.01 ,0.01 , 4
      <0.0, 0.0>, < 0.8,  0.0>, < 0.0,1.5>, <0.0, 0.0>
      rotate<-90,0,0> translate<0,0.5,0>
      texture {pigment{ color White }
               finish { phong 1.0}}}
difference{
 cone{<0, 0.10,0>,0.28,<0,0.50,0>,0.10}
 cone{<0, 0.09,0>,0.17,<0,0.49,0>,0.09}
 translate<0.22,0,0> texture{Chrome_Metal}
 }// end of difference
translate<0.25,0,0>} // all together somewhat excentric!

//------------ build the rocket -------------------------------
#declare Rocket =  union{  //-- 4 engines ---------------------
object{Engine rotate<0,  0,0> translate<0,0,0>}
object{Engine rotate<0, 90,0> translate<0,0,0>}
object{Engine rotate<0,180,0> translate<0,0,0>}
object{Engine rotate<0,270,0> translate<0,0,0>}
//----- the body ----------------------------------------------
cylinder {<0,0,0>,<0,5,0>,0.5 translate<0,0.5,0>
  texture {pigment{ color White}
           finish { phong 1.0}}}
// ----- with some details ------------------------------------
cylinder {<0,0,0>,<0,0.1,0>,0.505 translate<0,2.0,0>
          texture{Chrome_Metal}}
cylinder {<0,0,0>,<0,0.1,0>,0.505 translate<0,3.5,0>
          texture{Chrome_Metal}}
cylinder {<0,0,0>,<0,0.1,0>,0.505 translate<0,5.25,0>
          texture{Chrome_Metal}}
//------- the top part ----------------------------------------
cone{<0,0,0>,0.5,<0,1.5,0>,0.25 translate<0,5+0.5,0>
      texture{Chrome_Metal}}
//-------- the nose on top of the rocket ----------------------
sphere{<0,0,0>,0.25 scale <1,1.5,1>
       translate<0,5.00+1.50+0.50,0>
       texture{Chrome_Metal}}
}//--end of union ---------------------------------------------

//----------------- ready for take off:
object{Rocket
       rotate<0,0,0> translate<0,0,0>} //end of union
//--------------------------------------------------------- end


      
