light_source {
   <-4,10,-3>
   color rgb <1,1,1>
}

#declare RR = 4;
camera { 
   location RR*<-1,1,-1>
   right (image_width/image_height)*x 
   up y 
   look_at <0,0,0> 
}

background { color rgb <0,0,0> }

#declare thefinish1 = finish {
   ambient 0.1
   diffuse 0.5
   specular 0.6
}
#declare thefinish2 = finish {
   ambient 0.1
   diffuse 0.5
   specular 0.6
}

#declare tubeframetexture = texture {
   pigment { color rgb <0.4,0.4,0.4> }
   finish { thefinish1 }
}

// Left diagram - band
#declare tubeframeradius = 0.025;
#declare showbandframe = 0; 
union {
   #include "band.inc"
   rotate <60,0,0>
   scale 0.4 * 3.5
   translate <-2,0,1>
}

// Center diagram
#declare tubeframeradius = 0.02;
union {
   #include "mobius.inc"
   scale 0.45 * 5
   rotate <0,0,90>
   rotate <0,20,0>
   translate <2.5,0,1>
}

// Right diagram
#declare ringradius = 0.3;
union {
   #include "rings.inc"
   rotate <90,0,0>
   scale 0.041 * 3.5
   translate <0,-0.5,-2>
}

