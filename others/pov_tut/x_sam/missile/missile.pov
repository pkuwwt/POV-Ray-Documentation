// POV-Ray 3.6 / 3.7 Example Scene File "missile.pov"
// author: Friedrich A. Lohmueller, 2005/Aug-2009/Jan-2011  
// email:  Friedrich.Lohmueller_at_t-online.de
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
#declare Camera_1 = camera { 
                             angle 65
                         
                             location  < 4.0 , 13.5 ,-5.0>
                             right     x*image_width/image_height
                             look_at   <-3.5 , 10.9  , 0.0>
                           }
camera{Camera_1}

// sun ---------------------------------------------------------------------
light_source{< 4500,3500,-2500> color White}
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
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment {color rgb <0.85,0.6,0.4>}
                normal  {bumps 0.75 scale 0.025  }
                finish  {ambient 0.1 diffuse 0.8 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
height_field{ tga "MountLo1.tga" smooth double_illuminate
              // file types: 
              // gif | tga | pot | png | pgm | ppm | jpeg | tiff | sys
              // [water_level N] // truncate/clip below N (0.0 ... 1.0)
              translate<-0.5,-0.001,0>
              scale<150,7,150> 
              texture{ pigment { color rgb <0.85,0.6,0.4>}
                       normal  { bumps 0.75 scale 0.025  }
                       finish  { phong 0.1 } 
                     } // end of texture
              rotate<0,0,0>
              translate<-100,0,0>
            } // end of height_field ----------------------------------

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------









//---------------------------------------------------------------- 
#macro Wing (Wing_Radius1,Wing_Radius2, Wing_Height, Wing_Sheer)  
       cone { <0,0,0>,Wing_Radius1,<0,Wing_Height,0>,Wing_Radius2  
              scale <1,1,0.1> 
              matrix<  1  , 0, 0,  // shearing in x
                     -Wing_Sheer, 1, 0,
                       0  , 0, 1,
                       0  , 0, 0>            
            } // end of cone -------------------------------------
#end //-----------------------------------------------------------

//---------------------------------------------------------------- 
#macro Missile (M_Radius, M_Len, M_Wing_Width, Tail_Scale)
union{

 sphere { <0,0,0>, M_Radius  scale<1.5,1,1>   
        }  // end of sphere -------------------------------------- 

 cylinder{ <-(M_Len-Tail_Scale*M_Radius),0,0>,<0,0,0>,M_Radius  
        } // end of cylinder -------------------------------------

 sphere { <0,0,0>, M_Radius scale< Tail_Scale,1,1> 
          translate<- (M_Len-Tail_Scale*M_Radius),0,0>  
        }  // end of sphere -------------------------------------- 
 
 // the wings     
 object{ Wing(0.75,0.25, 2.0, 0.35) translate<-M_Len+0.8,0,0>}
 object{ Wing(1.0,0.4, 3.5, 0.25) rotate < 85,0,0> translate<-M_Len*0.7,-M_Radius/2,0>} 
 object{ Wing(1.0,0.4, 3.5, 0.25) rotate <-85,0,0> translate<-M_Len*0.7,-M_Radius/2,0>}
     
 // the engines
 torus{ 0.8,0.5 
        rotate<0,0,90> 
        scale<7,1,1>*0.25 
        rotate<0,3,3> 
        translate<-M_Len*0.85,M_Radius*0.95,-M_Radius/2>
      } // end of torus  -------------------------------              

 torus{ 0.8,0.5 
        rotate<0,0,90> 
        scale<8,1,1>*0.25 
        rotate<0,3,3> 
        translate<-M_Len*0.85,M_Radius*0.95,-M_Radius/2>
        scale<1,1,-1>
      } // end of torus  -------------------------------              


}// end of union
#end //----------------------------------------------- end of missile macro

object{ Missile(0.5, 6.50, 3.00, 7)  
         texture {pigment { color White *0.75} // Chrome_Metal 
                  finish  { phong 1 reflection 0.05}
         } // end of texture
        rotate<5,0,0>
        translate<0,10,0> }


object{ Missile(0.5, 6.50, 3.00, 7)  
         texture {pigment { color White *0.75} // Chrome_Metal 
                  finish  { phong 1 reflection 0.05}
         } // end of texture
        rotate< 10, 8, 0> 
        translate<-50,10,5> }

//------------------------------------------------------------- end
