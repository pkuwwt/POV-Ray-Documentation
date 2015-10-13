// POV-Ray 3.6/3.7 scene file "Fender_1_demo.pov" 
// demonstration of the include file "Fender_1.inc"
// author: Friedrich A, Lohmueller, June-2014
// homepage: http://www.f-lohmueller.de/
//------------------------------------------------------------------------
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 15      // front view
                            location  <0.0 , 1.0 ,-40.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 22  // diagonal view
                            location  <3.0 , 1.15 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.48 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90  //right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,500,-2500> color White}
// sky -------------------------------------------------------------------
// sky --------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<0.24,0.34,0.56>*0.7]
                                [0.5 color rgb<0.24,0.34,0.56>*0.2]
                                [0.5 color rgb<0.24,0.34,0.56>*0.2]
                                [1.0 color rgb<0.24,0.34,0.56>*0.7]
                              }
                     rotate< 0,0, 0>
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
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90> translate<-2.1,0,0>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark} 
          rotate<20,-45,0> scale 0.55 translate <AxisLenX+0.05,0.4,-0.10> no_shadow  translate<-2.1,0,0>}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
          rotate<10,0,0> scale 0.55 translate <-0.45,AxisLenY+0.20,-0.10>  rotate<0,-45,0> no_shadow}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<20,-45,0> scale 0.65 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow}
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

object{ AxisXYZ( 4.5, 4.8, 5, Texture_A_Dark, Texture_A_Light) scale 0.2}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.1;
#declare RasterHalfLine  = 0.035;  
#declare RasterHalfLineZ = 0.035; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.8]
                          [0+HLine color rgbt<1,1,1,0>*0.8]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.8]
                          [1.000   color rgbt<1,1,1,0>*0.8]} }
 #end// of Raster(RScale, HLine)-macro          --------------------------
                                                 
//-----------------------------------------------
/*
plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color rgb<1,1,1>*1.35} }
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
*/
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



//------------------------------------------------------------------------------------
//----------------------------------------------------------- macro "Vector(Start,End,Radius)"!
#macro Vector(P_start,P_end, R_Vector)  
union{

cylinder{ P_start, P_end - ( vnormalize(P_end - P_start)*9.5*R_Vector), R_Vector  }
cone    { P_end - ( vnormalize(P_end - P_start)*10*R_Vector), 3*R_Vector, P_end, 0 }
}// end of union
#end //-------------------------------------------------------------------------- end of macro
//------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------
object{ Vector( o,<0,0.7,0>, 0.012) pigment{ color rgb<0.2,0.5,00.> } translate<0,0,-0.20>}
object{ Vector( o,<0,0.7,0>, 0.012) pigment{ color rgb<0.2,0.5,0.0> } translate<0,0,-0.20> rotate<0,0,70>}
//------------------------------------------------------------------------------------

object{ Vector( o,<0,0,-0.2>, 0.01) pigment{ color rgb<0.9,0.2,0.0> } translate<0.00,0.3,0>}
 //--------------------------------------------------------------------------
#include "shapes3.inc"
//--------------------------------------------------------------------------
object{  Segment_of_CylinderRing( 0.30, // major radius,
                                  0.00010, // minor radius,  
                                  0.001, // height H,
                                  -70  // angle (in degrees)  
                                ) //----------------------------------------
         texture{ pigment{ color rgb<0.2,0.5,0.0>*2 transmit 0.15} 
                   finish { phong 1}
                } // end of texture 
        scale <1,1,1> rotate<-90,0,90> translate<0,0,-0.2>
      } // end of object
//--------------------------------------------------------------------------
 
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------- optional textures
#declare Fender_Outside_Texture  =  
        texture{ pigment{ color rgb<1,1,1>} 
                 finish { phong 1}
               } // end of texture 
#declare Fender_Inside_Texture  =  
        texture{ pigment{ color rgb<1,1,1>*0.5} 
                 finish { phong 1}
               } // end of texture 
#declare Fender_Border_Texture  =  
        texture{ pigment{ color rgb<1,1,1>*1.3} 
                 finish { phong 1}
               } // end of texture 
//------------------------------------------------------------------------------------//
#include "shapes_lo2/Fender_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Fender_1 ( 0.7,  // major radius, 
                   0.2,  // minor radius, end radius  
                   0.02, // steal thickness 
                   70,   // fender angle, 
                 ) // ------------------------- 
        scale <1,1,1>*1 
        rotate<0,0,0>
        translate<0,0,0>
      } //-----------------------------------------------------------------------------// 
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
 