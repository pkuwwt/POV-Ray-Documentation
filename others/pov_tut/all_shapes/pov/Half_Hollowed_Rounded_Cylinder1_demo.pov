// POV-Ray 3.6/3.7 Scene File "Half_Hollowed_Rounded_Cylinder1_demo.pov"
// author: Friedrich A. Lohmueller, Aug-2012  / March 2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;// 3.6; 
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 50   // front view
                            location  <0.0 , 1 ,-5.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1 , 0.0> }
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 36   // diagonal view
                            location < 5.00, 7.00, -5.00>
                            right     x*image_width/image_height
                            look_at  < 0.50, 1.20,  0.00> }
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 70 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.5 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 50        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0> }
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<1500, 2500, -2500> color White*0.9}                       // sun light
light_source{<-5.00,2.80, -8.00> color rgb<0.9,0.9,1>*0.1 shadowless }  // flash light

// sky ---------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<0.24,0.34,0.56>*0.7]        
                                [0.5 color rgb<0.24,0.34,0.56>*0.4] 
                                [0.5 color rgb<0.24,0.34,0.56>*0.4] 
                                [1.0 color rgb<0.24,0.34,0.56>*0.7]          
                              }
                     rotate< 0,0, 0>  
                     scale 2 }
           } // end of sky_sphere
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
          scale 0.5 translate <AxisLenX+0.05,0.5, 0.10>}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
           scale 0.5 translate <-0.75,AxisLenY+0.20,-0.10>}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.75,0.2,AxisLenZ+0.10>}
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

object{ AxisXYZ( 13, 5.75, 12, Texture_A_Dark, Texture_A_Light) scale 0.25 translate <0,1.5,0>}
//-------------------------------------------------- end of coordinate axes


//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//----------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------//
#include "shapes3.inc"
//----------------------------------------------------------------------------------//
object { Half_Hollowed_Rounded_Cylinder1( //  
                                6.0,//  Len_total, // total lenght from end to end
                                1.5,// outer radius < (total lenght)/2
                                0.3,// border radius
                                1, //  border scale y ( >0 ) ; 0 = no rounded borders
                                0  //  Merge_On , // 0 = union, 1 = merge !  
                              ) //-------------------------------------------------//
       
         texture{ pigment{ color rgb< 1,1,1>  }//  
                  //normal { bumps 0.5 scale 0.015 }
                  finish {phong 0.6 reflection 0.25}
                } // end texture
 /* 
      // optional transparent material - use it with: "1 // Merge_On- for transparent materials" 
      material{   //-------------------------------------------------------------
        texture { pigment{ rgbf <0.98, 0.98, 0.98, 0.79> }
                  finish { diffuse 0.1 reflection 0.2  
                          specular 0.8 roughness 0.0003 phong 0.5 phong_size 400}
                } // end of texture ---------------------------------------------
        interior{ ior 1.5 caustics 0.5
                } // end of interior --------------------------------------------
      } // end of material ------------------------------------------------------
                                            
 */
       
         translate <0,1.5,0> 
         rotate <0,0,0> 
       }
//----------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------//
                














