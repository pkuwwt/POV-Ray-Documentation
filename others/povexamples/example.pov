amera {
   location <2,1,0>
   up       y
   right    x
   angle    60
   look_at  <0,0,0>
}

light_source {
   <0,5,0>
   color rgb <1,1,1>
   media_interaction off
   media_attenuation off
}

#declare boxtexture = texture {
   pigment {
      rgbf 1
   }
}

#include "envir.pov"

#declare boxinterior = interior {
   media {
      intervals 300
      samples 1,20
      emission <1,1,1>
      absorption <0,0,0>
      scattering { 1,<0,0,0> }
      confidence 0.9999
      variance 1/1000
      density {
         density_file df3 "test.df3" 
                        interpolate 1
      }
   }
}

box {
   <0,0,0>, <1,1,1>
   texture { boxtexture }
   interior { boxinterior }
   hollow
   translate <-0.5,-0.5,-0.5>
}

#declare bbox = texture {
   pigment {
      rgb <1,0,0>
   }
}

cylinder { <-0.51,-0.51,-0.51>, < 0.51,-0.51,-0.51>, 0.01 texture {bbox} }
cylinder { <-0.51,-0.51,-0.51>, <-0.51, 0.51,-0.51>, 0.01 texture {bbox} }
cylinder { <-0.51,-0.51,-0.51>, <-0.51,-0.51, 0.51>, 0.01 texture {bbox} }

cylinder { <0.51,0.51,0.51>, <-0.51, 0.51, 0.51>, 0.01 texture {bbox} }
cylinder { <0.51,0.51,0.51>, < 0.51,-0.51, 0.51>, 0.01 texture {bbox} }
cylinder { <0.51,0.51,0.51>, < 0.51, 0.51,-0.51>, 0.01 texture {bbox} }

cylinder { <-0.51,-0.51,0.51>, < 0.51,-0.51,0.51>, 0.01 texture {bbox} }
cylinder { <-0.51,-0.51,0.51>, <-0.51, 0.51,0.51>, 0.01 texture {bbox} }

cylinder { <0.51,0.51,-0.51>, < 0.51,-0.51,-0.51>, 0.01 texture {bbox} }
cylinder { <0.51,0.51,-0.51>, <-0.51, 0.51,-0.51>, 0.01 texture {bbox} }

cylinder { <-0.51,0.51,-0.51>, <-0.51, 0.51,0.51>, 0.01 texture {bbox} }
cylinder { < 0.5,-0.51,-0.51>, < 0.51,-0.51,0.51>, 0.01 texture {bbox} }

