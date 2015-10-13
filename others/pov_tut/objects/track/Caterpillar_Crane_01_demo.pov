// PoVRay 3.7 Scene File "Caterpillar_Crane_01.pov"
// author: Friedrich A. Lohmueller, Nov-2006/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//------------------------------------------------------------------------
#version 3.6; // 3.7;
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
                            location  <14.6 , 3.6 ,-15.5 >
                            right     x*image_width/image_height
                            look_at   < 2.50, 2.00, 0.00>}
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


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.025;  
#declare RasterHalfLineZ = 0.025; 
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
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------







//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
//------------------------------------------------------------------------------ textures
#local Body_Texture =  
        texture { pigment{ color rgb< 1.0, 0.65, 0.0> } //  deep yellow 
               // normal { bumps 0.5 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Body_Inside_Texture =  
        texture { pigment{ color rgb< 1.0, 0.65, 0.0>*0.7 } //  deep yellow 
               // normal { bumps 0.5 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Chassis_Texture =  
        texture { pigment{ color rgb< 1.0, 1, 1>*0.35 } //  gray
                  normal { bumps 0.15 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Scoop_Texture = 
        texture{ //Chrome_Metal
                 pigment{ color rgb< 1.0, 1, 1>*0.35 } //  gray
                 normal { bumps 0.5 scale 0.025}
                 finish { phong 1 }
               } // end of texture  
#local Cable_Texture = 
        texture{ //Chrome_Metal
                 pigment{ color rgb< 1.0, 1, 1>*0.55 } //  gray
                 normal { bumps 0.5 scale 0.025}
                 finish { phong 1 }
               } // end of texture  
//------------------------------------------------------------ 
#local Chain_Color =  color rgb< 1, 1, 1>*0.65;     // base color of the chains
#local Wheel_Texture =  texture { pigment{ color rgb< 1, 0.75, 0.50>*0.5 } // brown 
                                  normal { bumps 0.5 scale 0.01 }
                                  finish { phong 1 reflection 0.00}
                                } // end of texture 
//------------------------------------------------------------ 
#declare Mast_Texture = 
 texture { pigment{ color rgb<1,1,1>*0.45 } 
           finish { phong 0.1} 
         } // end of texture
//-----------------------------------------------------------------------------
//----------------------------------------------------------------------------
#include "Caterpillar_Crane_01.inc"
//-----------------------------------------------------------------------------
object{ Caterpillar_Crane_01(  38, // Crane_Head_Rotation in degrees
                               28, // Jib_Angle, 0~55 degrees  //   winkel des Auslegers !!!
                               55, // Scoop_Open, // 0 ~65 degrees
                               2.00, // >= 1.20 Vertical_Cable_Length for scoop at jib
                               Body_Texture,  // 
                               Body_Inside_Texture,  // 
                               Chassis_Texture,  // 
                               Scoop_Texture,  // 
                               Cable_Texture, //
                               Chain_Color,  // base color of the chains  
                               Wheel_Texture,  //  texture of the wheels
                               Mast_Texture  
                            )  //------------------------------------------
        scale <1,1,1>  
        rotate<0,-20,0> 
        translate<0,0,0> }//---------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------




