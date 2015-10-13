// POV-Ray 3.6 / 3.7 include file "Round_Bottom_Mace_1.inc" 
// author: Friedrich A, Lohmueller, Feb-2010, Nov-2012
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Round_Bottom_Mace_1_Inc_Temp)
#declare Round_Bottom_Mace_1_Inc_Temp = version;
#version 3.6;

//------------------------------------------------------------------------------ /////////  
//----------------------------------------------------------------------------------
//----------------------------------------------------------------------------------
#macro Round_Bottom_Mace_1 (     //  A round-bottom flask  
                Neck_Base_Fillet_R_, // = 0.50, // > 0 // radius of  neck base fillet // Hohlkehle 
                Bowl_R, // = 1.00, // base bowl radius
                Neck_R, // = 0.30, // neck radius
                Neck_L, // = 1.00, // 0=non; neck linear length 
                Merge_On, // =1, //   1 for transparent materials, else: 0 
              ) //------------------------------------------------------------------
//----------------------------------------------------------------------------------
#local D = 0.001;
#local Neck_Base_Fillet_R = Neck_Base_Fillet_R_ ;


#if( Neck_Base_Fillet_R < D ) 
 //---------------------------------------------------------------------------------                 
 #debug concat("neck base fillet radius set to ",str(Neck_Base_Fillet_R,12,8),"\n",
                "should be > 0\n",
                "Set to  0.00001\n\n") 
 //---------------------------------------------------------------------------------                 
 #declare  Neck_Base_Fillet_R = D; 
#end
 
#local M1 = <Neck_Base_Fillet_R+Neck_R,0,0>;
#local Y2 = sqrt( pow(Neck_Base_Fillet_R+Bowl_R, 2) - pow(M1.x, 2));
#local M2 = <0,-Y2,0>; 

#local XS = M1.x * Bowl_R/(Neck_Base_Fillet_R+Bowl_R);
#local YS = M2.y * Neck_Base_Fillet_R/(Neck_Base_Fillet_R+Bowl_R);
#local S = <XS,YS,0>;
// -----------------------------------------------------------------
// calculation of real height 
#declare Total_Height_of_Mace = Y2 + Bowl_R + Neck_L;
//------------------------------------------------------------------


// base shape ------------------------------------------------------ 
#if ( Merge_On = 1) merge{ 
#else               union{
#end 

 difference{  
   cylinder{ <0,0,0>,<0,S.y,0>,S.x }      
   torus{ M1.x, Neck_Base_Fillet_R } 
 }// end diff 
 sphere{ M2, Bowl_R } 
 
 // neck ----------------------------------
 #if (Neck_L > 0)
 cylinder { <0,-D,0> ,<0,Neck_L,0>, Neck_R } 
 #end // of "#if( Neck_L > 0 )"
 //----------------------------------------

 translate<0,-M2.y+Bowl_R,0> 
} // end of union or merge --------------------------------------------------------
#end //--------------------------------------------------------------- end of macro   
//---------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
#declare Round_Bottom_Mace_Texture = 
        texture { pigment{ color rgb< 1, 1, 1.00> } // very pale red violet
               // normal { bumps 0.5 scale 0.05 }
                  finish { diffuse 0.9 phong 1 reflection 0.00}
                } // end of texture 
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
#declare D = 0.000001;
#declare Glass_D = 0.004*1;
#declare Neck_Fillet =  0.050*1; // > 0 !!!
#declare Bowl_Radius = 0.100*1;
#declare Neck_Radius = 0.030*1;  
#declare Neck_Length = 0.100*1; 
//---------------------------------
#include "Round_Bottom_Mace_1.inc" 
//---------------------------------
// Round_Bottom_Flask_000 
//merge{ 

//difference{ 
object{ Round_Bottom_Mace_1 (     //  A round-bottom flask shape 
                // declares: Total_Height_of_Mace
                Neck_Fillet, // > 0 // neck base fillet // Hohlkehle 
                Bowl_Radius, // base bowl radius
                Neck_Radius, // neck radius
                Neck_Length, // 0=non; neck linear length 
                1, //   1 for transparent materials, else: 0 
              ) //------------------------------------------------------------------  
        texture{ Round_Bottom_Mace_Texture }  
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>
}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Round_Bottom_Mace_1_Inc_Temp;
#end
//------------------------------------- end of include file

