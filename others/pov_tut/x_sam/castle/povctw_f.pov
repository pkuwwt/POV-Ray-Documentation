// POV-Ray 3.7 Scene File "povctw_f.pov"
// author: Friedrich A. Lohmueller, 2005/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
// camera -----------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle 33       
                            location  <0.0 , 1.0 ,-12.0>
                            right x*image_width/image_height
                            look_at <0.0 , 4.55 , 0.0>}
camera{Camera_0} 
// sun --------------------------------------------------------
light_source{<1500,2500,-2500> color White}
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
    distance   150
    color      White
    fog_offset 0.1
    fog_alt    3.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment { color rgb <0.85,0.6,0.4>}
                normal  { bumps 0.75 scale 0.025  }
                finish  { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


//---------------------------------------------------------------------
#declare Walltex =  texture{pigment{ color White}
                            finish { phong 1}}
#declare Windtex =  texture{pigment{ color White}
                            finish { phong 1}}
#declare Rooftex =  texture{pigment{ color rgb<0.4,0.0,0.0>}
                            finish { phong 1}}
//---------------------------------------------------------------------
#declare TR =  2.0;   //TurmRadius --- tower radius
#declare TH =  5.0;   //TurmHöhe ----- tower height
//---------------------------------------------------------------------
#declare WindowHole = box{<-0.5,0.80,1.5>,<0.5,1.80,2.2>
                        texture{Walltex}} 
#declare Window = union{
difference{
  box{<-0.50,0.80,-0.02>,< 0.50,1.80,0.02>}
  box{<-0.45,0.85,-0.03>,<-0.03,1.27,0.03>}
  box{< 0.03,0.85,-0.03>,< 0.45,1.27,0.03>}
  box{<-0.45,1.33,-0.03>,<-0.03,1.75,0.03>}
  box{< 0.03,1.33,-0.03>,< 0.45,1.75,0.03>}
  texture{Windtex}}
box{<-0.49,0.81,0>,< 0.49,1.79,0.001>
    texture{T_Glass3}}
translate<0,0,1.80>}
//------------------------- Turm ---- tower -----------------
#declare Tower =
union{
 difference{
  union{
   cone{<0,-8,0>,3.0,<0,0,0>,2.0      texture{Walltex}}
   cylinder {<0,0,0>,<0,5,0>,2.0      texture{Walltex}}
   cylinder {<0,0.0,0>,<0,0.1,0>,2.05 texture{Walltex}}
   cylinder {<0,2.5,0>,<0,2.6,0>,2.05 texture{Walltex}}
   } // union
   cylinder {<0,-0.1,0>,<0,2.45,0>,1.7 texture{Walltex}}
   cylinder {<0,2.50,0>,<0,5.10,0>,1.7 texture{Walltex}}
   object{WindowHole rotate<0,  45,0> translate<0,0,0>}
   object{WindowHole rotate<0, 135,0> translate<0,0,0>}
   object{WindowHole rotate<0, 225,0> translate<0,0,0>}
   object{WindowHole rotate<0, 315,0> translate<0,0,0>}
   object{WindowHole rotate<0,  45,0> translate<0,2.50,0>}
   object{WindowHole rotate<0, 135,0> translate<0,2.50,0>}
   object{WindowHole rotate<0, 225,0> translate<0,2.50,0>}
   object{WindowHole rotate<0, 315,0> translate<0,2.50,0>}
   }//diff
 object{Window rotate<0, 135,0> translate<0,0,0>}
 object{Window rotate<0, 225,0> translate<0,0,0>}
 object{Window rotate<0, 315,0> translate<0,0,0>}
 object{Window rotate<0,  45,0> translate<0,2.50,0>}
 object{Window rotate<0, 135,0> translate<0,2.50,0>}
 object{Window rotate<0, 225,0> translate<0,2.50,0>}
 object{Window rotate<0, 315,0> translate<0,2.50,0>}
cone{<0,0,0>,2.5,<0,2.5,0>,0  translate<0,5,0> texture{Rooftex}}
cone{<0,0,0>,2.0,<0,5.5,0>,0  translate<0,5,0> texture{Rooftex}}
}  // end of Tower -----------------------------------------------
object{Tower}
//-..-------------------------------------------------------end--
