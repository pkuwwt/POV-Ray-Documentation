// File created by LeoCAD
#version 3.7; 
global_settings{ assumed_gamma 1.0 } 
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "Brick_Test1.inc"

camera {
  sky<0.235702,0.235702,0.942809>
  location <-10.7071, -8.72721, 6.13137>
  look_at <-0.707107, 1.27279, 1.13137>
  angle 30
}

background { color rgb <1, 1, 1> }

light_source { <0, 0, 20> White shadowless }

object {
 lg_3001
 texture { lg_red }
 matrix <-1.0000, 0.0000, 0.0000, 0.0000, -1.0000, 0.0000, 0.0000, 0.0000, 1.0000, 0.0000, 0.0000, 0.0000>
}
