// POV-Ray 3.6/3.7 Scene File "Rocker0.pov"
// author: Friedrich A. Lohmueller, Aug-2012
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//------------------------------------------------------------------------
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
//------------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle  30      // front view
                            location  <0.0 , 0.3 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.3 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 14   // diagonal view
                            location  <20.0 , 15.0 ,-20.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90  //right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere 
//------------------------------------------------------------------------

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
          rotate<0,0,0> scale 0.75 translate <AxisLenX+0.05,0.4,-0.10> no_shadow}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
          rotate<0,0,0> scale 0.75 translate <-0.65,AxisLenY+0.30,-0.10>  rotate<0,0,0> no_shadow}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<0,0,0> scale 0.85 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow}
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

object{ AxisXYZ( 2.50, 2.00, 0.00, Texture_A_Dark, Texture_A_Light) scale 0.25}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.25;
#declare RasterHalfLine  = 0.015;  
#declare RasterHalfLineZ = 0.015; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<-90,0,0>
      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


#macro Rocker( Rocking_Angle )
//---------------------------------
#local D = 0.00001;
//---------------------------------
#local R_R = 1.20; // rocker skids radius
#local R_rotate = 25;
#local D_feet = 0.055;
//----------------------------------------
#local Skid =
intersection{
   box{<-R_R,-R_R-D,-D_feet/2-2*D>,
       <0,R_R+D,D_feet/2+2*D>
       rotate<0,0,-R_rotate>
       inverse }
   box{<-R_R,-R_R-D,-D_feet/2-2*D>,
       <0,R_R+D,D_feet/2+2*D>
       rotate<0,0,-R_rotate>
       inverse
       scale<-1,1,1> }
   cylinder{<0,0,-D_feet/2>,
            <0,0,D_feet/2>, R_R}
   cylinder{<0,0,-D_feet/2-D>,
            <0,0,D_feet/2+D>, R_R-D_feet
            inverse }
} // end intersection Skid
//---------------------------------------
//---------------------------------------

object{ Skid    
 rotate< 0,0,Rocking_Angle>
  translate< 0, R_R, 0>
// move by the 
// according part of the circumference:
translate
  <-(2*pi*R_R)*(Rocking_Angle/360),0,0>

} // end of Skid
#end // end of macro Rocker()
   
#declare Time =  clock + 0.00;
//--------------------------------------- 
object{
  Rocker( 12* sin(Time*2*pi) )
    texture{
      pigment{ color rgb<0.2,0.12,0.08>}
      finish { phong 1 reflection 0}
    } // end of texture
    rotate<0,0,0>
    translate<0,0,0>
} // end of Rocker ----------------------
 