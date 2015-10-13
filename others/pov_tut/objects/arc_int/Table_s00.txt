// PoVRay 3.6/3.7 Include File "Table_s00.inc"
// author: Friedrich A. Lohmueller, Dec-2005, May-2014
// homepage: http://www.f-lohmueller.de  
// email: Friedrich.Lohmueller_AT_t-online.de

#ifndef( Table_s00_Inc_Temp)
#declare Table_s00_Inc_Temp = version;
#version 3.6;

#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end

//--------------------------------------------------------------------
#macro Table_s00 ( Table__Height, 
                   Table__Half_Width_X, 
                   Table__Half_Width_Z, 
                   Table__Feet_Radius, 
                 ) //-------------------------------------------------

#local CR = Table__Feet_Radius; 
#local CX = Table__Half_Width_X - CR; 
#local CZ = Table__Half_Width_Z - CR; 
#local SH = Table__Height - CR; 

#local SX = Table__Half_Width_X ; 
#local SZ = Table__Half_Width_Z ; 
#local ST = 2*CR ; 

union{ // total union
union{
// seat
box { <-CX, 0.00, -CZ>,< CX, 0, CZ>  translate<0,SH,0> }  
// feet
cylinder { <0,0,0>,<0,SH,0>, CR translate< CX,0,-CZ> } 
cylinder { <0,0,0>,<0,SH,0>, CR translate<-CX,0,-CZ> }
cylinder { <0,0,0>,<0,SH,0>, CR translate< CX,0, CZ> }
cylinder { <0,0,0>,<0,SH,0>, CR translate<-CX,0, CZ> }
// frontside horizontal seat level
cylinder { <-CX,0,  0>,< CX,0, 0>, CR  translate<0,SH, CZ> }
cylinder { <-CX,0,  0>,< CX,0, 0>, CR  translate<0,SH,-CZ> }
cylinder { <  0,0,-CZ>,<  0,0,CZ>, CR  translate< CX,SH,0> }
cylinder { <  0,0,-CZ>,<  0,0,CZ>, CR  translate<-CX,SH,0> }
// frontside horizontal seat level
sphere{ < CX,SH,-CZ>, CR  } 
sphere{ <-CX,SH,-CZ>, CR  } 
// backside horizontal seat level
sphere{ < CX,SH, CZ>, CR } 
sphere{ <-CX,SH, CZ>, CR } 

}// end of union

// seat
object { // Round_Box(A, B, WireRadius, UseMerge)
         Round_Box(<-SX,0,-SZ>,<SX,2*CR,CZ>, CR , 0)  
         scale<1,1,1>  rotate<0, 0,0> translate<0,SH,0>
       } // ---------------------------------------------------------




}// end of total union
#end  
//------------------------------------- end of #macro Chair_s10 (...) 
// sample: 
/*
//----------------------------------------------------------------------------
//----------------------------------------------------------------- textures
#declare Table_Texture = 
       texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.5 }  
                finish { ambient 0.1 diffuse 0.9 phong 1 } 
              } // end of texture  

//----------------------------------------------------------------------------
#include "Table_s00.inc"
object{ Table_s00 ( 0.60, // Table__Height, 
                    0.40, // Table__Half_Width_X, 
                    0.60, // Table__Half_Width_Z, 
                    0.02  // Table__Feet_Radius, 
                  ) //------------------------------------------
        texture {Table_Texture}
        scale <1,1,1> rotate<0,0,0> translate< 0.00,0.00,0.00>}
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------


*/ 

#version Table_s00_Inc_Temp;
#end
//------------------------------------- end of include file
