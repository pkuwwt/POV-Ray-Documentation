// File created by LeoCAD
// Adapted to 1 unit = 1m
#version 3.7; 
global_settings{ assumed_gamma 1.0 } 
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//
#declare lg_quality = 4;
#include "lg_color.inc"
#include "lg_defs.inc"

#include "lg_3001.inc" // brick 2x4
 
// left handed, size 1 = 1 m. 
#declare L_Transform = transform{ rotate<-90,-90,0> // right to left: y->z and z->y 
                                  scale 0.01        // from 1=10 mm to 1=1m=1000mm
                                  translate<0,0.0094,0> // move up on the floor
                                }// end L_Transform 

camera { 
  right    x*image_width/image_height   
  location <-0.04, 0.05, -0.05>
  look_at < 0.00, 0.004, 0.00>
  angle 30
}

background { color rgb <1, 1, 1> }

light_source { <-10, 15,-20> White  }

object {
 lg_3001
 texture { lg_red }
 matrix <-1.0000, 0.0000, 0.0000, 0.0000, -1.0000, 0.0000, 0.0000, 0.0000, 1.0000, 0.0000, 0.0000, 0.0000>
 transform{ L_Transform } 
}
 
