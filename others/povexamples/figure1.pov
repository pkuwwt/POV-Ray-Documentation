global_settings { ambient_light rgb <1,1,1> }
background { color rgb <1,1,1> }

#declare RR = 30;
#declare VP = RR*<0,0,1>;
#declare VU = <0,1,0>;

camera {
   perspective
   location VP
   up y
   right -image_width*x/image_height
   angle 5.8
   sky VU
   look_at <0,0,0>
}

light_source {
   VP
   color rgb <1,1,1>
}

#declare thefinish1 = finish {
   ambient 0.2
   diffuse 1
   specular 0.1
}
#declare thefinish2 = finish {
   ambient 0.2
   diffuse 0.8
   specular 0.4
}

#declare tubeframetexture = texture {
   pigment { color rgb <0.4,0.4,0.4> }
   finish { thefinish1 }
}

// Left diagram - band
#declare tubeframeradius = 0.01;
#declare showbandframe = 0;
union {
   #include "band.inc"
   scale 0.4
   translate <-1,0,0>
}

// Center diagram
#declare tubeframeradius = 0.01;
union {
   #include "mobius.inc"
   scale 0.45
   translate <-0.09,0,0>
}

// Right diagram
#declare ringradius = 0.3;
union {
   #include "rings.inc"
   scale 0.041
   translate <1,0,0>
}

// Boundary
#declare RADIUS = 0.01;
union {
   cylinder { <-1.5,0.5,0>,  <1.5,0.5,0>,   RADIUS }
   cylinder { <1.5,0.5,0>,   <1.5,-0.5,0>,  RADIUS }
   cylinder { <1.5,-0.5,0>,  <-1.5,-0.5,0>, RADIUS }
   cylinder { <-1.5,-0.5,0>, <-1.5,0.5,0>,  RADIUS }
   cylinder { <-0.5,0.5,0>,  <-0.5,-0.5,0>, RADIUS }
   cylinder { <0.5,0.5,0>,   <0.5,-0.5,0>,  RADIUS }
   sphere { <-1.5,0.5,0>, RADIUS }
   sphere { <-1.5,-0.5,0>, RADIUS }
   sphere { <1.5,-0.5,0>, RADIUS }
   sphere { <1.5,0.5,0>, RADIUS }
   pigment { color rgb <0.2,0.2,0.2> }
}

