// POV-Ray 3.6/3.7 include file "Zebra_Stripes_000.inc"
// author: Friedrich A, Lohmueller, Jan-2005
// update July-2013  
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Zebra_Stripes_000_Inc_Temp)
#declare Zebra_Stripes_000_Inc_Temp = version;
#version 3.6;

//--------------------------------------------------//////////////
//--------------------------------------------------------------//
#macro Zebra_Stripes_000 ( Zebra_Stipe___Width, 
                           Zebra_Stipe___Length, 
                           Numbers_of___Stripes,
                           Symmetric___On
                         ) //-----------------------------------//
//--------------------------------------------------------------//
#local D = 0.0015; // higher than "normal" lines
//--------------------------------------------------------------//
union{
 #declare Nr = 0;   // start
 #declare EndNr = Numbers_of___Stripes; // end
 #while (Nr< EndNr) 

   box{ <0,0,0>,<Zebra_Stipe___Width, D, Zebra_Stipe___Length>   
        translate<Nr*2*Zebra_Stipe___Width,0,0>
      } 

 #declare Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 
#if (Symmetric___On = 1)   
 translate<-(Numbers_of___Stripes-0.5 )*Zebra_Stipe___Width,0,0>
#end 
} // end of union
//--------------------------------------------------//////////////
#end // -------------------------------------------  end of macro 
//--------------------------------------------------//////////////




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------//
#declare Zebra_Texture = 
         texture { pigment{ color rgb< 1, 1, 1>*1.1 } 
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1 reflection 0.00}
                 } // end of texture 
//---------------------------------------------------------------//
#include "Zebra_Stripes_000.inc"
//---------------------------------------------------------------//
object{ Zebra_Stripes_000( 0.40, // Zebra_Stipe___Width, 
                           2.00, // Zebra_Stipe___Length, 
                           6, // Numbers_of___Stripes,
                           1  // Symmetric___On
                         ) //-----------------------------------//
         texture { Zebra_Texture }  
         rotate<0,0,0> 
         scale <1,1,1>
         translate<0,0,0> 
      } //------------------
//---------------------------------------------------------------//

*/


#version Zebra_Stripes_000_Inc_Temp;
#end
//------------------------------------- end of include file

