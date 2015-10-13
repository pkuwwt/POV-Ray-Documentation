// PoVRay 3.7 Scene File "Demo_prism01.pov"
// author:  .Friedrich A. Lohmueller, Jan-2014
// homepage: http://www.f-lohmueller.de/
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
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
#declare Camera_0 = camera {perspective angle 45               // front view
                            location  <0.0 , 1.0 ,-4.5>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 33   // diagonal view
                            location  <5.0 ,  4.5 ,-6.0>
                            right     x*image_width/image_height
                            look_at   <1 , 1.3 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90  //right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
// sun ----------------------------------------------------------------------
light_source{< 4000,2000,-2000> color White}
// sky ----------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <0.6,0.7,1.0>]
                                   [0.35 rgb <0.15,0.1,0.8>*0.5]
                                   [0.65 rgb <0.15,0.1,0.8>*0.5]
                                   [1.00 rgb <0.6,0.7,1.0>] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
#macro Axis_( AxisLen, Dark_Texture,Light_Texture) 
 union{
    cylinder { <0,-AxisLen,0>,<0,AxisLen,0>,0.05
               texture{checker texture{Dark_Texture } 
                               texture{Light_Texture}
                       translate<0.1,0,0.1>}
             }
    cone{<0,AxisLen,0>,0.2,<0,AxisLen+0.7,0>,0
          texture{Dark_Texture}
         }
     } // end of union                   
#end // of macro "Axis()"
//------------------------------------------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, Tex_Dark, Tex_Light)
//--------------------- drawing of 3 Axes --------------------------------
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark} 
          rotate<10,-35,0> scale 0.55 translate <AxisLenX+0.15,0.3, 0.00> no_shadow}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
          rotate<10,0,0> scale 0.55 translate <-0.45,AxisLenY+0.50,-0.10>  rotate<0,-35,0> no_shadow}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<10,-35,0> scale 0.70 translate <-0.45,0.2,AxisLenZ+0.10> no_shadow}
#end // of #if                     
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,0.45,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ( 2.25, 2.1, 8, Texture_A_Dark, Texture_A_Light)}
//-------------------------------------------------- end of coordinate axes


// ground -------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ checker 
                         color rgb <0.7,0.65,0.5>*1  
                         color rgb<0.7,0.55,0.5>*0.5}
                normal { bumps 0.75 scale 0.025}
                finish { phong 0.1}
               scale 1
              } // end of texture
     } // end of plane
//---------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//---------------------------------------------------------------------------

 // linear prism in y-direction: from .. ,to ..,number of points (first = last)
prism { 0.00 ,1.00 , 4
       <-1.00, 0.00>, // first point
       < 1.00, 0.00>, 
       < 0.00,-1.30>,
       <-1.00, 0.00>  // last point = first point !!!

       texture { pigment{ color White } 
                 finish { phong 1.0 }
               } // end of texture

       scale <1.00, 1.00, 1.00>
       rotate<0,0,0> 
       translate<0.00, 0.00, 0.00> 
     } // end of prism --------------------------------------------------------

// linear prism in z-direction: from ,to ,number of points (first = last)
prism { -0.00 ,2.00 , 6
       <-1.00, 0.00>,  // first point
       < 1.00, 0.00>, 
       < 1.00, 1.00>, 
       < 0.00, 1.50>, 
       <-1.00, 1.00>, 
       <-1.00, 0.00>   // last point = first point!!!!
       rotate<-90,0,0> scale<1,1,-1> //turns prism in z direction! Don't change this line! 

       texture { pigment{ color White} 
                 finish { phong 1.0} 
               } // end of texture

       scale <1.00,1.00,1.00>       
       rotate <0,0,0> 
       translate <1.00,0.00,1.00> 
     } // end of prism --------------------------------------------------------

