// POV-Ray 3.6 / 3.7 Scene File "p_tatami.pov"
// author: Friedrich A. Lohmueller, 2005/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
global_settings { noise_generator 1 }

#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "stones.INC"
#include "stones2.INC"
#include "woods.INC"


// camera -----------------------------------------------------------
#declare CamPosition = < 5.5 ,1.4 , 7.90>;
#declare Cam=camera {ultra_wide_angle angle 60
                     location CamPosition
                     right x*image_width/image_height
                     look_at   <-1.5,-0.6 ,2>}

camera{Cam }
light_source{CamPosition color <1.0,0.98,0.9>*0.35}

// sun --------------------------------------------------------------
 light_source{<-2000,2500,-2400> color White *0.8}
//-------------------------------------------------------------------

// sky ----------------------------------------------------------------------------
plane{<0,1,0>,1 hollow
       texture{ pigment{ bozo turbulence 0.76 translate <-2,0,0>
                         color_map { [0.5 rgb <0.20, 0.20, 1.0>]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }
       scale 10000}
// fog ----------------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.5
    turbulence 0.8}

// ground -------------------------------------------------------------------------
plane { <0,1,0>, 0
        texture{ pigment{ color rgb<0.35,0.65,0.0>}
	         normal { bumps 0.5 scale 0.01}
                 finish { phong 0.1}
               } // end of texture
      } // end of plane
//---------------------------------------------------------------------------------
//---------------------------- objects in scene -----------------------------------
//---------------------------------------------------------------------------------


//--------------------------------------------------------------------
#declare TatamiTex1 = texture{ pigment{ color rgb<0.95,0.90,0.70>*1.1 }
                               normal { bumps 0.2 scale 0.005 }
                               finish { phong 0.3}}
#declare TatamiTex2 = texture{ pigment{ color MediumWood*0.5 quick_color MediumWood}
                               normal { bumps 0.3 scale 0.005 }
                               finish { phong 1}}
#declare CushionTex1= texture{ pigment{ color rgb<0.95,0.90,0.80>*1.15 }
                               normal { bumps 0.2 scale 0.05 }
                               finish { phong 0.3}}

//----------------------------------------------------------------------------------------------
#declare T = 1.94/2; // tatami raster width

//----------------------------------------------------------------------------------------------
#macro TatamiX(WideX,WideZ)
#local TatamiHeight= 0.025;
#local TatamiBorder= 0.04;
#local D = 0.005;
union{
box {<D,0,WideZ-TatamiBorder>,< WideX-D,TatamiHeight,WideZ-D              > texture{TatamiTex2}}
box {<D,0,      TatamiBorder>,< WideX-D,TatamiHeight,WideZ-TatamiBorder> texture{TatamiTex1}}
box {<D,0,                +D>,< WideX-D,TatamiHeight,      TatamiBorder> texture{TatamiTex2}}
} #end // of Tatami(WideX,WideZ)
//----------------------------------------------------------------------------------------------


union{
object{TatamiX(2*T,T) rotate<0, 0,0> translate< 1*T,0, 0*T>}
object{TatamiX(2*T,T) rotate<0, 0,0> translate< 1*T,0, 3*T>}
object{TatamiX(2*T,T) rotate<0,-90,0>scale<-1,1,1> translate<0*T,0, 0*T>}
object{TatamiX(2*T,T) rotate<0,-90,0>scale<-1,1,1> translate<0*T,0, 2*T>}

object{TatamiX(2*T,T) rotate<0,-90,0>scale<-1,1,1> translate< 1*T,0, 1*T>}
object{TatamiX(2*T,T) rotate<0,-90,0>scale<-1,1,1> translate< 2*T,0, 1*T>}

object{TatamiX(2*T,T) rotate<0,-90,0>scale<-1,1,1> translate<3*T,0, 0*T>}
object{TatamiX(2*T,T) rotate<0,-90,0>scale<-1,1,1> translate<3*T,0, 2*T>}
//object{TatamiX(2*T,T) rotate<0,-90,0>scale<-1,1,1> translate<4*T,0, 0*T>}

  translate<0.07,0.00,3.07>}
