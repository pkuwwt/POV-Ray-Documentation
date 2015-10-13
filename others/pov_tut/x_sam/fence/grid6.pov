// POV-Ray 3.6 / 3.7 Scene File "grid6.pov"
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
#declare Cam1 = camera {ultra_wide_angle angle 5.3
                        location  <10.0 , 20.5 ,-28.0>
                        look_at   <0.9 , 1.10 , 0.0>}
camera{Cam1}
// sun ---------------------------------------------------------------
light_source{<2500,2500,-2500> color White}
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
#macro ClearGrid (Rscale )
 texture{ Raster(1.00, 0.04) rotate<0 ,45,0> scale Rscale rotate<90,0,0>} 
 texture{ Raster(1.00, 0.04) rotate<0,-45,0> scale Rscale rotate<90,0,0>}
#end //
//---------------------------------------------------------------
#declare Post = cylinder { <0,0,0>,<0,2.10,0>,0.07
          texture{ pigment{ color DarkWood}
                   normal { bumps 0.5 scale <0.001,0.1,0.001>}
                   finish { phong 1}}}


box {<0,0,0>,< 2,1.99,0.001> scale <1,1,1>                
     //texture{pigment{color rgb <1,1,1>*1.1} 
     //         finish {ambient 0.1 diffuse 0.9} }
     ClearGrid (0.2)
     
     rotate<0,0,0> translate<0.0,0,0>}

object{Post scale <1,1,1> rotate<0,0,0> translate<-0.06,0,-0.03>}
object{Post scale <1,1,1> rotate<0,0,0> translate< 2.06,0,-0.03>}
cylinder {<0,0,0>,<2,0,0>,0.008 scale <1,1,1> rotate<0,0,0> translate<0,1.97,0>
          texture{pigment{color Black}
                  finish {ambient 0.1 diffuse 0.9 phong 1}}}


//--------------------------------------------------------------- end
