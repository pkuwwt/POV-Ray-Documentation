// POV-Ray 3.6/3.7 include file "Rocket_1.inc" 
// author: Friedrich A, Lohmueller, Dec-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Rocket_1_Inc_Temp)
#declare Rocket_1_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
//--------------------------------------------------------------------------------------- 
#macro Rocket_1 ( Rocket_Texture, 
                  Rocket_Metal
                ) // --------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------- building the enging --------------// 
#local Rocket_1_Engine =
union{
 cone{<0,0,0>,0.5,<0,1.5,0>,0.25
        scale<1,1,0.7> translate<0,0.5,0>
        texture{ Rocket_Metal }
       }
 prism{ -0.01 ,0.01 , 4
        <0.0, 0.0>,<0.8, 0.0>,<0.0,1.5>,<0.0, 0.0>
        rotate<-90,0,0> translate<0,0.5,0>
        texture { Rocket_Texture } 
      }
 difference{
  cone{ <0, 0.10,0>,0.28,<0,0.50,0>,0.10}
  cone{ <0, 0.09,0>,0.17,<0,0.49,0>,0.09}
  translate<0.22,0,0> texture{ Rocket_Metal }}
// all together somewhat excentric!

translate<0.25,0,0>} 
// end of Engine

//--------------------------------------------------//
//------------ building the rocket -----------------// 
// #declare Rocket_1 =  

union{  //-- 4 engines ----------
object{ Rocket_1_Engine rotate<0,  0,0>}
object{ Rocket_1_Engine rotate<0, 90,0>}
object{ Rocket_1_Engine rotate<0,180,0>}
object{ Rocket_1_Engine rotate<0,270,0>}
//----- the body -----------------------------------
cylinder{<0,0,0>,<0,5,0>,0.5
         translate<0,0.5,0>
        }
// ----- with some details -------------------------
cylinder{ <0,0,0>,<0,0.1,0>,0.505 translate<0,2.0,0>
          texture{Rocket_Metal}
        }
cylinder{ <0,0,0>,<0,0.1,0>,0.505 translate<0,3.5,0>
          texture{Rocket_Metal}
        }
cylinder{ <0,0,0>,<0,0.1,0>,0.505 translate<0,5.25,0>
          texture{Rocket_Metal}
        }
//------- the top part -----------------------------
cone{ <0,0,0>,0.5,<0,1.5,0>,0.25 translate<0,5.50,0>
          texture{Rocket_Metal}
        }
//-------- the nose on top of the rocket -----------
sphere{ <0,0,0>,0.25 scale <1,1.5,1>
        translate<0,5.00+1.50+0.50,0>
        texture{Rocket_Metal}
       }


texture{Rocket_Texture}
} // --end of union --------------------------------// 
//------------------------------------------------------------------------------ /////////  
// --------------------------------------------------------------------------------------
#end // ------------------------------------------------------------------------ end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
#declare Rocket_Texture = 
   texture { //Chrome_Metal}  
             pigment{ color rgb<1,1,1>*1.1} 
             finish { phong 0.1} 
           } // end of texture
#declare Rocket_Metal = 
   texture { // Chrome_Metal  
             T_Chrome_1A
             // pigment{ color rgb<1,1,1>*1.1} 
             finish { phong 0.1 reflection 0.15} 
           } // end of texture
//---------------------------------------------------------------------------------------
#include "Rocket_1.inc" // height ~ 7.40 m
//-------------------------------------------------------------------------------------// 
object{ Rocket_1 (  Rocket_Texture, 
                    Rocket_Metal 
                 ) //-----------------   
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Rocket_1_Inc_Temp;
#end
//------------------------------------- end of include file

