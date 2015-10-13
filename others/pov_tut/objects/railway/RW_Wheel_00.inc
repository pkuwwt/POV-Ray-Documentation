// POV-Ray 3.6 / 3.7 include file "RW_Wheel_00.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller, March-2011
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RW_Wheel_00_Inc_Temp)
#declare RW_Wheel_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end
//-------------------------------------------------------------------///////////////////  
//------------------------------------------------------------------- RW_Wheel_00 macro
#macro RW_Wheel_00 (  Wheel_Diameter__  // in meter 
                   ) //---------------------------------------------------
//------------------------------------------------------------------------
// declares default textures: 
#ifndef (Wheel_Metal_1)
#declare Wheel_Metal_1 =  texture{Polished_Chrome pigment{quick_color White} finish {phong 1}}
#end
#ifndef (Wheel_Metal_2)
#declare Wheel_Metal_2 =  texture{pigment{ rgb<1,1,1>*0.6 quick_color White} finish {phong 0.2 reflection{ 0.3 metallic}}} 
#end
#ifndef (Wheel_Texture_1)
#declare Wheel_Texture_1 = texture{ pigment{ color rgb<1,0.65,0.45>*0.40} normal{ bumps 0.125 scale 0.05} finish{ phong 0.2}}
#end
#ifndef (Wheel_Texture_2)
#declare Wheel_Texture_2 = texture{ pigment{ color rgb<0.9,0.57,0.50>*0.55} normal{ bumps 0.15 scale 0.0125} finish{ phong 0.1}} 
#end

//------------------------------------------------------------------------
#local D = 0.001;   // just a little bit
//------------------------------------------------------------------------
//------------------------------------------------------------- dimensions 
//------------------------------------------------------------------------

#local Wheel_Radius    = Wheel_Diameter__/2; // wheel radius   - Radradius
#local Wheel_HalfWidth = 0.050; // half Wheel_width - halbe Radbreite 
#local Flange_Overhang = 0.045; // flange overhang  - Spurkanz Ueberhang
#local Flange_Width    = 0.020; // flange width     - Spurkanz Weite

#local Wheel_Ring   = Wheel_Radius*0.15;
#local Hub_Radius   = Wheel_Radius*0.18; // Hub          - Radnabe
//----------------------------------------------------------------------- 
#local WD = 0.10;
#local WBorderD = 0.03; 
#local Axis_R = Wheel_Radius/10; 
#local WNeg_maj = Wheel_Radius-(Wheel_Radius - Axis_R)/2 ; 
#local WNeg_min =     (Wheel_Radius-2*WBorderD-Axis_R)/2 ; 
//------------------------------------------------------------------------
union{
 difference{ 
 union{
        cone{ <0,0,Wheel_HalfWidth>, Wheel_Radius,
              <0,0,Wheel_HalfWidth+ Flange_Width-D>, Wheel_Radius+Flange_Overhang texture{ Wheel_Metal_1 }}

        cone{ <0,0,Wheel_HalfWidth+0.01>, Wheel_Radius-D,
              <0,0,Wheel_HalfWidth+ Flange_Width  >, Wheel_Radius*0.98+Flange_Overhang texture{ Wheel_Texture_1  }}

        cylinder{ <0,0,-Wheel_HalfWidth+D>,<0,0,Wheel_HalfWidth-D>,Wheel_Radius  texture{ Wheel_Metal_2 }} 
         
        cylinder{ <0,0,-Wheel_HalfWidth>,<0,0,Wheel_HalfWidth>,Wheel_Radius-0.005 texture{ Wheel_Texture_1 } } 

      }// end of inner union

 torus{ WNeg_maj, WNeg_min rotate<90,0,0>
         scale<1,1,0.25> translate<0,0,-WD*0.780> 
         texture{ Wheel_Texture_2 }
      }
 torus{ WNeg_maj, WNeg_min rotate<90,0,0>
         scale<1,1,0.25> translate<0,0, WD*0.875> 
       // pigment{ Cyan} 
        texture{ Wheel_Texture_2 }
      }
 } // end of difference
 
 cylinder{ <0,0,-Wheel_HalfWidth>,<0,0,Wheel_HalfWidth+0.015>,Hub_Radius   // kernel
          texture{ Wheel_Texture_1} }

 cylinder{ <0,0,-Wheel_HalfWidth-0.01>,<0,0,Wheel_HalfWidth+0.025>,Hub_Radius*0.75  // kernel
          texture{ Wheel_Metal_1 } }
 
 cylinder{ <0,0,-Wheel_HalfWidth-0.02>,<0,0,Wheel_HalfWidth+0.04>,Hub_Radius*0.5   // kernel
          texture{ Wheel_Metal_1 } }
 
translate<0,0,-Wheel_HalfWidth>
} // end of union ------------------
#end //------------------------------------------------------------------------ end of macro
//------------------------------------------------------------------------------------//////




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//------------------------------------------------------------------------------------------
#include "RW_System/RW_Wheel_00.inc"
//------------------------------------------------------------------------------------------
object{ RW_Wheel_00(  1.00 )  //  wheel diameter__, // in meter
        rotate<0,0,0.00>
        scale<1,1, 1>
        translate< 0.00,0.5,0>}
//------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------
*/


#version RW_Wheel_00_Inc_Temp;
#end
//------------------------------------- end of include file

