// POV-Ray 3.6/3.7 include file "Palisade_Pile_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Palisade_Pile_0_Inc_Temp)
#declare Palisade_Pile_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
#macro Palisade_Pile_0 (  Pile___Height,
                          Pile___Tip_Height,   
                          Pile___Radius,  
                          Pile_Body___Texture, 
                          Pile_Tip___Texture
                        ) //--------------------------------------------
//---------------------------------------------------------------------- Palisade_Pile_0
#local D = 0.00001; 
//----------------------------------------------
#if ( Pile___Height < Pile___Tip_Height )
    #local Pile___Height =  Pile___Tip_Height+D;  
    #end 
//----------------------------------------------
 
union{
cylinder{ <0,0,0>,<0,Pile___Height - Pile___Tip_Height,0>, Pile___Radius 
          texture{ Pile_Body___Texture } }
cone{     <0,-Pile___Tip_Height,0>,Pile___Radius, <0,0,0>,0 
          translate<0,Pile___Height,0>    
          texture{ Pile_Tip___Texture } }   
} // end of union 
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------
//------------------------------------------------------------- textures
#declare Pile_Body_Texture = 
         texture { pigment { color rgb<0.40,0.25,0.15>*1.2 }
                   normal  { bumps 0.5 scale <0.005,0.25,0.005>}
                   finish  { diffuse 0.9 phong 0.5 reflection 0.00 }
                 } // end of texture

#declare Pile_Tip_Texture = 
         texture { pigment { color rgb< 0.75, 0.5, 0.30> }
                   normal  { bumps 0.15 scale <0.005,0.25,0.005>}
                   finish  { diffuse 0.9 phong 0.5 reflection 0.00 }
                 } // end of texture
//----------------------------------------------------------------------
#include "Palisade_Pile_0.inc"
//----------------------------------------------------------------------
object{ Palisade_Pile_0(  2.50, // Pile___Height,
                          0.40, // Pile___Tip_Height,   
                          0.15, // Pile___Radius,  
                          Pile_Body_Texture, 
                          Pile_Tip_Texture
                        ) //-------------------------
          scale<1,1,1>  rotate<0,0,0>  translate<0.00,0,0.00>  
      }  // end of object ---------------------------------------------- 
//----------------------------------------------------------------------
//----------------------------------------------------------------------
*/


#version Palisade_Pile_0_Inc_Temp;
#end
//------------------------------------- end of include file

