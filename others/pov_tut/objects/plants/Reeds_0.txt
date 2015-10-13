// POV-Ray 3.6/3.7 include file "Reeds_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Reeds_0_Inc_Temp)
#declare Reeds_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
/*
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
#ifndef(  Shapes_Lo_Inc_Temp)
#include "shapes_lo.inc"                                             
#end
*/

//------------------------------------------------------------------------------ /////////  
#macro Reeds_0 ( Extension___X,
                 Extension___Z,
                 Average___Height,
                 Reeds___Radius, 

                 Reeds___Texture 
               ) //------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------


//-------------------------------------------------------------------
#local XLen = Extension___X;
#local ZLen = Extension___Z; 
#local AverageHeight = Average___Height;
#local Radius = Reeds___Radius; 
                 
#local Z0 = seed(1000);
#local Z1 = seed(1005);
#local Z2 = seed(1002);
#local Z3 = seed(1003);
#local Z4 = seed(1008);

#macro Reed( ZHeight, ZRotate, YRotate) //------------ 
 cone{ <0,-1,0>,Radius,<0,ZHeight,0>,Radius/4 
       rotate<0,0,ZRotate> rotate<0,YRotate,0> }
#end//------------- end of sub macro -----------------

union{
#local NrX = 0;     // start X
#local EndNrX = 10*XLen; // end   X
#while (NrX< EndNrX) 
 #local NrZ = 0;     // start Z
 #local EndNrZ = 10*ZLen; // end   Z
 #while (NrZ< EndNrZ) 

   object{ Reed( AverageHeight+rand(Z0)*0.5,rand(Z1)*10,rand(Z2)*250) 
           
           translate<NrX*0.07+rand(Z3)*0.1,0,NrZ*0.10+rand(Z4)*0.1> 
           
           texture{Reeds_Texture}       
         } 

 #local NrZ = NrZ + 1;  // next NrZ
 #end
 
#local NrX = NrX + 1;  // next NrX
#end // --------------- end of loop 

texture{Reeds___Texture}
}  // end of Reeds union 
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//--------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Reeds_Texture = 
	texture{pigment{
	        gradient x turbulence 0.1
	        color_map{ [ 0.00 color YellowGreen      ]
                           [ 0.50 color MediumSpringGreen] 
                           [ 1.00 color YellowGreen      ]}} 
                finish { phong 1} scale 0.1}
//---------------------------------------------------------------------------------------
#include "Reeds_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ Reeds_0( 2.50, // Extension___X,
                 0.75, // Extension___Z,
                 2.75, // Average___Height,
                 0.02, // Reeds___Radius, 
                 Reeds_Texture 
                ) //----------------------------------------------------------------//
        scale <1,0.75,0>*1
        rotate<0,0,0> 
        translate<0.5,0,0.75>}
//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------

cylinder {<0,0,0>,<0,0.01,0>,5 
          texture{Polished_Chrome 
                  normal { ripples 0.5 scale 0.035 turbulence 0.3 translate<3,3,0>}
                  finish { phong 1}}
          scale <1,1,0.5> rotate<0,0,0> translate<-1,0,-1>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

*/


#version Reeds_0_Inc_Temp;
#end
//------------------------------------- end of include file

