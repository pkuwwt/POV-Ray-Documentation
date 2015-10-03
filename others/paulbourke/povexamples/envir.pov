#include "colors.inc"
sky_sphere {
   pigment {
      gradient y
      color_map {   
         [0.0 color blue 0.6] 
         [1.0 color rgb 1] 
      }
   }
}
plane {
   y, -1
   texture {
      pigment {  
         color rgb <0.8, 0.8, 0.4> 
      }
      normal {
         crackle 0.5 
         turbulence 0.2 
         scale 0.5
      }
   }
}
sphere { 
   0.0, 1 
   texture {
      pigment {
         radial frequency 8
      } 
      finish {
         specular 1
      }
   }
   translate 4*z 
}
torus { 
   0.8, 0.2
   texture {
      pigment { 
         spotted 
         color_map {
            [  0.1  color red 0.0 green 0.0 blue 0.0]
            [  0.3  color red 0.8 green 0.4 blue 0.2]
            [  0.5  color red 0.0 green 0.0 blue 0.0]
            [  0.7  color red 0.0 green 0.0 blue 0.8 filter 0.5]
            [  1.0  color red 0.8 green 0.8 blue 0.8 filter 1.0]
         } // color_map
         scale 0.2
      }
   }
   rotate 90*x
   scale 3
   translate 5*z - 4*x
}
box {
   <-1, -1, -1>
   < 1,  1,  1>
   texture {
      pigment { 
			color rgb <0.9, 0.8, 0.7> 
		}
      normal {
			crackle 0.5 
			turbulence 0.2 
			scale 0.2
		}
  }
  rotate <45 45 45>
  scale 2
  translate <-5,0,-1>
}
#declare StrengthVal = 1.0; 
#declare RadiusVal   = 1.0;
blob {
   threshold 0.6
   sphere { < 0.75,   0,    0>, StrengthVal, RadiusVal }
   sphere { <-0.375,  0.65, 0>, StrengthVal, RadiusVal } 
   sphere { <-0.375, -0.65, 0>, StrengthVal, RadiusVal }
   cylinder { 
      -z, +z, 0.1, StrengthVal 
   }
   texture {
      pigment {
         White/3
      } 
      finish { 
         reflection 0.85 
      }
   }
   scale 2
   translate x-3*z
}
julia_fractal
{ 
  <-0.083,0.0,-0.83,-0.025> 
  quaternion // hypercomplex?
  cube // TYPE: sqr cube 
  max_iteration 8 
  precision 20 // 10...500? FIXME
  pigment {rgbf <1.0,0.4,0.8,0.8>} finish { reflection 0.3 specular 0.7 }
   scale 2
  translate 2*z + 3*x
}

