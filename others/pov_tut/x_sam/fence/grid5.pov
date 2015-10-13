// POV-Ray 3.6 / 3.7 Scene File "grid5.pov"
// author: Friedrich A. Lohmueller, 2005/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
global_settings { max_trace_level 10 }//(1...20) [default = 5]

#include "colors.inc"
#include "textures.inc"
// camera -----------------------------------------------------------
#declare Cam0 = camera {//ultra_wide_angle 
                        angle 25 
                        location  <0.0 , 0.0 ,-30.0>
                        look_at   <0.0 , 0.0 , 0.0>}
#declare Cam1 = camera {ultra_wide_angle angle 12 
                        location  <10.0 , 20.5 ,-28.0>
                        look_at   <0.9 , 1.75 , 0.0>}
camera{Cam1}
// sun ---------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------
sphere{<0,0,0>,1 hollow 
              texture{pigment{gradient <0,1,0>
                              color_map{[0.00 color rgb<1,0.75,0> ]
                                        [0.35 color rgb<1,0.75,0>*0.8]
                                        [0.50 color White*1.1 ]
                                        [0.65 color rgb<1,0.75,0>*0.8]
                                        [1.00 color rgb<1,0.75,0> ]}
                              quick_color White 
                              scale 2 translate<0,-1,0>}
                      finish {ambient 1 diffuse 0} rotate<20,0,0>
                     } 
           scale 10000}
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------

//---------------------------------------------------<<<< grid macro
//----------------------------------------------------------------
#macro Raster(RScale, RLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<0,0,0,0>]
                          [0+RLine color rgbt<0,0,0,0>]
                          [0+RLine color rgbt<1,1,1,1>]
                          [1-RLine color rgbt<1,1,1,1>]
                          [1-RLine color rgbt<0,0,0,0>]
                          [1.000   color rgbt<0,0,0,0>]} }
       finish { phong 0.1}
 #end// of Raster(RScale, RLine)-macro    
//---------------------------------------------------------------
box {<0,0,0>,< 2,0.001,2> scale <1,1,1>                
      texture{pigment{ color rgbt<1,1,1,0.85>} 
              finish { phong 0.1 } }
      texture{Raster( 1.0, 0.07) scale 0.25 rotate<0,45,0>}
     rotate<-90,0,0>
     scale 2
     rotate<5,0,0> translate<0,0,0>}

box {<0,0,0>,< 2,0.001,2> scale <1,1,1>                
      texture{pigment{color rgbt<1,1,1,0.85>} 
              finish {ambient 0.1 diffuse 0.9} }
      texture{Raster( 1.0, 0.07) scale 0.25 rotate<0,-45,0>}
     rotate<-90,0,0>
     scale 2
     rotate<5,0,0> translate<-1.8,0,-1.5>}
//--------------------------------------------------------------- end
