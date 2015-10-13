// POV-Ray 3.7 Scene File "adsorbing_media_02.pov"
// author: Friedrich A. Lohmueller, Oct-2008/Aug-2009 / Jan-2011
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
//-------------------------------------------------------------------------------------------------------<<<<
//-------------------------------------------------------------------------------------------------------<<<<
// camera ------------------------------------------------------------------
#declare Camera_Position = < 0.00, 1.50,-5.50>;  // front view
#declare Camera_look_at = < 0.00, 3, 0.00>; 
#declare Camera_Angle = 50 ; // in degrees
//--------------------------------------------------------------------------------------------------------<<<<
camera{ /*ultra_wide_angle*/   
        location  Camera_Position
        right     x*image_width/image_height
        angle Camera_Angle   
        look_at   Camera_look_at
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------------------------------------<<<<<
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.85}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>*0.5]
                                   [0.30 rgb <0.2,0.4,1.0>*0.5]
                                   [0.70 rgb <0.2,0.4,1.0>*0.5]
                                   [1.00 rgb <1.0,1.0,1.0>*0.5] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White*0.4
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <1.00,0.95,0.8>*0.5}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


// scattering media sample "dust devil"

cylinder{ <0,0,0>,<0,100,0>,1.5 
        pigment { rgbt 1 } 
        hollow   

       interior{ //---------------------
          media{ scattering{ 1, <1,1,1>  
                             extinction  2.5 } 
                 absorption rgb< 0.61, 0.85, 0.85>*2
                 // density 1
                 density{ spiral2 10
                          turbulence 0.20
                          color_map {
                                [0.00 rgb 0.00] // border 
                                [0.50 rgb 0.20] // 
                                [1.00 rgb 1.00] // center 
                              } // end color_map  
                          rotate<90,0,0>
                          scale<1,0.5,1>
                        } // end of density 1
                 // density 2 
                 density{ cylindrical 
                     turbulence 1.0
                     frequency 1
                       color_map {
                                [0.00 rgb 0.00] // border 
                                [0.50 rgb 0.20] // 
                                [0.80 rgb 1.00] // 
                                [1.00 rgb 0.50] // center 
                              } // end color_map  
                     scale<1,2,1>
                     } // end of density 2
                 
               } // end of media ----------------------------
            } // ------------------ end of interior
 
 scale <1,1,1> 
 rotate<0,0,-20>
 translate <   0.00, 0.10, 0.00> 
} //------------------ end of object

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
