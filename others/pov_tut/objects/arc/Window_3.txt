// POV-Ray 3.6/3.7 include file "Window_3.inc" 
// author: Friedrich A, Lohmueller, Feb-2007, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//---------------------------------------------------------------------------------------------------
#ifndef( Window_3_Inc_Temp)
#declare Window_3_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------
#macro Window_3 (Window_Open___Right, Window_Open___Left)// 0= closed; 1 = opened   
//------------------------------------------------------------------------------ /////////  
#local Windows___Glass =  //--------------------------------------------- no IOR window glass texture
      texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                finish { diffuse 0.1 reflection 0.2  
                         specular 0.8 roughness 0.0003 phong 1 phong_size 400}
               } // end of texture ------------------------------------------------------------------
//---------------------------------------------------------------------------------------------------
#if (Window_Open___Right >1) #local Window_Open___Right= 1; #end
#if (Window_Open___Right <0) #local Window_Open___Right= 0; #end
#if (Window_Open___Left  >1) #local Window_Open___Left = 1; #end
#if (Window_Open___Left  <0) #local Window_Open___Left = 0; #end

#local Windows___Glass =  //--------------------------------------------- no IOR window glass texture
      texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.9> }
                finish { diffuse 0.1 reflection 0.2  
                         specular 0.8 roughness 0.0003 phong 1 phong_size 400}
               } // end of texture ------------------------------------------------------------------

//-------------------------------------------------------------
#local WW = 0.48;
#local Window_3___Outer_Frame =
 difference{
  box{<-0.50,0.80,-0.041>,< 0.50,1.80,0.041>}
  box{<-0.48,0.82,-0.05 >,< 0.48,1.78,0.05 >}
  } // ---end of difference 

#local Window_3___Left_Frame =
union{
 difference{
  box{<  -WW,0.82,-0.015>,< 0.00,1.78,0.015>}
  box{<-0.45,1.315,-0.03>,<-0.03,1.75,0.03>}
  box{<-0.45,0.85, -0.03>,<-0.03,1.285,0.03>}
  } // ---end of difference 
  box{< -0.015,0.82,-0.025>,< 0.015,1.78,-0.015>}

 box{<-0.47,0.83,0.0>,<-0.01,1.77,0.001>
 texture{Windows___Glass}}
 } // --- end of union -------------------

#local Window_3___Right_Frame =
union{
 difference{
  box{< 0.00,0.82,-0.015>,<   WW,1.78,0.015>}
  box{< 0.03,1.315,-0.03>,< 0.45,1.75,0.03>}
  box{< 0.03,0.85,-0.03>,< 0.45,1.275,0.03>}
  } // ---end of difference 
 box{< 0.01,0.83,0.0>,< 0.47,1.77,0.001>
 texture{Windows___Glass}}
 } // --- end of union -------------------
//-------------------------------------------------------------
union{
object{ Window_3___Outer_Frame } 
object{ Window_3___Right_Frame translate<-WW,0,-0.015> rotate<0, Window_Open___Right*90,0> translate< WW,0,0.015>}
object{ Window_3___Left_Frame  translate< WW,0,-0.015> rotate<0,-Window_Open___Left *90,0> translate<-WW,0,0.015>}
} // --- end of union -------------------
#end // end of macro
// --------------------------------------------------------------------------------------
// ------------------------------------------------------// end of window definition
// --------------------------------------------------------------------------------------


// --------------------------------------------------------------------------------------
#declare Window_3_Hole =   //symmetric!!! no texture
  box{<-0.50,0.80,-0.50>,< 0.50,1.80,0.50>
    } // end of box -----------------------
// --------------------------------------------------------------------------------------
// ------------------------------------------------------// end of window hole definition 




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Window_3_Texture = 
   texture { // pigment{ color rgb< 0.75, 0.5, 0.30>*0.5 } // brown  
             pigment{ color rgb<1,1,1> } 
             finish { phong 0.1} 
           } // end of texture
//---------------------------------------------------------------------------------------
#include "Window_3.inc" 
//-------------------------------------------------------------------------------------// 
object{ Window_3 ( 0.3, 0 ) // Window_Open_Right, Window_Open_Left,: 0= down closed; 1 = up opened  
        texture { Window_3_Texture } 
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}

// #declare Window_Hole = object { Window_3_Hole }
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Window_3_Inc_Temp;
#end
//------------------------------------- end of include file

