#include "colors.inc"
#include "stones.inc"
#include "textures.inc"
#include "skies.inc"
#include "shapes.inc"
#include "glass.inc"
#include "metals.inc"
#include "woods.inc"
#include "finish.inc"

// Define the location of the camera
camera {
   location <-1,13,4>
   direction <0,-1,0>
   up <0,0,1.6>    // 960/600, see width and height in .ini file
   right <1,0,0>
   orthographic
}

// Lights
light_source { 
	<50,50,-50> White 
}
light_source {
	<-50,50,50>
	color rgb <0.4,0.4,0.4>
	shadowless
}

// Create a ground plane
plane {
   <0,1,0>,-2
   texture {
      pigment {
         hexagon <0.8,0.8,0.8>, <0.9,0.9,0.9>, <0.85,0.85,0.85>
      }
		normal {
         bumps 0.4
         scale 0.1
		}
		finish {
			ambient rgb <0.2,0.2,0.2>
		}
   }
}

// Make a sphere and cylinder
#declare theball = 
	sphere {
		<0,0,0>, 1
      texture {
         pigment {
            color Blue
         }
			finish {
				specular 0.7
				roughness 0.1
				metallic
			}
      }
	}
#declare thecylinder =
	cylinder {
		<-1.5,0,0>, <1.5,0,0>, 0.75
		texture {
			pigment {
				color Red
			}
			finish {
				phong 0.5
			}
		}
	}

// Original
text { ttf "timrom.ttf" "Original" 0.1, 0
   pigment { rgb <0,0,0.5> }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-5,-1.5,6.5>
}
object { theball 
	rotate <0,30,0> rotate <0,0,50> translate <-3,0,9> 
}
object { thecylinder 
	rotate <0,30,0> rotate <0,0,50> translate <-3,0,9> 
}

// Union
text { ttf "timrom.ttf" "Union" 0.1, 0
   pigment { rgb <0,0,0.5> }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-5,-1.5,0.5>
}
union {
	object { theball }
	object { thecylinder }
	rotate <0,30,0> rotate <0,0,50> translate <-3,0,3>
}

// Difference 2
text { ttf "timrom.ttf" "Difference 2" 0.1, 0
   pigment { rgb <0,0,0.5> }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <1,-1.5,0.5>
}
difference {
   object { thecylinder }
	object { theball }
	rotate <0,30,0> rotate <0,0,50> translate <3,0,3>
}

// Difference 1
text { ttf "timrom.ttf" "Difference 1" 0.1, 0
   pigment { rgb <0,0,0.5> }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <1,-1.5,6.5>
}
difference {
   object { theball }
   object { thecylinder }
   rotate <0,30,0> rotate <0,0,50> translate <3,0,9>
}

// Intersection
text { ttf "timrom.ttf" "Intersection" 0.1, 0
   pigment { rgb <0,0,0.5> }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <-5,-1.5,-5.5>
}
intersection {
   object { theball }
   object { thecylinder }
	rotate <0,30,0> rotate <0,0,50> translate <-3,0,-3>
}

// Merge
text { ttf "timrom.ttf" "Merge" 0.1, 0
   pigment { rgb <0,0,0.5> }
   scale <0.6,0.6,0.6> rotate <90,0,0> translate <1,-1.5,-5.5>
}
merge {
   object { theball }
   object { thecylinder }
	rotate <0,30,0> rotate <0,0,50> translate <3,0,-3>
}

