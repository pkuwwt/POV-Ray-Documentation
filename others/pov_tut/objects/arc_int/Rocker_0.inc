// POV-Ray 3.6/3.7 include file "Rocker_0.inc"
// author: Friedrich A, Lohmueller, Aug-2012
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Rocker_0_Inc_Temp)
#declare Rocker_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// needs: #include "shapes.inc" 
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end

//------------------------------------------------------------------------------ /////////  
#macro Rocker_0( Rocking_Angle )
//---------------------------------
#local D = 0.00001; 
//---------------------------------
#local R_Rocker = 1.20; 
#local Circumference = 2*pi*R_Rocker; 
#local R_seat = 0.90; 
#local R_rotate = 25; 
#local R_width = 0.30; 
#local D_feet = 0.055;
#local R_feet = 0.02;
#local D_seat = 0.30;
//---------------------------------
//---------------------------------
#local Skid = 
union{ 
 intersection{ 
   box{ <-R_Rocker,-R_Rocker-D,-D_feet/2-2*D> ,<0,R_Rocker+D,D_feet/2+2*D> rotate<0,0,-R_rotate> inverse }
   box{ <-R_Rocker,-R_Rocker-D,-D_feet/2-2*D> ,<0,R_Rocker+D,D_feet/2+2*D> rotate<0,0,-R_rotate> inverse scale<-1,1,1>} 
   cylinder{<0,0,-D_feet/2>,<0,0,D_feet/2>, R_Rocker } 
   cylinder{<0,0,-D_feet/2-D>,<0,0,D_feet/2+D>, R_Rocker-D_feet inverse} 
 } 
   // 
   cylinder{<0,0,-D_feet/2>,<0,0,D_feet/2>, D_feet/2 translate<0,-R_Rocker+D_feet/2,0> rotate<0,0, R_rotate> } 
   cylinder{<0,0,-D_feet/2>,<0,0,D_feet/2>, D_feet/2 translate<0,-R_Rocker+D_feet/2,0> rotate<0,0,-R_rotate> } 
   // feet
   cylinder{ <0,-R_Rocker,0>,<0,-R_seat+0.03 ,0>, R_feet rotate<0,0, R_rotate*0.6> } 
   cylinder{ <0,-R_Rocker,0>,<0,-R_seat+0.03 ,0>, R_feet rotate<0,0,-R_rotate*0.6> } 
}// end union Skid
//-----------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------

union{ // final union                                   
 object{ Skid translate<0,0, R_width > } 
 object{ Skid translate<0,0,-R_width > } 
 // conections 
  cylinder{<0,0,-R_width>,<0,0,R_width>, R_feet translate<0,-R_Rocker+R_feet,0> rotate<0, 0, R_rotate-5 >}  
  cylinder{<0,0,-R_width>,<0,0,R_width>, R_feet translate<0,-R_Rocker+R_feet,0> rotate<0, 0,-R_rotate+5 >}  


 union{ // seat and back
  // seat
  object{ // Round_Box(A, B, WireRadius, UseMerge)
          Round_Box(<-D_seat,0,-R_width-0.02>,<D_seat,0.055,R_width+0.02>, 0.025, 0)  
        } // ------------------------------------------------------------------------
  // back
  object{ // Round_Box(A, B, WireRadius, UseMerge)
          Round_Box(<-D_seat,0,-R_width>,<D_seat+0.10,0.055,R_width>, 0.025, 0)  
          translate<D_seat,0,0> rotate<0, 0,70>  translate<D_seat-0.05,0,0>
        } // ------------------------------------------------------------------------
  // arms left
  union{  
         object{ // Round_Box(A, B, WireRadius, UseMerge)
                 Round_Box(<-2*D_seat,0,-D_feet/2>,<0.05,0.045,D_feet/2>, 0.02, 0)  
                 rotate<0,0,-3 > translate<D_seat,0.15,0>
               } // ----------------------------------------------------------------- 
         cylinder{<0,0,0>,<0,0+0.18,0>, R_feet 
                  translate<-D_seat+0.05,0,0>
               }      
         translate<0,0,-R_width>
       }  // end union arms left 
  // arms right
  union{  
         object{ // Round_Box(A, B, WireRadius, UseMerge)
                 Round_Box(<-2*D_seat,0,-D_feet/2>,<0.05,0.045,D_feet/2>, 0.02, 0)  
                 rotate<0,0,-3 > translate<D_seat,0.15,0>
               } // -----------------------------------------------------------------
         cylinder{<0,0,0>,<0,0+0.18,0>, R_feet 
                  translate<-D_seat+0.05,0,0>
               }      
         translate<0,0,-R_width>  scale<1,1,-1>
       } // end union arms right 
  translate<0,-R_seat +0.05,0>
 }// end union  seat and back --------------------------------------------------------
 //----------------------------------------------------------------------------------- 
 


rotate< 0,0,Rocking_Angle >
translate< 0, R_Rocker, 0> 

// move by the according part of the circumference: 
translate< -(2*pi*R_Rocker)*(Rocking_Angle/360),0,0> 

} // end final union

#end// of macro ------------------------------------------------------// end of macro
//--------------------------------------------------------------------// end of macro Rocker() 
//-----------------------------------------------------------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-----------------------------------------------------------------------------// 
#declare Time =  clock - 0.00 ; 
#include "Rocker_0.inc" 
//-----------------------------------------------------------------------------//
object{  Rocker_0( 12* sin(Time*2*pi) -2 ) //  ( Rocking_Angle  ) 
         texture { pigment{ color rgb< 0.75, 0.5, 0.30>*0.35 }// very dark brown  
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture 
         rotate<0,  0,0>
         translate<0,0,0> 
      } // end of Rocker
//-----------------------------------------------------------------------------//
//-----------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Rocker_0_Inc_Temp;
#end
//------------------------------------- end of include file

