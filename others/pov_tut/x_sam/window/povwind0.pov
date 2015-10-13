// POV-Ray 3.6 / 3.7 Scene File "povwind0.pov"
// author: Friedrich A. Lohmueller, 2003/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc" 
#include "glass.inc" // !!!
// camera -----------------------------------------------------------------
#declare Camera_0 = camera { /*ultra_wide_angle*/ angle 47        
                            location<-1.7,1.0,-2.5>
                            right     x*image_width/image_height
                            look_at < -0.2, 1.0, 0.75>}
camera{ Camera_0 } 
// sun --------------------------------------------------------------------
light_source{<1500,1500,-2000> color White}
// sky --------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.76
                         color_map { [0.5 rgb <0.20, 0.20, 1.0>]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>}
	         normal { bumps 0.75 scale 0.015}
                 finish { phong 0.1}
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//--------------------------------------------------------
#declare Windtex = 
texture{pigment{ color White*1.1}
        finish { phong 1}}
//-------------------------------------------------
#declare Window = 
union{
 difference{
  box{<-0.50,0.80,-0.02>,< 0.50,1.80,0.02>}
  box{<-0.45,0.85,-0.03>,<-0.03,1.27,0.03>}
  box{< 0.03,0.85,-0.03>,< 0.45,1.27,0.03>}
  box{<-0.45,1.33,-0.03>,<-0.03,1.75,0.03>}
  box{< 0.03,1.33,-0.03>,< 0.45,1.75,0.03>}
  texture{Windtex}
  } // ---end of difference 
 box{<-0.49,0.81,0.0>,< 0.49,1.79,0.001>
 texture{T_Glass3}} // "ior"  not necessary!!!
 } // ---end of union                    
 
//Achtung: Der/die abzuziehenden          //Attention: The shapes to be subtracted 
// K�rper m�ssen eindeutig �ber den       // have to look out of the shape from where
// urspr�nglichen K�rper rausstehen !!!   // they will be subtracted !!!
//-------------Ende Fenster-Definition ---- end of Window definition -------

object{Window 
       rotate<0,0,0> 
       translate<0,0,0>} //Zeichne Fenster! 
object{Window 
       translate<0,-0.80,0>
       rotate<40,0,0> 
       translate<-0.75,0,-0.50>} //Zeichne Fenster! 
//-------------------------------------------- end 
 
 
 
 
 

