// POV-Ray 3.6/3.7 include file "Column_Kernel_01.inc" 
// author: Friedrich A, Lohmueller, Dec-2006 / May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Column_Kernel_01_Inc_Temp)
#declare Column_Kernel_01_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

//------------------------------------------------------------------------------ /////////  
//---------------------------------------------------- "Column_01(...)" marcro 
#macro Column_Kernel_01 (  Column_Kernel_Height___, // 
                           Column_Subdivision___,  //  
                           C_Base_Radius___, 
                           C_Top_Radius___ 
                        ) //---------------------------------
//----------------------------------------------------
#local Rip_Top_R___  = 2*pi*C_Top_Radius___ /Column_Subdivision___*1/sqrt(2); 
#local Rip_Base_R___ = 2*pi*C_Base_Radius___/Column_Subdivision___*1/sqrt(2);
#local Rip_Top_Distance___ = C_Top_Radius___ +Rip_Top_R___ *1/sqrt(2);
#local Rip_Base_Distance___= C_Base_Radius___ +Rip_Base_R___*1/sqrt(2);
#local R_over = +Rip_Base_R___*0.1; 

//------------------------------------------------------------------------------------- 
difference{ // column kernel
cone { <0,0,0>,C_Base_Radius___,<0,Column_Kernel_Height___,0>,C_Top_Radius___ 
     } // end of cone -----------------------------------
 
 #local Nr = 0;     // start
 #local EndNr = Column_Subdivision___; // end
 #while (Nr< EndNr) 
cone { <Rip_Base_Distance___,-R_over,                          0>, Rip_Base_R___,
       <Rip_Top_Distance___ , Column_Kernel_Height___ + R_over,0>, Rip_Top_R___
       rotate<0,Nr * 360/EndNr,0>      
     } // end of cone -----------------------------------
 #local Nr = Nr + 1;    // next Nr
 #end // ---------------  end of loop 
 

} // end of difference 
// ------------------------------------------------------------------------------------ 
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-------------------------------------------------------------------------------------- 
//-------------------------------------------------------------------------------------- 
#declare Stone_Texture = // Column kernel stone texture
         texture { T_Grnt16
                   normal { agate 0.35 scale 0.05}
                   finish { phong 0.2 } 
                   scale 1 
                 } // end of texture 

#declare Column_Kernel_Texture = // with vertical subdivisions 
        texture { gradient<0,1,0> scale <1,0.67,1> turbulence 0.01 //------------------- 
                   texture_map{ [0.00 Stone_Texture ]
                                [0.001 pigment{ color rgb <1,1,1>*0.1} ]
                                [0.005 pigment{ color rgb <1,1,1>*0.1} ]
                                [0.006 Stone_Texture ]
                                [1.00 Stone_Texture ]
                              } // end of texture_map      
                 } // end of texture --------------------------------------------------- 
//-------------------------------------------------------------------------------------- 
#include "Column_Kernel_01.inc" 
//-------------------------------------------------------------------------------------// 
object{ Column_Kernel_01 ( 2.00, // Column_Total_Height,  // 
                           16,   // Column_Subdivision, // integer ~ 16
                           0.30, // Column_Base_Radius, 
                           0.20  // Column_Top_Radius,  
                  ) //---------------------------------

        texture { Column_Kernel_Texture}  
        scale<1,1,1>  rotate< 0,0,0>  translate<0,0,0>  
      } // end of "Column_01(...) --------------------------------------- 
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Column_Kernel_01_Inc_Temp;
#end
//------------------------------------- end of include file

