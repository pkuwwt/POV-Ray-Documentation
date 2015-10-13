// POV-Ray 3.6/3.7 include file "Round_Bottom_Flask_1.inc"
// author: Friedrich A, Lohmueller, Feb-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Round_Bottom_Flask_1_Inc_Temp)
#declare Round_Bottom_Flask_1_Inc_Temp = version;
#version 3.6;

//------------------------------------------------------------------------------ /////////  
//---------------------------------------------------------------------------------
#ifndef(  Round_Bottom_Mace_1_Inc_Temp)
#include "Round_Bottom_Mace_1.inc"
#end
//---------------------------------------------------------------------------------
#macro Round_Bottom_Flask_1 (     //  A round-bottom flask  
                Glass_D, // 0.004, // 
                Neck_Fillet_R, // = 0.050, // > 0 //radius neck base fillet // Hohlkehle 
                Bowl_Radius, // = 0.100, // base bowl radius
                Neck_Radius, // = 0.030,  // neck radius
                Neck_Length, // = 0.100, // 0=non; neck linear length 
                Merge_On, // =1, //   1 for transparent materials, else: 0 
              ) //------------------------------------------------------------------
//----------------------------------------------------------------------------------
#local D = 0.001;
#if( Neck_Fillet_R < D ) 
 //---------------------------------------------------------------------------------                 
 #debug concat("neck base fillet radius set to ",str(Neck_Fillet_R,12,8),"\n",
                "should be > 0\n",
                "Set to  0.00001\n\n") 
 //---------------------------------------------------------------------------------                 
 #declare  Neck_Fillet_R = D; 
#end
//----------------------------------------------------------------------------------

#declare D = 0.000001;
#declare Glass_D = 0.004*1;
#declare Neck_Fillet =  0.050*1;
#declare Bowl_Radius = 0.100*1;
#declare Neck_Radius = 0.030*1;  
#declare Neck_Length = 0.100*1; 
//----------------------------------------------------------------------------------
//----------------------------------------------------------------------------------
// Round_Bottom_Flask_1 
#if ( Merge_On = 1) merge{ 
#else               union{
#end 

difference{ 
object{ Round_Bottom_Mace_1 (     //  A round-bottom flask  
                // declares: Total_Height_of_Flask
                Neck_Fillet_R, // > 0 // neck base fillet // Hohlkehle 
                Bowl_Radius, // base bowl radius
                Neck_Radius, // neck radius
                Neck_Length, // 0=non; neck linear length 
                1, //   1 for transparent materials, else: 0 
              ) //------------------------------------------------------------------  
        hollow
      } 
object{ Round_Bottom_Mace_1 (     //  A round-bottom flask  
                // declares: Total_Height_of_Flask
                Neck_Fillet_R+Glass_D, // > 0 // neck base fillet // Hohlkehle 
                Bowl_Radius-Glass_D, // base bowl radius
                Neck_Radius-Glass_D, // neck radius
                Neck_Length+0.001, // 0=non; neck linear length 
                0, //   1 for transparent materials, else: 0 
              ) //------------------------------------------------------------------  
        hollow
      }
 
}// end difference
 // neck brace 
 torus{Neck_Radius+Glass_D,Glass_D translate<0,Total_Height_of_Mace,0> } 

} // end of object ---------------------------------------------------------------------- 
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------material / texture
#declare Glass_Material = 
material{ //---------------------------------------------------------------------  
          texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.95> }
                   finish { diffuse 0.1 reflection 0.1  
                            specular 0.8 roughness 0.0003 phong 1 phong_size 400}
                 } // end of texture -------------------------------------------- 
         interior{ ior 1.45   caustics 0.85
                 } // end of interior ------------------------------------------- 
      } // end of material ------------------------------------------------------ 
//-------------------------------------------------------------------------------------//
#include "Round_Bottom_Flask_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Round_Bottom_Flask_1 (     //  A round-bottom flask  
                // declares: Total_Height_of_Flask
                0.004, // Glass_D, //
                0.050, // Neck_Fillet, // > 0 //radius neck base fillet // Hohlkehle 
                0.100, // Bowl_Radius, // base bowl radius
                0.030, // Neck_Radius, // neck radius
                0.100, // Neck_Length, //  0=non; neck linear length 
                1, // Merge_On, //  1 for transparent materials, else: 0 
              ) //---------------------------------------------------------------------//
        material{ Glass_Material }
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Round_Bottom_Flask_1_Inc_Temp;
#end
//------------------------------------- end of include file

