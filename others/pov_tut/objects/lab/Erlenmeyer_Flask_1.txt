// POV-Ray 3.6 / 3.7 include file "Erlenmeyer_Flask_1.inc" 
// author: Friedrich A, Lohmueller, Feb-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Erlenmeyer_Flask_1_Inc_Temp)
#declare Erlenmeyer_Flask_1_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Erlenmeyer_Shape_1_Inc_Temp)
#include "Erlenmeyer_Shape_1.inc" 
#end
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- /////////  
#macro Erlenmeyer_Flask_1 ( Glass_D_,  // ~ 0.003, //                              
                            Base_Height_,  // ~ 0.25, // 
                            Base_Half_Width_, // 0.12; 
                            Neck_Length_    , // 0.05;
                            Neck_Radius_    , // 0.03;
                            Fillet_Radius_  , // 0.10;
                            Base_Border_Radius_, // 0.025;
                            Merge_On_, // 1 for transparent materials 
                          ) //----------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#if ( Merge_On_ = 1) merge{ 
#else               union{
#end 

difference{ //---------------------------------------------------------------------------
 object{ Erlenmeyer_Shape_1( Base_Height_, // Base_H, // 
                             Base_Half_Width_, // Base_Half_Width, //
                             Neck_Length_, // Neck_Len, // 
                             
                             Neck_Radius_, // Neck_R, // 
                             Fillet_Radius_, // Fillet_R, // 
                             Base_Border_Radius_, // Base_Border_R, //
                             
                             Merge_On_, // Merge_On, // 
                          ) //-------------------------
       }
 object{ Erlenmeyer_Shape_1( Base_Height_-Glass_D_*1.5, // Base_H, // 
                             Base_Half_Width_-Glass_D_, // Base_Half_Width, //
                             Neck_Length_+0.01, // Neck_Len, // 
                             
                             Neck_Radius_-Glass_D_, // Neck_R, // 
                             Fillet_Radius_+Glass_D_, // Fillet_R, // 
                             Base_Border_Radius_-Glass_D_, // Base_Border_R, //
                             
                             Merge_On_, // Merge_On, // 
                          ) //-------------------------
         
         translate<0,Glass_D_,0> 
       } 
 } // end of differnce ------------------------------------------------------------------

// neck brace 
torus{Neck_Radius_+Glass_D_, Glass_D_ translate<0,Base_Height_+Neck_Length_,0>} 

} // end of union  ---------------------------------------------------------------------- 
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
#declare Xxx_Texture = 
   texture { //Chrome_Metal}  
             pigment{ color rgb<1,1,1> } 
             finish { phong 0.1} 
           } // end of texture
//---------------------------------------------------------------------------------------
#include "Erlenmeyer_Flask_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Erlenmeyer_Flask_1(     , // sample of VAL
 
                   ) //----------------------------------------------------------------//
        texture { Xyz_Texture }
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Erlenmeyer_Flask_1_Inc_Temp;
#end
//------------------------------------- end of include file

