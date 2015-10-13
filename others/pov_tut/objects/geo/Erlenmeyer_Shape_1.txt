// POV-Ray 3.6 / 3.7 include file "Erlenmeyer_Shape_1.inc" 
// author: Friedrich A, Lohmueller, Feb-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Erlenmeyer_Shape_1_Inc_Temp)
#declare Erlenmeyer_Shape_1_Inc_Temp = version;
#version 3.6;


//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------------
#macro Erlenmeyer_Shape_1 (  Base_H, // 
                             Base_Half_Width, //
                             Neck_Len, // 
                             
                             Neck_R, // 
                             Fillet_R, //   // !  "Fillet_R < Base_H -2*Base_Border_R2
                             Base_Border_R, //   // r1 + r2 < Base_H 
                                                  
                             Merge_On, // 
                          ) //-------------------------

//------------------------------------------------------------------------------------
#local D  = 0.0001 ; 
//--------------------------------------------------------------- 
//-------------------------------- -> center of fillet circle: M1 
#local R1 = Fillet_R; 
#local X1 = (Neck_R+Fillet_R); 
#local Y1 = Base_H; 
#local M1 =  < X1,Y1,0>; 
#local M1L = <-X1,Y1,0>; 
//--------------------------------- -> center of base circle: M2 
// basis torus cross-section
#local R2 =  Base_Border_R; 
#local X2 =  Base_Half_Width - Base_Border_R;
#local Y2 =  Base_Border_R; // //negativ
#local M2  = < X2, Y2,0>; 
#local M2L = <-X2, Y2,0>; 
//--------------------------------------------------------------- 
// distance M1,M2 via Pytagoras: 
#local M_Dist = sqrt( pow(X2-X1,2) + pow(Y2-Y1,2) );//ok
// angle between x-direction and  direction M1,M2 :
#if (M1.x< M2.x)
 #local Cone_Angle =  180- abs ( degrees( atan( (Y2-Y1) / abs(X2-X1) ))); 
#else  
 #local Cone_Angle = abs( degrees( atan( (Y2-Y1) / (X2-X1) ))); 
#end 
//-----------------------------------------------------
 // Si = Schnittpunkt der Tangente von M2 an den vergrößertem Kreis um M1
// Länge M2_Si
#local M2_Si = sqrt( pow( M_Dist ,2) - pow( R1+R2,2));  
 // Winkel bei M1 in Dreieck Si_M1_M2:  
#local In_Angle =  abs( degrees( asin(   M2_Si / M_Dist   ) ))  ;
#local Xaxis_Angle = Cone_Angle-In_Angle ;

#local XSi =  X1 - (R1+R2)*cos( radians(Xaxis_Angle) );
#local YSi =  Y1 - (R1+R2)*sin( radians(Xaxis_Angle) );
#local Si = <XSi,YSi,0>;  
// oberer Tangentenpunkt  (aussen) bei M1 im Abstand R1:
#local T1 = M1-<(R1)*cos( radians(Xaxis_Angle)),(R1)*sin( radians(Xaxis_Angle)),0>;  
// unterer Tangentenpunkt (aussen) bei M2 im Abstand R2:
#local T2 = M2+<(R2)*cos( radians(Xaxis_Angle)),(R2)*sin( radians(Xaxis_Angle)),0>;  
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
// the body 
#if ( Merge_On = 1 ) merge{ 
#else union{ 
#end 
 // neck 
 cylinder{<0,-D,0>,<0,Neck_Len,0>, Neck_R translate<0,M1.y,0> } // pigment{ color rgb< 1,0.75,0> } }
 // fillet
 difference{ 
  cylinder{<0,T1.y-D,0>,<0,M1.y,0>, T1.x } // translate<0, 0,0> pigment{color rgb<0.3,0.5,0>} } //
  torus{ X1, R1 translate<0, M1.y,0> } //  pigment{ color rgb<0.5, 1,0> } }
 } // end of difference 
 // base cone 
 cone{<0,T2.y,0>,T2.x,<0,T1.y,0>,T1.x  } // pigment{ color rgb<0.75, 1,0> } }
 // base round + center fill
 cylinder{<0,-R2,0>,<0,R2,0>, X2  translate<0, Y2,0> }// pigment{color rgb<0.3,0.5,0>} } //
 torus{ X2, R2 translate<0, M2.y,0> } //  pigment{ color rgb<0.5, 1,0> } }

} // end of union or merge 
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#declare Base_Height_     = 0.25; 
#declare Base_Half_Width_ = 0.12; 
#declare Neck_Length_     = 0.05;
#declare Neck_Radius_     = 0.03;
#declare Fillet_Radius_   = 0.10; 
#declare Base_Border_Radius_ = 0.025; 
//---------------------------------------------------------------------------------------
#include "Erlenmeyer_Shape_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Erlenmeyer_Shape_1(  Base_Height_, // Base_H, // 
                             Base_Half_Width_, // Base_Half_Width, //  
                             Neck_Length_, // Neck_Len, // 
                             
                             Neck_Radius_, // Neck_R, // 
                             Fillet_Radius_, // Fillet_R, // 
                             Base_Border_Radius_, // Base_Border_R,//  
                             
                             0, // Merge_On, // 
                          ) //-------------------------
 
        texture { pigment{ color rgb< 1, 1, 1> }  
                  finish { phong 10}
                 } // end of texture 

        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Erlenmeyer_Shape_1_Inc_Temp;
#end
//------------------------------------- end of include file

