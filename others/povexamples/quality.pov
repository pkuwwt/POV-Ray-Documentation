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
	location <0,4,-10>
	look_at <0,4,0>
	angle 70
}

// Background "sky", a simple colour gradient
light_source { 
	<50,50,-50> White 
}
sky_sphere {
	pigment {
		gradient <0,1,0>
		color_map {
			[0 color rgb <0.2,0.6,0.9>]
			[1 color rgb <0,0,0.3>]
		}
	}
}

// Lights
// A global ambient contribution
// A point light source in the middle of the space
// A spot light on the high end of the roof
light_source {
	<0,20,0>
	color rgb <0.2,0.2,0.2>
	shadowless
}
light_source {
	<0,5.5,0>
	color rgb <1,1,1>
}
light_source { 
	<4,6.5,0> 
	color rgb <1,1,1>
	spotlight
	point_at <0,0,0>
	radius 15
	falloff 20
}

// Create a bumpy ground plane
plane {
	<0,1,0>,0
	texture {
		pigment {
			color rgb <0.1,0.8,0.2>
		}
		normal {
			bumps 0.4
			scale 0.1
		}
		finish {
			phong 1
		}
	}
}

// Create a table
// A rectangular top
// Diagonal leg and a toroidal base
box {
	<-2.2,-0.01,-2.2>, <2.2,0,2.2>
	texture {
		pigment {
			color rgb <0.8,0,0>
		}
	}
	translate <0,2,0>
}
box {
	<-0.12,-0.5,-0.12>, <0.12,2,0.12>
	rotate <0,0,35>
   translate <1.1,0,0>
	texture {
		pigment {
			color <0.6,0.6,0.6>
		}
		finish {
			specular 0.5 
			roughness 0.15
		}
	}
}
torus {
	1.1 0.2
	scale <1,0.6,1>
   texture {
      pigment {
         color rgb <0.6,0.6,0.6>
      }
      finish {
         specular 0.5 
         roughness 0.15
      }
   }
}

// Put a piece of paper on the table
box {
	<0,0,0>, <1,1,0.05>
	pigment {
		image_map {
			gif "bookcover.gif"
		}
	}
	scale <1.2,1.6,1>
	rotate <90,0,0>
	rotate <0,-15,0>
	translate <1,2.1,-1.75>
}

// Create a cylinders to hold up the roof
#declare RoofSupports = cylinder {
	<0,0,0>, <0,7,0>, 0.05
	open
	texture { T_Chrome_4B }
}
object { RoofSupports translate <-3,0,3> }
object { RoofSupports translate <-3,0,-3> }

// Place a piece of glass between the roof supports, half height
polygon {
	5,
	<-3,0,-3>, <-3,3,-3>, <-3,3,3>, <-3,0,3>, <-3,0,-3>
	texture { T_Glass1 }
}

// Create a sloping roof
polygon {
	5,
	<-5,5,5>, <-5,5,-5>, <5,7,-5>, <5,7,5>, <-5,5,5>
	texture {
		pigment {
			checker color rgb <1,0,0> color rgb <1,0.5,0.5>
			scale 0.4
		}
		finish {
			diffuse 0.9
		}
	}
}

// Create the cone sculpture
cone {
   <0,0,0>,1
   <0,15,0>,0
   texture {
      pigment {
         color rgb <0.5,0.5,0.5>
      }
      finish {
         phong 1
         specular 0.4
      }
   }
	translate <4,0,9>
}

// Create a sphere intersection sculpture
intersection {
	sphere { 
		<3.8,2,0>, 2
	}
	sphere { 
		<6.2,2,0>, 2
	}
	texture { T_Copper_1E }
	translate <0,-0.5,0>
}

// Create a blob sculpture
blob {
	sphere {
		<-3,1,4>,1.5
		strength 1
	}
	sphere {
		<-5,1,4>,1.5
		strength 1
	}
	sphere {
		<-4,3,4>,1.5
		strength 1
	}
	threshold 0.2
   texture { 
      pigment { 
         P_WoodGrain7A
      }
		finish {
			 phong 0.5
		}
   }
}


