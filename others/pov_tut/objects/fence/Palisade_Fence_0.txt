// POV-Ray 3.6/3.7 include file "Palisade_Fence_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Palisade_Fence_0_Inc_Temp)
#declare Palisade_Fence_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
#ifndef(  Palisade_Pile_0_Inc_Temp)
#include "Palisade_Pile_0.inc"
#end

//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
#macro Palisade_Fence_0(  Fence___Length_                             // Palisade_Fence_0
                          Pile___Height_,
                          Pile___Tip_Height_,   
                          Pile___Radius_,  
                          Pile_relative___Distance, // in percent of radius
                          Pile_Body___Texture_, 
                          Pile_Tip___Texture_
                        ) //-------------------------
//----------------------------------------------------------------------
#local Number_of_Piles = int (Fence___Length_/(2*Pile___Radius_*Pile_relative___Distance)); 
#local Pile___Distance = Fence___Length_/(Number_of_Piles+1); 

#local Randy = seed(12765); 
//----------------------------------------------------------------------

union{ 

 #local Nr = 0;     // start
 #local EndNr = Number_of_Piles; // end
 #while (Nr< EndNr+1) 
 object{ Palisade_Pile_0( Pile___Height_,
                          Pile___Tip_Height_,   
                          Pile___Radius_,  
                          Pile_Body___Texture_, 
                          Pile_Tip___Texture_
                        ) //-------------------- 
        rotate<0,360*rand(Randy),0>
        translate<Nr*Pile___Distance+Pile___Radius_*Pile_relative___Distance,0,0>} 

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 

} // end of union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
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
//---------------------------------------------------------------------------------------
*/


#version Palisade_Fence_0_Inc_Temp;
#end
//------------------------------------- end of include file

