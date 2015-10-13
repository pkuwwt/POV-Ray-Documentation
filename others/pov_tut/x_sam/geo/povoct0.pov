// POV-Ray 3.6 / 3.7 Scene File "povoct0.pov"
// author: Friedrich A. Lohmueller, Aug-2005/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
// camera -------------------------------------------------------
#declare Cam0 =camera {ultra_wide_angle angle 95 
                       location < 0.0, 1.8 , -2.0>
                       right    x*image_width/image_height
                       look_at  < 0.0, 0.8 ,  0.0>}
camera{Cam0}
// sun ----------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ----------------------------------------------------------
sphere{<0,0,0>,1 hollow 
       texture{pigment{gradient <0,1,0>
                       color_map{[0.00 color rgb<0.5,0.5,1>]
                                 [0.35 color rgb<0.5,0.5,1>]
                                 [0.50 color rgb<1,1,1>    ]
                                 [0.65 color rgb<0.5,0.5,1>]
                                 [1.00 color rgb<0.5,0.5,1>]}
                       scale 2 translate<0,-1,0>
                      }
               finish {ambient 1 diffuse 0} 
              }
       scale 10000}
// ground -------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment {color rgb <0.80,0.55,0.35>}
                normal  {bumps 0.75 scale 0.065  }
                finish  {ambient 0.1 diffuse 0.9 } 
              } // end of texture
     } // end of plane
//====================== octagon ================================
intersection{
   box {<-1, 0.0,-1>,< 1,1.0,1> rotate<0,  0,0> }
   box {<-1,-0.1,-1>,< 1,1.1,1> rotate<0,45,0> }
   scale<1,0.5,1> 
   texture{ Polished_Brass 
            normal {bumps 0.3 scale 0.02}
            finish {ambient 0.1 diffuse 0.9 phong 1}
          }
   translate<1.1,0.00,0>}
//====================== octagon with hole ======================
intersection{
    box {<-1, 0.0,-1>,< 1,1.0,1> rotate<0, 0,0> }
    box {<-1,-0.1,-1>,< 1,1.1,1> rotate<0,45,0> }
    cylinder{<0,-0.1,0>,<0,1.1,0>,0.5 inverse}
    scale<1,0.5,1> 
    texture{ Polished_Chrome 
             normal{bumps 0.3 scale 0.2}
             finish   {ambient 0.1 diffuse 0.9 phong 1}
           }
    translate<-1.1,0.50,0.5>}
//----------------------------------------- end -----------------
