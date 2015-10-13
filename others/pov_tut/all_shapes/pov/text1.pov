// POV-Ray 3.6/3.7 Scene File "text1.pov"
// author: Friedrich A. Lohmueller, 2001/Aug-2009/2011
// email:  Friedrich.Lohmueller_at_t-online.de 
// homepage: http://www.f-lohmueller.de
//------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//------------------------------------------
#include "colors.inc"
#include "textures.inc"
// camera -----------------------------------------------------------
#declare Cam0 = camera {ultra_wide_angle angle 190 
                        location  <0.0 , 1.1 ,-1.5>
                        look_at   <0.0 , 1.05 , 0.0>}
#declare Cam1 = camera {ultra_wide_angle angle 180 
                        location  <2.0 , 2.5 ,-3.0>
                        look_at   <0.0 , 1.0 , 0.0>}
camera{Cam0}
// sun ---------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------
sphere{<0,0,0>,1 hollow 
              texture{pigment{gradient <0,1,0>
                              color_map{[0 color White]
                                        [1 color Blue ]}
                              quick_color White }
                      finish {ambient 1 diffuse 0}
                     } 
           scale 10000}
//--------------------------------------------------------------------
union{
text{ttf "arial.ttf", "text object",1000, 0 
     texture{ pigment{ color rgb<1,0.8,0.4>}
              finish { ambient 0.45 diffuse 0.55 phong 1 reflection 0.4}}
     translate<0,0,0.5> }
text{ttf "arial.ttf", "text object",0.2, 0 
     texture{ Polished_Chrome pigment{color rgb<1,0,0.2>}
              finish { phong 1 reflection 0.6}}
     }     
text{ttf "arialnb.ttf", "text object",0.2, 0.25 
     texture{ pigment{ color rgb<1,0.8,0.4>}
              finish { phong 1 reflection 0.3}}
     scale<0.7,1,1>*0.5
     translate<1.1,-1.7,-0.21> }

    
     
     translate<-2.2,2.1,2>}


text{ttf "arial.ttf", "text object",1, 0 
     texture{ pigment{ color rgb<1,0.7,0.2>}
              finish { phong 1 reflection 0.2}}
     rotate<0,0,0> scale<0.35,1.5,1,> translate<0.4, 0.2,1.6> }     

// ground ------------------------------------------------------------
difference{
plane{<0,1,0>, 0 
      texture{ pigment{ YellowGreen }
               finish { phong 0.1}}}
text{ ttf "arialnb.ttf", "text",0.3, 0 
      texture{ pigment{ color rgb<1,0.9,0.5>}
               finish { phong 1 reflection 0.1}}
      scale 2.3
      rotate<90,0,0>
     
      translate<-1.7,0.01,0.5>}
}//--------------------------------------------------------------- end
