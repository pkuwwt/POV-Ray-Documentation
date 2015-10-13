// POV-Ray 3.6/3.7 include file "Pool_Ladder_0.inc" 
// author: Friedrich A, Lohmueller, Nov-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Pool_Ladder_0_Inc_Temp)
#declare Pool_Ladder_0_Inc_Temp = version;
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
//---------------------------------------------------------
//---------------------------------------------------------//
#macro Pool_Ladder_0 (  // pool ladder looking in x+ to pool
                        PL_Rmin, // ~ 0.02   
                        PL_Rmaj, // ~ 0.20
                        PL_Width, //
                        PL_Length 
                     ) 
//---------------------------------------------------------//
#local D = 0.0001; 
#local PL_Bow =  
intersection{ 
  torus{ PL_Rmaj, PL_Rmin rotate<90,0,0>}
  box{ <-PL_Rmaj-PL_Rmin-D,                0,-PL_Rmin-D>, 
       < PL_Rmaj+PL_Rmin+D,PL_Rmaj+PL_Rmin+D, PL_Rmin+D> } 
  } // end of intersection --------------------------------
//---------------------------------------------------------

//---------------------------------------------------------
union{ 

 union{ 
  object{PL_Bow } 
  cylinder{ <0,-PL_Length-2*PL_Rmaj,0><0,0,0>,PL_Rmin translate< PL_Rmaj,0,0>} 
  cylinder{ <0,-PL_Length-2*PL_Rmaj,0><0,0,0>,PL_Rmin translate<-PL_Rmaj,0,0>} 
  translate<0,2*PL_Rmaj,PL_Width/2>
  } // end of sub union
 union{ 
  object{PL_Bow } 
  cylinder{ <0,-PL_Length-2*PL_Rmaj,0><0,0,0>,PL_Rmin translate< PL_Rmaj,0,0>} 
  cylinder{ <0,-PL_Length-2*PL_Rmaj,0><0,0,0>,PL_Rmin translate<-PL_Rmaj,0,0>} 
  translate<0,2*PL_Rmaj,-PL_Width/2>
  } // end of sub union
 
 union{
  #local Nr = 0;     // start
  #local EndNr = int(PL_Length/0.20); // end
 #while (Nr< EndNr) 

  cylinder{<0,0,-PL_Width/2>,<0,0,PL_Width/2>,PL_Rmin*0.75 translate<PL_Rmaj,-Nr*0.20,0>} 

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 

 rotate<0,0,0> 
 translate<0,0,0>} // end of union

} // end of union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*


//---------------------------------------------------------//
//---------------------------------------------------------//
#declare Pool_Ladder_Texture =
         texture { Polished_Chrome
                   // pigment{ color rgb<1,0,0>} 
                   finish { diffuse 0.85  phong 1}
                 } // end of texture 
//---------------------------------------------------------//
#include "Pool_Ladder_0.inc"
//---------------------------------------------------------//
object{ Pool_Ladder_0 (  // pool ladder looking in x+ to pool
                        0.02, // R minor, // ~ 0.02   
                        0.20, // R major, // ~ 0.20
                        0.50, // ladder width // 
                        1.00  // ladder length 
                      ) 
        texture {Pool_Ladder_Texture} 
        scale<1,1,1>
        rotate<0,0,0> 
        translate<0,1.0,0>
      } // end of object "Pool_Ladder_0"
//---------------------------------------------------------//
//---------------------------------------------------------//

//---------------------------------------------------------------------------------------
*/


#version Pool_Ladder_0_Inc_Temp;
#end
//------------------------------------- end of include file

