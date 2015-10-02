#include "metals.inc"

#declare TWOPI = 6.283185307179586476925287;
#declare RADIUS = 2;
#declare NX = 256;
#declare NY = 32;
#declare NZ = 256;
#declare DD = <NX,NY,NZ>;
#declare CC = DD / 2;
#declare VP = <0,-NX,0>;

global_settings { 
   ambient_light <1,1,1> 
   assumed_gamma 1
}

camera {
   location VP
   up y
   right x
   angle 60
   sky <0,0,-1>
   look_at <0,0,0>
}

/* Light */
light_source {
   6*VP /* Behind camera */
   color rgb <100,100,100>
   media_interaction on
   media_attenuation on
   shadowless
}

#declare theinterior = interior {
   media {
      intervals 100
      ratio 0.5
      samples 2,2
      method 2
      confidence 0.999
      variance 1/1000

      emission <1,1,1> / NY
      absorption <10,10,10> / NY
      scattering { 1, <10,10,10> / NY }

      /* Absorb only */
      //emission <0,0,0> / NY
      //absorption <10,10,10> / NY
      //scattering { 1, <0,0,0> / NY }

      /* Emmission only */
      //emission <1,1,1> / NY
      //absorption <0,0,0> / NY
      //scattering { 1, <0,0,0> / NY }

      /* Scattering only */
      //emission <0,0,0> / NY
      //absorption <0,0,0> / NY
      //scattering { 1, <10,10,10> / NY }

      density {
           density_file df3 "test.df3" 
         interpolate 1
         color_map {
            [ 0.00 rgb <0,0,0> ]
            [ 0.40 rgb <0.4,0.4,0.4> ]
            [ 0.50 rgb <0.5,0,0> ]
            [ 0.60 rgb <0.6,0.6,0.6> ]
            [ 1.00 rgb <1,1,1> ]
         }
      }
   }
}

box {
   <0,0,0>, <1,1,1>
   pigment { rgbf 1 }
   interior { theinterior }
   hollow
   translate <-0.5,-0.5,-0.5>
   scale DD
}

#declare bbox = texture {
   pigment { rgb <0.5,0.5,0.5> }
   finish { F_MetalB }
}

/* Back of box */
union {
   cylinder { <1*NX/8,NY,0>, <1*NX/8,NY,NZ>, RADIUS texture {bbox} }
   cylinder { <2*NX/8,NY,0>, <2*NX/8,NY,NZ>, RADIUS texture {bbox} }
   cylinder { <3*NX/8,NY,0>, <3*NX/8,NY,NZ>, RADIUS texture {bbox} }
   cylinder { <4*NX/8,NY,0>, <4*NX/8,NY,NZ>, RADIUS texture {bbox} }
   cylinder { <5*NX/8,NY,0>, <5*NX/8,NY,NZ>, RADIUS texture {bbox} }
   cylinder { <6*NX/8,NY,0>, <6*NX/8,NY,NZ>, RADIUS texture {bbox} }
   cylinder { <7*NX/8,NY,0>, <7*NX/8,NY,NZ>, RADIUS texture {bbox} }

   cylinder { <0,0,1*NZ/8>, <NX,0,1*NZ/8>, RADIUS texture {bbox} }
   cylinder { <0,0,2*NZ/8>, <NX,0,2*NZ/8>, RADIUS texture {bbox} }
   cylinder { <0,0,3*NZ/8>, <NX,0,3*NZ/8>, RADIUS texture {bbox} }
   cylinder { <0,0,4*NZ/8>, <NX,0,4*NZ/8>, RADIUS texture {bbox} }
   cylinder { <0,0,5*NZ/8>, <NX,0,5*NZ/8>, RADIUS texture {bbox} }
   cylinder { <0,0,6*NZ/8>, <NX,0,6*NZ/8>, RADIUS texture {bbox} }
   cylinder { <0,0,7*NZ/8>, <NX,0,7*NZ/8>, RADIUS texture {bbox} }

   translate -CC
}

/* Corners of box */
union {
   sphere { <0,0,0>, RADIUS texture {bbox} }
   sphere { <0,NY,0>, RADIUS texture {bbox} }
   sphere { <NX,NY,0>, RADIUS texture {bbox} }
   sphere { <NX,0,0>, RADIUS texture {bbox} }
   sphere { <0,0,NZ>, RADIUS texture {bbox} }
   sphere { <0,NY,NZ>, RADIUS texture {bbox} }
   sphere { <NX,NY,NZ>, RADIUS texture {bbox} }
   sphere { <NX,0,NZ>, RADIUS texture {bbox} }
   translate -CC
}

/* Main border of box */
union {
   cylinder { <0,0,0>, <NX,0,0>, RADIUS texture {bbox} }
   cylinder { <0,0,0>, <0,NY,0>, RADIUS texture {bbox} }
   cylinder { <0,0,0>, <0,0,NZ>, RADIUS texture {bbox} }
   cylinder { <NX,NY,NZ>, <0,NY,NZ>, RADIUS texture {bbox} }
   cylinder { <NX,NY,NZ>, <NX,0,NZ>, RADIUS texture {bbox} }
   cylinder { <NX,NY,NZ>, <NX,NY,0>, RADIUS texture {bbox} }
   cylinder { <0,0,NZ>, <NX,0,NZ>, RADIUS texture {bbox} }
   cylinder { <0,0,NZ>, <0,NY,NZ>, RADIUS texture {bbox} }
   cylinder { <NX,NY,0>, <NX,0,0>, RADIUS texture {bbox} }
   cylinder { <NX,NY,0>, <0,NY,0>, RADIUS texture {bbox} }
   cylinder { <0,NY,0>, <0,NY,NZ>, RADIUS texture {bbox} }
   cylinder { <NX,0,0>, <NX,0,NZ>, RADIUS texture {bbox} }
   translate -CC
}

