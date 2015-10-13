// POV-Ray 3.6 / 3.7 Scene File "povoct1.pov"
// author: Friedrich A. Lohmueller, Aug-2005/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
// camera -------------------------------------------------------
#declare Cam0 =camera {ultra_wide_angle angle 30 
                       location <0.0 , 6.8 ,-6.0>
                       right    x*image_width/image_height
                       look_at  <0.0 , 0.8 , 0.0>}
camera{Cam0}
// sun ----------------------------------------------------------
light_source{<1500,2000,-2000> color rgb<1,1,1>}
// sky ----------------------------------------------------------
sphere{<0,0,0>,1 hollow 
       texture{pigment{gradient <0,1,0>
                       color_map{
                                 [0.00 color rgb<0.25,0.00,0.90>]
                                 [1.00 color rgb<1.00,1.00,1.00>]                                }
                      }
               finish {ambient 1 diffuse 0} 
              }
       scale 10000}
//====================== octagon ================================
intersection{
   box {<-1, 0.0,-1>,< 1,1.0,1> rotate<0,  0,0> }
   box {<-1,-0.1,-1>,< 1,1.1,1> rotate<0,45,0> }
   scale<0.5,2.5,0.5> 
   texture{ pigment { color rgb<1,0.7,0.45>*1.3}
            finish  { phong 1}
          }
   rotate<10,30,0>
   translate<1.1,-1.00,0>}
//====================== octagon with hole ======================
intersection{
    box {<-1, 0.0,-1>,< 1,1.0,1> rotate<0, 0,0> }
    box {<-1,-0.1,-1>,< 1,1.1,1> rotate<0,45,0> }
    cylinder{<0,-0.1,0>,<0,1.1,0>,0.5 inverse }
    scale<1,0.5,1> 
    texture{ pigment { color rgb<1,0.90,0.8>*1.3} 
             finish  { phong 1 }
           }
    rotate<0,-25,0>           
    translate<-0.7,0.50,0.5>}

//----------------------------------------- end -----------------

