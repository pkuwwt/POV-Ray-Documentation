#include "metals.inc"
#include "glass.inc"

#declare VP = <3,3,3>;
#declare VD = vnormalize(-VP);
#declare VU = <0,0,1>;
#declare VR = vnormalize(vcross(VD,VU));
#declare VU = vnormalize(vcross(VR,VD));

camera {
   location VP
   up y
   right -4*x/3
   angle 60
   sky VU
   look_at VP + VD
}

light_source {
   VP - VD
   color rgb 3*<1,1,1>
}

global_settings {
   ambient_light <1,1,1>
}

/* Axes */
sphere {
	<0,0,0>, 0.015
	texture { pigment { rgb <0.5,0.5,0.5> } finish { F_MetalB } }
}
cylinder {
	<0,0,0>, <2,0,0>, 0.01
	texture { pigment { rgb <1,0.5,0.5> } finish { F_MetalB } }
}
cylinder {
   <0,0,0>, <0,2,0>, 0.01
	texture { pigment { rgb <0.5,1,0.5> } finish { F_MetalB } }
}
cylinder {
   <0,0,0>, <0,0,2>, 0.01
   texture { pigment { rgb <0.5,0.5,1> } finish { F_MetalB } }
}

#declare DISCRADIUS = 0.5;

disc {
   <0.5,0.5,0>, <0,0,1>, DISCRADIUS
   texture {
      pigment {
         image_map { tga "galaxy.tga" once }
         scale 2*DISCRADIUS
      }
		finish { F_MetalC }
   }
}

/* Frame around texture */
union {
   cylinder {
      <0,0,0>, <1,0,0>, 0.005
      texture { pigment { rgb <0.5,0.5,0.5> } finish { F_MetalB } }
   }
   cylinder {
      <1,0,0>, <1,1,0>, 0.005
      texture { pigment { rgb <0.5,0.5,0.5> } finish { F_MetalB } }
   }
   cylinder {
      <1,1,0>, <0,1,0>, 0.005
      texture { pigment { rgb <0.5,0.5,0.5> } finish { F_MetalB } }
   }
   cylinder {
      <0,1,0>, <0,0,0>, 0.005
      texture { pigment { rgb <0.5,0.5,0.5> } finish { F_MetalB } }
   }
   translate <-0.5,-0.5,-0.5>
   scale 2*DISCRADIUS
}

