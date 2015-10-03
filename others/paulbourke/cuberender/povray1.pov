//      CubeRender Demo scene file
//      http://www.strout.net/macsoft/cuberender/
//
//      This generates all six images at once and in the correct order,
//      if you set the 'clock' variable to go from 1 to 6 (in 6 frames) 
//      in the animation settings panel.

#version 3.1;

#include "colors.inc"

global_settings
{
  assumed_gamma 1.0
}

// ----------------------------------------
#declare campos = <0.0, 0.5, 0.0>
camera
{
  location  <0.0, 0.5, 0.0>
  up            y
  right     x

#switch (clock)
  #case (1)
        look_at campos +x
  #break
  #case (2)
        look_at campos -z
  #break
  #case (3)
        look_at campos -x
  #break
  #case (4)
        look_at campos +z
  #break
  #case (5)
        look_at campos +y
  #break
  #case (6)
        look_at campos -y
  #break
#end
  angle 90
}

sky_sphere
{
  pigment
  {
    gradient y
    color_map { [0.0 color blue 0.6] [1.0 color rgb 1] }
  }
}

light_source
{
  0*x // light's position (translated below)
  color red 1.0  green 1.0  blue 1.0  // light's color
  translate <-30, 30, -30>
}

// ----------------------------------------
plane
{
  y, -1
        texture {
          pigment { color rgb <0.8, 0.8, 0.4> }
          normal {crackle 0.5 turbulence 0.2 scale 0.5}
        }
}

sphere { 0.0, 1 texture {pigment {radial frequency 8} finish{specular 1}}
        translate 4*z }

torus { 0.8, 0.2                // major radius, minor radius
        texture {pigment { spotted 
                color_map
                {
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

box
{
  <-1, -1, -1>  // one corner position <X1 Y1 Z1>
  < 1,  1,  1>  // other corner position <X2 Y2 Z2>
        texture {
          pigment { color rgb <0.9, 0.8, 0.7> }
          normal {crackle 0.5 turbulence 0.2 scale 0.2}
        }
        rotate <45 45 45>
        scale 2
        translate -1*z - 10*x
}


// create a smooth blobby shape
#declare StrengthVal = 1.0 // (+ or -) strength of component's radiating density
#declare RadiusVal   = 1.0 // (0 < RadiusVal) outer sphere of influence on other components
blob
{
  // threshold (0.0 < threshold <= StrengthVal) surface falloff threshold #
  threshold 0.6
  sphere { < 0.75,   0,    0>, StrengthVal, RadiusVal }
  sphere { <-0.375,  0.65, 0>, StrengthVal, RadiusVal }
  sphere { <-0.375, -0.65, 0>, StrengthVal, RadiusVal }
  cylinder { -z, +z, 0.1, StrengthVal }
  texture {
        pigment {White/3} finish { reflection 0.85 }
  }
  scale 2
  translate x-3*z
}

// create a 3-D slice of a 4-D julia fractal object
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
 
