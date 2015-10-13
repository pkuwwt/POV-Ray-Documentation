// POV-Ray 3.7/3.6 include file "Railing_1.inc"
// author: Friedrich A, Lohmueller, Jan-2011
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Railing_1_Inc_Temp)
#declare Railing_1_Inc_Temp = version;
#version 3.6; // 3.7; // 3.6

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//--------------------------------------------------------------------///////////////////
//--------------------------------------------------------------------///////////////////
#macro Railing_1( R_Len, // railing length in x
                  R_H,   // railing height in y
                  R_D,   // railing vertical ~distance
                  R_R,   // railing main radius
                  VSD,   // vertical subdivision
                )//-----------------------------------------------  
//---------------------------------------------------------------
#ifndef( Railing_Texture_1 )
#declare Railing_Texture_1 =
         texture { pigment{ color rgb< 1, 1, 1>*0.7 }  
                   normal { bumps 0.25 scale 0.35 }
                   finish { phong 0.3 }
                 } // end of texture 
#end // --------------------------------------------------------- 
//---------------------------------------------------------------
#local NumVerticals = int ( R_Len / R_D ) ; 
#local VerticalsDistance = R_Len / NumVerticals ; // equidistant!
//---------------------------------------------------------------
//---------------------------------------------------------------
union{
 // horizontals 
 cylinder{<0,0,0>,<R_Len,0,0>, R_R     translate<0,R_H    ,0>} 
 sphere{<0,0,0>, R_R translate<    0,R_H,0>} 
 sphere{<0,0,0>, R_R translate<R_Len,R_H,0>} 
 // vertical subdivision
 #if (VSD > 0)
  #local Nr = 1; // start loop
  #while (Nr < VSD )
   cylinder{<0,0,0>,<R_Len,0,0>, R_R*1/2 translate<0,Nr*R_H/(VSD),0>} 
  #local Nr = Nr + 1;
  #end // end of loop


 #end

 // verticals
 #local Nr = 0;
 #while (Nr <= NumVerticals) 
  cylinder{<0,0,0>,<0,R_H,0>, R_R     translate<Nr*VerticalsDistance,0,0>} 
 #local Nr = Nr +1 ;
 #end 
 texture{ Railing_Texture_1 } 
} // end of union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro
//--------------------------------------------------------------------///////////////////
//--------------------------------------------------------------------///////////////////




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-------------------------------------------------------------------- optional texture
#declare Railing_Texture_1 =
         texture { Chrome_Metal
                   // pigment{ color rgb< 1, 1, 1>*0.7 }  
                   normal { bumps 0.25 scale 0.35 }
                   finish { phong 0.3 }
                 } // end of texture 
//---------------------------------------------------------------------------------------
#include "Railing_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Railing_1( 5.00,  // railing length in x // i.e. 5.00, 
                   1.00,  // railing height in y // i.e. 1.00, 
                   0.80,  // railing vertical ~distance // i.e. 1.00,
                   0.025, // railing main radius   // i.e. 0.025, 
                   3,     // vertical subdivision  // integer, i.e. 0, 1, 2, ...
                 ) //------------------------------------------------------------------//

        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Railing_1_Inc_Temp;
#end
//------------------------------------- end of include file

