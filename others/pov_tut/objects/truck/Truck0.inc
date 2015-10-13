// POV-Ray 3.6/3.7 include file "Truck0.inc"                                                                                                                                 // author: Friedrich A, Lohmueller, Jan-2006, Dec-2012
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Truck0_Inc_Temp)
#declare Truck0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end



//------------------------------------------------------------------------------ /////////  
#macro Truck0( Wheel___Angle, // Front wheel angle: ~  +/-60
               Trailer___Angle, // Trailer angle:   ~ +/-110
               Truck___Texture 
             ) //------------------------------------------- 
//-----------------------------------------
//-----------------------------------------
//-----------------------------------------
// Truck elements: 
//-----------------------------------------
//---------------------------- object Wheel 
#local Wheel = 
union{ 
 intersection{
  torus{ 0.35,0.15  rotate<90,0,0> }
  cylinder{ <0,0,-0.20>,<0,0,0.20>, 0.47}
 
  texture{ pigment{ color rgb<1,1,1>*0.15}
           normal { bumps 0.5 scale 0.005}  
           finish { diffuse 0.9 phong 0.2}
         } // end of texture
 }// end intersection
 sphere{ <0,0,0>,0.45 scale<1,1,0.25> 
          texture { 
            Chrome_Metal 
            normal{ bumps 0.5 scale 0.005}  
            finish{ diffuse 0.9 phong 0.5}
          } // end of texture
 } // end of sphere -----------------------

translate<0,0.45,0>
} // end of union ----- end of object Wheel 
//-----------------------------------------
//-----------------------------------------
//-----------------------------------------

#local Half = 1.00; // Halbe Spurweite
#local Axis_Distance = 3.50;
//--------------------------------------------
//--------------------------------------------
#local Wheel_D= //------------- double wheel
union{ 
object{ Wheel translate<0,0,-0.15>} 
object{ Wheel translate<0,0, 0.15>} 
} //------------------------------------------

#local Double_Axes = //--------- double_Axes 
union{ 
object{ Wheel_D translate<-0.60,0,-Half>} 
object{ Wheel_D translate<-0.60,0, Half>} 
object{ Wheel_D translate<+0.60,0,-Half>} 
object{ Wheel_D translate<+0.60,0, Half>} 
} //------------------------------------------

//--------------------------------------------
#macro Chassis (Front_Wheel___Angle)  
//------------------------------------ Chassis
union{
object{ Wheel rotate<0,Front_Wheel___Angle,0> 
        translate<0,0,-Half>} 
object{ Wheel rotate<0,Front_Wheel___Angle,0> 
        translate<0,0, Half>} 
object{ Double_Axes 
        translate<-Axis_Distance,0,0>} 
object{ Round_Box( //-------------------------
        <-Axis_Distance-1,  0,-0.5>,
        <            0.25,0.5, 0.5>, 0.025, 0)  
        texture{ pigment{ color rgb 0.2}
                 finish { diffuse .9 phong .1}
                 }
        translate<0,0.40,0>
      } // -----------------------------------
// trailer linking point
cylinder{ <0,0,0>,<0,0.15,0>,0.25 
          translate<-Axis_Distance,0.8,0>
          pigment{ color rgb 0.3} }
} // end of union  ------------ end of Chassis 
#end // --------------------------------------

#local BR = 0.10; // border radius


//--------------------------------------// Body - Karosserie
#macro Body (Car___Texture)

#local BHW = 1.10; //body half width 
#local FH = 1.10; // front height 
#local Front_Over = 0.80; // 
#local BL  = 1.60; // body length
#local BH = 2.00; // body height
#local Top_Length  = 1.00; // 

union{  // with glass
difference{ // cave out the window holes etc.
union{ //-------------------------- positive parts
object{ Round_Box(
         <-BL,         0,-BHW>,
         < Front_Over,FH, BHW>, BR, 0)  
      } // --------------------------------------------
object{ Round_Box(
         <-BL,         0.01,-BHW>,
         <-BL+Top_Length,BH, BHW>, BR, 0)  
      } // --------------------------------------------
} // end of union positve parts 
 // ---------------------------------------------------
// inside caved out
object{ Round_Box(
         <-BL+0.01,              0.01,-BHW+0.01>,
         <-BL+Top_Length-0.01,BH-0.01, BHW-0.01>, BR,0)  
          
      } // --------------------------------------------
// side Windows: 
object{ Round_Box(
         <-BL+BR,             FH,-BHW-0.01>,
         <-BL+Top_Length-BR,BH-BR, BHW+0.01>, 0.10, 0)  
         
      } // ---------------------------------------------
// front Windows: 
object{ Round_Box(
         <-BL+0.1,            FH+BR,-BHW+BR>,
         <-BL+Top_Length+2*BR, BH-BR, BHW-BR>, 0.10, 0)  
      } // ---------------------------------------------
// hole for front wheels: 
cylinder{ <0,0,-BHW-0.01>,
          <0,0, BHW+0.01>, 0.60 
        } // end of cylinder  --------------------------

texture{ Car___Texture}
}// end of difference ----------------------------------

// inside in glass ---- with "merge on"!!!!
object{ Round_Box(
        <-BL+0.005,          BR+0.705,-BHW+0.005>,
        <-BL+Top_Length-0.01,BH-0.005, BHW-0.005>, BR, 1)  
        texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                 finish { reflection 0.2  
                          specular 0.8 roughness 0.0003 
                          phong 1 phong_size 400}
       } // end of texture -------------------------
      } // -----------------------------------------------
// add lights: 
union{
object { Round_Box(<-0.025,-0.12,-0.22>,
                   < 0.025, 0.12, 0.22>, 0.025, 0)  
         texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { reflection 0.35  
                           specular 0.8 roughness 0.0003 
                           phong 1 phong_size 400}
                 } // end of texture -------------------------
         scale<1,1,1>  rotate<0, 0,0> 
         translate<+0.02,0,0>
       } // ---------------------------------------------------------
object { Round_Box(<-0.025,-0.13,-0.23>,
                   < 0.025, 0.13, 0.23>, 0.015, 0)  
         texture{ Polished_Chrome}
         scale<1,1,1>  rotate<0, 0,0> 
         translate<0,0,0>
       } // ---------------------------------------------------------
   translate<Front_Over,0.85,-BHW+0.35>} 
union{
object { Round_Box(<-0.025,-0.12,-0.22>,
                   < 0.025, 0.12, 0.22>, 0.025, 0)  
         texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                  finish { reflection 0.35  
                           specular 0.8 roughness 0.0003 
                           phong 1 phong_size 400}
                 } // end of texture -------------------------
         scale<1,1,1>  rotate<0, 0,0> 
         translate<+0.02,0,0>
       } // ---------------------------------------------------------
object { Round_Box(<-0.025,-0.13,-0.23>,
                   < 0.025, 0.13, 0.23>, 0.015, 0)  
         texture{ Polished_Chrome}
         scale<1,1,1>  rotate<0, 0,0> 
         translate<0,0,0>
       } // ---------------------------------------------------------
   translate<Front_Over,0.85,-BHW+0.35> scale<1,1,-1>} 

// bumper: 


object { Round_Box(<-0.125,-0.05,-BHW-0.05>,
                   < 0.025, 0.30, BHW+0.05>, 0.05, 0)  
         texture{ Chrome_Metal 
                  normal{bumps 0.25 scale 0.015}
                } // end of texture -------------------------
         scale<1,1,1>  rotate<0, 0,0> 
         translate<Front_Over,0.0,0> 
       } // ---------------------------------------------------------



} #end // ------------------------------------- end of Body
//---------------------------------------------------------
 

#macro Trailer( TrailerBody___Texture) //-----------------
#local Trailer_Length = 7.00; 
#local Trailer_Height = 2.20; 
#local Trailer_Half_Width = 1.20;

union{ 
object{ Round_Box(
        <-Trailer_Length,0,-Trailer_Half_Width>,
        <0,Trailer_Height,Trailer_Half_Width>, BR, 0)  
        translate<0,0.95,0>
      } // -----------------------------------------------
object{ Double_Axes
        translate<-Trailer_Length+1.60,0,0>  
      } // -----------------------------------------------
object{ Round_Box(<-1.5,0,-0.5>,<1.5,0.50, 0.5>, 0.025, 0)  
        texture{ pigment{ color rgb<1,1,1>*0.2}
                 finish { diffuse 0.9 phong 1}
               }
         translate<-Trailer_Length+1.60,0.5,0>
       } // ----------------------------------------------

texture{ TrailerBody___Texture }
}// end of union 
#end //------------------------------------ end of Trailer
//--------------------------------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
//---------------------------------------------------------- final union 
union{ 
object{ Chassis (Wheel___Angle) }

object{ Body( texture{Truck___Texture translate<0,-0.45,0>} ) translate<0,0.45,0>} 

object{ Trailer(texture{Truck___Texture translate<-1.2+Axis_Distance,0,0>} ) 
        translate<+1.2,0,0> 
        rotate<0,Trailer___Angle,0> 
        translate<-Axis_Distance,0,0> }

} // end of final union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------
#declare Trailer_Angle = 0; //  ~ +/-110
#declare Wheel_Angle   = 0; // ~  +/-60
#declare Truck_Texture =  
   texture{ pigment{ color rgb<1,1,1>*1.1}
            finish { diffuse 0.9 phong 1}
          }
//----------------------------------------
#include "Truck0.inc"
//---------------------------------------------------------
object{ Truck0( Wheel_Angle, // Front wheel angle: ~  +/-60
                Trailer_Angle, // Trailer angle:   ~ +/-110
                Truck_Texture 
              ) //-----------------------------------------
rotate<0,0,0> translate<3.00,0,-1.5>}
//---------------------------------------------------------


//---------------------------------------------------------------------------------------
*/


#version Truck0_Inc_Temp;
#end
//------------------------------------- end of include file

