// PoVRay 3.7 Scene File "raster_mountain_hor.pov"
// author: Friedrich A. Lohmueller, April-2006/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
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
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 55      // front view
                            location  <0.0 , 10.0 ,-2.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 10.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 75   // diagonal view
                            location  <65  , 27  , 3 >
                            right     x*image_width/image_height
                            look_at   <40  , 0.0 , 35>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<- 500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>]
                                   [0.30 rgb <0.0,0.1,1.0>]
                                   [0.70 rgb <0.0,0.1,1.0>]
                                   [1.00 rgb <1.0,1.0,1.0>] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   500
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------

// ground ---------------------------------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.55;      // <-------------------------- stripes distance - Strichabstand
#declare RasterHalfLine  = 0.05;  // <-------------------------- stripes width    - Strichbreite 
//#declare RasterHalfLineZ = 0.05;  // < dito in z direction

#declare Raster_Color = <1,1,1>*0.2; //<------------------------ stripes color    - Stichfarbe
//-----------------------------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgb Raster_Color  ]
                          [0+HLine color rgb Raster_Color ]
                          [0+HLine+0.05 color rgbt<1,1,1,1>]
                          [1-HLine-0.05 color rgbt<1,1,1,1>]
                          [1-HLine color rgb Raster_Color ]
                          [1.000   color rgb Raster_Color ]} }
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    
union{ 
plane{ <0,1,0>, 0  }   

height_field{ tga "MountLo1.tga" smooth double_illuminate
              // allowed file types: 
              // gif | tga | pot | png | pgm | ppm | jpeg | tiff | sys
              // [water_level N] // truncate/clip below N (0.0 ... 1.0)
              translate<-0.5,-0.001,0>
              scale<150,15,150> 
              rotate<0,0,0>
              translate<0,0,0>
            } // end of height_field ----------------------------------

//  with layered textures raster: 

        texture { pigment{color White*1.1}}  //<----------------- background texture
                                             //                   Hintergrund Textur

        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,90> translate<0,0.45,0>}
        // texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of mountain
//---------------------------------------------------------------------------------------------end











