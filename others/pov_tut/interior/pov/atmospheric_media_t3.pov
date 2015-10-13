// POV-Ray 3.7 Scene File "atmospheric_media_t3.pov"
// author: Friedrich A. Lohmueller, Oct. 2008/Aug-2009 / Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
global_settings{assumed_gamma 1.0} 
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 55 //  --------------
                            location  < 15.00,  2.50, -7.00>
                            right     x*image_width/image_height
                            look_at   <-0.50, 2.50, 4.00>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
// light_source{<1500,2500,-2500> color White}

// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}

// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
	         normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------




//-----------------------------------------------------------------------------------------
media{ 
  scattering { 1,  // scattering media type 1,2,3
               0.3 // color of the media (no comma!)
               extinction 0.25 //optional 0~1 = how fast the scattering media absorbs light 
             }
  intervals 20 // default 10 // how many samples
                             // the intervals span the entire length of the ray 
                             // from camera to where it hits an object
  density{ granite scale 10     
    color_map{
               [0.0 rgb <1,1,1>*0.1]
               [0.5 rgb <1,1,1>*0.3]
               [1.0 rgb <1,1,1>*1  ] 
             } // end of color_map
         } // end of density
} // end of media

//---------------------------------------------------------------------------------------
// spotlight 
light_source { < 0, 1, 18.0>        // position of the light 
               color rgb<1,1,1>*1   // color of the light
               spotlight            // kind of light source 
               point_at <1, 0.5, 0> // direction of spotlight
               radius  10           // hotspot (inner, in degrees)
               tightness 15         // tightness of falloff (1...100) 
                                    // lower is softer, higher is tighter
               falloff 35           // intensity falloff radius (outer, in degrees)
   looks_like{ sphere { <0,0,0>, 0.35  scale<1,1,0.1>
                        texture{ pigment{ color rgb<1,1,1>} 
                                 finish { ambient 1 } // no shadow on the light!
                               } // end of texture 
                      } // end of sphere ----------------------------------- 
             } // end of looks_like
    } //-------------- end of light_source "spotlight" ----------------------------------
//---------------------------------------------------------------------------------------


//----------------------------------------------- objects:
union{ // street
box { <-3.50, 0.00, -1000>,< 3.50, 0.001, 1000>   
      texture{ pigment{ color rgb<1,1,1>*0.3}
               normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture

      scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
    } // end of box --------------------------------------
// left stripe
box { <-3.50, 0.00, -1000>,<-3.35, 0.001, 1000>   
      texture{ pigment{ color rgb<1,1,1>*1.1}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture
    } // end of box --------------------------------------
// right stripe
box { < 3.35, 0.00, -1000>,< 3.50, 0.001, 1000>   
      texture{ pigment{ color rgb<1,1,1>*1.1}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture

    } // end of box --------------------------------------
union{ //  inner union --- center stripes
 #declare Nr = -500;   // start
 #declare EndNr = 500; // end
 #while (Nr< EndNr) 

   box { <-0.075, 0.00, 0>,< 0.075, 0.0015, 1.00>   
      texture{ pigment{ color rgb<1,1,1>*1.1}
               finish { diffuse 0.9 phong 0.5}
             } // end of texture
        translate<0,0,Nr*2.00>} 

 #declare Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 
} // end of inner union
rotate<0,0,0> 
translate<0,0,-100>
} // end of union --------------------------end of street


//----------------------------- columns 
union{  
cylinder { <0,0,0>,<0,5,0>,0.3 } 
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,3>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,6>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,9>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,12>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,15>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,18>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,21>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,24>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,27>}

           texture { pigment { color rgb<1,1,1> }
                     finish  { diffuse 0.9 phong 0.5}
                   } // end of texture

           translate<-4.5,0,-3>
} // end of union

union{  
cylinder { <0,0,0>,<0,5,0>,0.3 } 
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,3>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,6>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,9>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,12>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,15>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,18>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,21>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,24>}
cylinder { <0,0,0>,<0,5,0>,0.3  translate<0,0,27>}

           texture { pigment { color rgb<1,1,1> }
                     finish  { diffuse 0.9 phong 0.5}
                   } // end of texture

           translate<-4.5,0,-3>  scale <-1,1,1>
} // end of union
// ---------------------------------------------------------------------------- end
