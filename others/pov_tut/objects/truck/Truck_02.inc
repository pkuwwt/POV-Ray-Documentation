// POV-Ray 3.6 include file "Truck_02.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller, Nov-2006
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Truck_02_Inc_Temp)
#declare Truck_02_Inc_Temp = version;
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
//-----------------------------------------
//-----------------------------------------
//-----------------------------------------
//---------------------------- object Wheel 
#declare Wheel = 
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

#declare Half = 1.00; // Halbe Spurweite
#declare Axis_Distance = 3.50;
//--------------------------------------------
//--------------------------------------------
#declare Wheel_D= //------------- double wheel
union{ 
object{ Wheel translate<0,0,-0.15>} 
object{ Wheel translate<0,0, 0.15>} 
} //------------------------------------------

#declare Double_Axes = //--------- double_Axes 
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

#declare BR = 0.10; // border radius

//--------------------------------------// Body - Karosserie
#macro Body (Car___Texture)

#local BHW = 1.10; //body half width 
#local FH = 1.10; // front height 
#local Front_Over = 0.80; // 
#local BL  = 1.60; // body length
#local BH = 2.00; // body height
#local Top_Length  = 1.00; // 
#local D = 0.000001; 

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
object{ Round_Box(
         <-BL/2,         0.01,-BHW-D>,
         <-BL/2+Top_Length-0.2,BH, BHW+D>, BR, 0)  
        matrix<  1  , 0, 0, //  matrix-shear_y_to_x
               -0.25, 1, 0,
                 0  , 0, 1,
                 0  , 0, 0>
        translate<0,0,0>
      } // --------------------------------------------
} // end of union positve parts 
 // ---------------------------------------------------
// inside caved out
object{ Round_Box(
         <-BL+0.01,              0.01,-BHW+0.01>,
         <-BL+Top_Length-0.01,BH-0.01, BHW-0.01>, BR,0)  
          
      } // --------------------------------------------
object{ Round_Box(
         <-BL/2,          FH+0.01,-BHW+D>,
         <-BL/2+Top_Length-0.2,BH, BHW-D>, BR, 0)  
        matrix<  1  , 0, 0, //  matrix-shear_y_to_x
               -0.25, 1, 0,
                 0  , 0, 1,
                 0  , 0, 0>
        translate<0,0,0>
      } // --------------------------------------------

// side Windows: 
object{ Round_Box(
         <-BL+BR,             FH,-BHW-0.01>,
         <-BL+Top_Length-BR,BH-BR, BHW+0.01>, BR, 0)  
         
      } // ---------------------------------------------
object{ Round_Box(
         <-BL/2+BR,               FH,-BHW-0.01+D>,
         <-BL/2+Top_Length-0.2-BR,BH-BR, BHW+0.01-D>, BR, 0)  
        matrix<  1  , 0, 0, //  matrix-shear_y_to_x
               -0.25, 1, 0,
                 0  , 0, 1,
                 0  , 0, 0>
        translate<0,0,0>
      } // --------------------------------------------

// front Windows: 
object{ Round_Box(
         <-BL+0.1,             FH+BR,-BHW+BR>,
         <-BL+Top_Length+0.50, BH-BR, BHW-BR>, BR, 0)  
      } // ---------------------------------------------
// hole for front wheels: 
cylinder{ <0,0,-BHW-0.01>,
          <0,0, BHW+0.01>, 0.60 
        } // end of cylinder  --------------------------

texture{ Car___Texture}
}// end of difference ----------------------------------

// inside in glass ---- with "merge on"!!!!
merge{ 
 object{ Round_Box(
         <-BL+0.005,                   BR+0.005,-BHW+0.005>,
         <-BL+Top_Length-0.01,BH-0.005, BHW-0.005>, BR, 1)  
       }
 object{ Round_Box(
         <-BL/2+0.005,               FH+0.01,-BHW+0.005-D>,
         <-BL/2+Top_Length-0.2-0.01,BH-0.005, BHW-0.005+D>, BR, 1)  
         matrix<  1  , 0, 0, //  matrix-shear_y_to_x
                -0.25, 1, 0,
                  0  , 0, 1,
                  0  , 0, 0>
         translate<0,0,0>
       } // --------------------------------------------
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

union{  // blinker right front:
object { Round_Box(<-0.100,-0.08,-0.015>,
                   < 0.025, 0.08, 0.22>, 0.035, 0)  
         texture{ pigment{ rgbf <0.98, 0.75, 0.55, 0.9> }
                  finish { reflection 0.35  
                           specular 0.8 roughness 0.0003 
                           phong 1 phong_size 400}
                 } // end of texture -------------------------
         scale<1,0.5,1>  rotate<0, 0,0> 
         translate<+0.02,0,-0.02>
       } // ---------------------------------------------------------
 
object { Round_Box(<-0.125,-0.09,-0.00>,
                   < 0.025, 0.09, 0.23>, 0.035, 0)  
         texture{ Polished_Chrome}
         scale<1,0.5,1>  rotate<0, 0,0> 
         translate<0,0,0>
       } // ---------------------------------------------------------
  translate<Front_Over ,0.45,-BHW+0.00>} 

union { // blinker left front
object { Round_Box(<-0.100,-0.08,-0.015>,
                   < 0.025, 0.08, 0.22>, 0.035, 0)  
         texture{ pigment{ rgbf <0.98, 0.75, 0.55, 0.9> }
                  finish { reflection 0.35  
                           specular 0.8 roughness 0.0003 
                           phong 1 phong_size 400}
                 } // end of texture -------------------------
         scale<1,0.5,1>  rotate<0, 0,0> 
         translate<+0.02,0,-0.02>
       } // ---------------------------------------------------------
 
object { Round_Box(<-0.125,-0.09,-0.00>,
                   < 0.025, 0.09, 0.23>, 0.035, 0)  
         texture{ Polished_Chrome}
         scale<1,0.5,1>  rotate<0, 0,0> 
         translate<0,0,0>
       } // ---------------------------------------------------------
   translate<Front_Over ,0.45,-BHW+0.00> scale<1,1,-1>} 



} #end // ------------------------------------- end of Body
//---------------------------------------------------------
 

#macro Trailer2( TrailerBody___Texture) //-----------------
#local Trailer_Length = 7.00; 
#local Trailer_Height = 2.20; 
#local Trailer_Half_Width = 1.20;
#local BHW = 1.10; //body half width 
#local Steal_D = 0.005; 

union{ //inclusive backlights
union{ 
 difference{ 
 union{ // sub union
  object{ Round_Box(<-Trailer_Length,             0,-Trailer_Half_Width>,
                    <              0,Trailer_Height, Trailer_Half_Width>, BR, 0)  
        } // -----------------------------------------------
  object{ Round_Box(<-Trailer_Length*0.9+0.05,         -0.03,-Trailer_Half_Width-0.05>,
                    <-Trailer_Length*0.9-0.05,Trailer_Height, Trailer_Half_Width+0.05>, BR, 0)  
        } // -----------------------------------------------
  object{ Round_Box(<-Trailer_Length*0.7+0.05,         -0.03,-Trailer_Half_Width-0.05>,
                    <-Trailer_Length*0.7-0.05,Trailer_Height, Trailer_Half_Width+0.05>, BR, 0)  
        } // -----------------------------------------------
  object{ Round_Box(<-Trailer_Length*0.5+0.05,         -0.03,-Trailer_Half_Width-0.05>,
                    <-Trailer_Length*0.5-0.05,Trailer_Height, Trailer_Half_Width+0.05>, BR, 0)  
        } // -----------------------------------------------
  object{ Round_Box(<-Trailer_Length*0.3+0.05,         -0.03,-Trailer_Half_Width-0.05>,
                    <-Trailer_Length*0.3-0.05,Trailer_Height, Trailer_Half_Width+0.05>, BR, 0)  
        } // -----------------------------------------------
  object{ Round_Box(<-Trailer_Length*0.1+0.05,         -0.03,-Trailer_Half_Width-0.05>,
                    <-Trailer_Length*0.1-0.05,Trailer_Height, Trailer_Half_Width+0.05>, BR, 0)  
        } // -----------------------------------------------
  // cabin shelter
  object{ Round_Box(< -BR,Trailer_Height*0.85-0.08 ,-Trailer_Half_Width>,
                    <1.00,Trailer_Height*0.85-0.001, Trailer_Half_Width>, 0.03, 0)  
        } // -----------------------------------------------
  } // end sub union

  object{ Round_Box(<-Trailer_Length+0.20,               Steal_D,-Trailer_Half_Width+Steal_D>,
                    <               -0.20,Trailer_Height+Steal_D, Trailer_Half_Width-Steal_D>, BR-Steal_D, 0)  
        } // -----------------------------------------------
  box{ <-Trailer_Length-Steal_D,Trailer_Height*0.85,-Trailer_Half_Width-0.10>,
       < Trailer_Length+Steal_D,Trailer_Height*1.20, Trailer_Half_Width+0.10>  } 
 translate<0,0.95,0>} // end difference



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

// backside light holder
object { // Round_Box(A, B, WireRadius, UseMerge)
         Round_Box(<0,-0.05,-BHW>,<0.08,0.05,BHW>, 0.015, 0)  
         
         texture{ pigment{ color rgb<1,1,1>*0.25}
                  finish {  phong 1}
                 }
         scale<1,1,1>  rotate<0, 0,0> translate<-Trailer_Length+0.00,0.55,0>
       } // ---------------------------------------------------------


union { // red light right backside
 object{ Round_Box(<-0.100,-0.08,-0.015>,
                   < 0.025, 0.08, 0.15>, 0.025, 0)  
         texture{ pigment{ rgbf <0.98, 0.15, 0.15, 0.9> }
                  finish { reflection 0.35  
                           specular 0.8 roughness 0.0003 
                           phong 1 phong_size 400}
                 } // end of texture -------------------------
         scale<1,0.75,1>  rotate<0, 0,0> 
         translate<+0.02,0,-0.02>
       } // ---------------------------------------------------------
 object{ Round_Box(<-0.125,-0.09,-0.035>,
                   < 0.025, 0.09, 0.16>, 0.035, 0)  
         texture{ Polished_Chrome}
         scale<1,0.75,1>  rotate<0, 0,0> 
         translate<0,0,0>
       } // ---------------------------------------------------------
  scale<-1,1,1> translate<-Trailer_Length,0.65,-BHW+0.04> } 

union { // red light left backside
 object{ Round_Box(<-0.100,-0.08,-0.015>,
                   < 0.025, 0.08, 0.15>, 0.035, 0)  
         texture{ pigment{ rgbf <0.98, 0.15, 0.15, 0.9> }
                  finish { reflection 0.35  
                           specular 0.8 roughness 0.0003 
                           phong 1 phong_size 400}
                 } // end of texture -------------------------
         scale<1,0.75,1>  rotate<0, 0,0> 
         translate<+0.02,0,-0.02>
       } // ---------------------------------------------------------
 object{ Round_Box(<-0.125,-0.09,-0.035>,
                   < 0.025, 0.09, 0.16>, 0.025, 0)  
         texture{ Polished_Chrome}
         scale<1,0.75,1>  rotate<0, 0,0> 
         translate<0,0,0>
       } // ---------------------------------------------------------
  scale<-1,1,1> translate<-Trailer_Length ,0.65,-BHW+0.04> scale<1,1,-1> } 

union { // blinker left backside
object { Round_Box(<-0.100,-0.08,-0.015>,
                   < 0.025, 0.08, 0.15>, 0.035, 0)  
         texture{ pigment{ rgbf <0.98, 0.75, 0.55, 0.9> }
                  finish { reflection 0.35  
                           specular 0.8 roughness 0.0003 
                           phong 1 phong_size 400}
                 } // end of texture -------------------------
         scale<1,0.5,1>  rotate<0, 0,0> 
         translate<+0.02,0,-0.02>
       } // ---------------------------------------------------------
 
object { Round_Box(<-0.125,-0.09,-0.035>,
                   < 0.025, 0.09, 0.16>, 0.035, 0)  
         texture{ Polished_Chrome}
         scale<1,0.5,1>  rotate<0, 0,0> 
         translate<0,0,0>
       } // ---------------------------------------------------------
  scale<-1,1,1> translate<-Trailer_Length ,0.52,-BHW+0.04> } 

union { // blinker right backside
object { Round_Box(<-0.100,-0.08,-0.015>,
                   < 0.025, 0.08, 0.15>, 0.025, 0)  
         texture{ pigment{ rgbf <0.98, 0.75, 0.55, 0.9> }
                  finish { reflection 0.35  
                           specular 0.8 roughness 0.0003 
                           phong 1 phong_size 400}
                 } // end of texture -------------------------
         scale<1,0.5,1>  rotate<0, 0,0> 
         translate<+0.02,0,-0.02>
       } // ---------------------------------------------------------
 
object { Round_Box(<-0.125,-0.09,-0.035>,
                   < 0.025, 0.09, 0.16>, 0.035, 0)  
         texture{ Polished_Chrome}
         scale<1,0.5,1>  rotate<0, 0,0> 
         translate<0,0,0>
       } // ---------------------------------------------------------
  scale<-1,1,1> translate<-Trailer_Length ,0.52,-BHW+0.04>  scale<1,1,-1>} 


}// end union incl. backlights

#end //------------------------------------ end of Trailer


//---------------------------------------------------------- 
//---------------------------------------------------------- 
//---------------------------------------------------------- 
#macro Truck_02( Wheel___Angle, // Front wheel angle: ~  +/-60
                 Trailer___Angle, // Trailer angle:   ~ +/-110
                 Truck___Texture 
               ) //------------------------------------------- 
union{ 
object{ Chassis (Wheel___Angle) }

object{ Body(Truck___Texture) translate<0,0.45,0>} 

object{ Trailer2(Truck___Texture) 
        translate<+1.2,0,0> 
        rotate<0,Trailer___Angle,0> 
        translate<-Axis_Distance,0,0> }

} // end of union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example: 
/*
//------------------------------------------------------------
#declare Trailer_Angle = 0; //  ~ +/-110
#declare Wheel_Angle   = 0; // ~  +/-60
#declare Truck_Texture =  
   texture{ pigment{ color rgb<1,1,1>*1.1}
            finish { diffuse 0.9 phong 1}
          }
//------------------------------------------------------------
#include "Truck_02.inc"
//------------------------------------------------------------
object{ Truck_02( Wheel_Angle, // Front wheel angle: ~  +/-60
                  Trailer_Angle, // Trailer angle:   ~ +/-110
                  Truck_Texture 
                 ) //-----------------------------------------
rotate<0,0,0> translate<3.00,0,-1.5>}
//------------------------------------------------------------


//---------------------------------------------------------------------------------------
*/


#version Truck_02_Inc_Temp;
#end
//------------------------------------- end of include file

