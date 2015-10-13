// POV-Ray 3.6 include file "RW_Wheel_10.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller, March-2011
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RW_Wheel_10_Inc_Temp)
#declare RW_Wheel_10_Inc_Temp = version;
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
//------------------------------------------------------------------- RW_Wheel_10 macro
#macro RW_Wheel_10 ( Wheel_Diameter__, // in meter
                     Number_Of_Spokes__, // 
                     Add_Connector_And_Counterweight__   // Connector with 1 at x+ with 0.5*wheel radius ; without 0 or else
                   ) //---------------------------------------------------
//------------------------------------------------------------------------
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
#local Wheel_HalfWidth = 0.050; // half Wheel_width - lbe Radbreite 
#local Flange_Overhang = 0.045; // flange overhang  - Spurkanz Ueberhang
#local Flange_Width    = 0.020; // flange width     - Spuharkanz Weite

#local Wheel_Ring   = Wheel_Radius*0.15;
#local Hub_Radius   = 0.120; // Hub          - Radnabe
#local Spoke_Radius = 0.035; // Spoke radius - Speichenradius
//------------------------------------------------------------------------
#local Connecting_Radius = 0.50*Wheel_Radius; //Connecting_radius-  Pleuelansatzradius = Radius, an dem die Connecting_Rod ansetzt
//------------------------------------------------------------------------
//------------------------------------------------------------------------
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

 cylinder{ <0,0,-Wheel_Radius-D>,<0,0,Wheel_Radius+Flange_Width+D>,  Wheel_Radius-Wheel_Ring
           texture{ Wheel_Texture_1 } }
 } // end of difference
 
 cylinder{ <0,0,-Wheel_HalfWidth>,<0,0,Wheel_HalfWidth>,Hub_Radius   // kernel
          texture{ Wheel_Texture_1} }

 cylinder{ <0,0,-Wheel_HalfWidth-0.01>,<0,0,Wheel_HalfWidth+0.01>,Hub_Radius*0.75  // kernel
          texture{ Wheel_Metal_1 } }
 
 cylinder{ <0,0,-Wheel_HalfWidth-0.02>,<0,0,Wheel_HalfWidth+0.02>,Hub_Radius*0.5   // kernel
          texture{ Wheel_Metal_1 } }
 
 torus{ Wheel_Radius-Wheel_Ring, (Wheel_HalfWidth-0.01)/3 rotate<90,0,0> scale<1,1,3> 
          texture{ Wheel_Texture_2 } }

#if (Add_Connector_And_Counterweight__ = 1)  

        cylinder{ <0,0,-Wheel_HalfWidth+D>,<0,0,Wheel_HalfWidth-D>,Hub_Radius*0.66
                  translate<Connecting_Radius,0,0> texture{Wheel_Texture_1}}  
        cylinder{ <0,0,-Wheel_HalfWidth>,<0,0,Wheel_HalfWidth >,Hub_Radius*0.500
                  translate<Connecting_Radius,0,0> texture{Wheel_Metal_1}}  
 
        difference{ cylinder{ <0,0,-Spoke_Radius>,<0,0,Spoke_Radius>,Wheel_Radius-Wheel_Ring texture{Wheel_Texture_1}} 
                    cylinder{ <0,0,-Spoke_Radius-D>,<0,0,Spoke_Radius+D >,Wheel_Radius*1.35
                              translate<Wheel_Radius*2/3,0,0> texture{Wheel_Texture_2}}
                   }// end of difference 
 
#end // 
 #local Nr = 0; // start loop      
 #local EndNr = Number_Of_Spokes__; // end number
 #while (Nr< EndNr) 
   cylinder {<-0.01,0,0>,<Wheel_Radius-0.01,0,0>,Spoke_Radius scale<1,0.67,1> 
             texture{ Wheel_Texture_2 } 
             rotate<0,0,Nr * 360/EndNr>} 
 #declare Nr = Nr + 1;    // next Nr
 #end // ---------------  end of loop 
 
translate<0,0,-Wheel_HalfWidth>
} // end of union ------------------
#end //------------------------------------------------------------------------ end of macro
//------------------------------------------------------------------------------------//////




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
#include "RW_Wheel_10.inc" 
//-------------------------------------------------------------------------------------// 
object{ RW_Wheel_10( 1.00, //  Wheel_Diameter__, // in meter
                      16, // Number_Of_Spokes__, // 
                      1  // Add_Connector_And_Counterweight__   // Connector with "1" at x+ with 0.5*wheel radius ; without 0 or else

                    ) //---------------------------------------------------     
        rotate<0,0,0.00>
        scale<1,1,1> 
        translate< 0.00,0.5,0>
      } // end
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RW_Wheel_10_Inc_Temp;
#end
//------------------------------------- end of include file

