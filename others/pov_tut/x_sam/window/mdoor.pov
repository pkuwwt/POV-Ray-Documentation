// POV-Ray 3.6 / 3.7 Example Scene File "mdoor.pov"
// author: Friedrich A. Lohmueller, Jan-2006/Aug-2009/Jan-2011 
// email:  Friedrich.Lohmueller_at_t-online.de
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_1 = camera {ultra_wide_angle angle 12          
                            location  <10.0 , 3.5 ,-15>
                            right     x*image_width/image_height
                            look_at   <0.1 , 1.10 , 0.0>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.76 scale 3
                         color_map { [0.5 rgb <0.20, 0.20, 1.0>]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   150
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{color rgb<0.35,0.65,0.0>}
	         normal {bumps 0.75 scale 0.015}
                 finish {ambient 0.1 diffuse 0.8}
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



#declare Wall_D = 0.20 ;// the thickness of the Wall 

// ------------------------------------------------ Doors_Positions
#declare Door_Positon_1 = <-1,0,Wall_D/3>;
#declare Door_Positon_2 = < 1,0,Wall_D/3>;


// ------------------------------------------------ end of Doors_Positions

#declare Wall_Texture_1 = 
texture { pigment{ color White*1.1}
          normal { bumps 0.5 scale 0.005} 
          finish { phong 1}
        } // end of texture

#declare Wall_Texture_2 = 
texture { pigment{ color White*1.1}
          finish { phong 1}
        } // end of texture

//---------------------------------------------------------- Door Textures 
#declare Door_Texture_1 = 
texture{pigment{color  rgb<0.40,0.25,0.15>*1.5}//*1.2}
        finish {phong 0.1}}

//------------------------------------------------------------------------


//---------------------------------------------------- the Door(...) macro
#macro Door (Door_Angle) 
union{
 difference{
  box{<-0.50,0.01,-0.02>,< 0.50,1.80,0.02>}
  box{<-0.45,0.85,-0.03>,<-0.03,1.27,0.03>}
  box{< 0.03,0.85,-0.03>,< 0.45,1.27,0.03>}
  box{<-0.45,1.33,-0.03>,<-0.03,1.75,0.03>}
  box{< 0.03,1.33,-0.03>,< 0.45,1.75,0.03>}
  texture{Door_Texture_1}
  } // ---end of difference 
 box{<-0.49,0.81,0.0>,< 0.49,1.79,0.001>
   texture{T_Glass3}}  // no interior!!!
 union{ // II
   sphere  {<-0.15,0,-0.07>, 0.015 }
   cylinder{<-0.15,0,-0.07>,<0,0,-0.10>, 0.015}
   sphere  {< 0,0,-0.07>, 0.015}
   cylinder{< 0,0,-0.07 >,<0,0,0>, 0.015}
   cylinder{< 0,0,-0.035>,<0,0,0>, 0.04}
   texture { Chrome_Metal }
   translate<0.43,0.75,0>
   }// end of union II
 translate<0.50,0,0> 
 rotate<0,-Door_Angle,0>
 translate<-0.50,0,0> 
 
 } // ---end of union
#end 

#declare Door_Hole =   //symmetric!!!
  box{<-0.50,0.01,-0.50>,< 0.50,1.80,0.50>
      texture{Wall_Texture_2}}

//--------- end of Door definitions ---------


difference{ //--------------------------------------------
box { <-2,0,0>,< 2,2.3,0.2>   
      texture {Wall_Texture_1}  
    }
object{ Door_Hole translate Door_Positon_1}
object{ Door_Hole translate Door_Positon_2}
}// -----------------------------------------------------

//----------------------------------------------- Doors
object{ Door  (85)              translate Door_Positon_1}
object{ Door  (25)scale<-1,1,1> translate Door_Positon_2}

//----------------------------------------------------- end
