// POV-Ray 3.7 include file "Steel_Bridge_Framework_1.inc"
// author: Friedrich A, Lohmueller, Jan-2011
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Steel_Bridge_Framework_1_Inc_Temp)
#declare Steel_Bridge_Framework_1_Inc_Temp = version;
#version 3.6; // 3.7;
//----------------------------------------------------------------//////////
//----------------------------------------------------------------//////////
//----------------------------------------------------------------//////////
#macro Steel_Bridge_Framework_1( 
                        L_, // bridge length
                        H_, // bridge height
                        W_,  // bridge width
                        BD_,   // beam diameter
                        BR_, // beam border radius
                      )// ----------------------------------- 
// ----------------------------------------------------------
// ----------------------------------- default texture 
#ifndef( Steel_Bridge_Framework_1_Texture )
#declare Steel_Bridge_Framework_1_Texture =
         texture { pigment{ color rgb< 1, 1, 1>*0.5 }  
                   normal { bumps 0.25 scale 0.35 }
                   finish { phong 1 }
                 } // end of texture 
#end // -----------------------------------------------------
#local H = H_; // bridge height
#local W = W_;  // bridge width
#local BD= BD_;   // beam diameter
#local BR= BR_; // beam border radius
#local L = L_-BD; // bridge length
//-----------------------------------------------------------
// number of subdivisions: 
#local NSub = int(L/H); 
// equidistant distribution: 
#local SubDistance = L/NSub; 
// shearing factor:
#local S_Factor = 0.5*SubDistance/(H+2*BR); 
  
//-----------------------------------------------------------
#local Side_Beam =  
union{ 
 #local Nr = 0; // start counter at zero!
 #while (Nr < 2*NSub )
  object{ Round_Box(<-BD/2,0,-BD/2>,<BD/2,H+2*BR,BD/2>,BR,0)  
          texture{ Steel_Bridge_Framework_1_Texture }
          matrix< 1  , 0, 0, //  matrix-shear_y_to_x 
                S_Factor, 1, 0,
                  0  , 0, 1,
                  0  , 0, 0>
          #if( Nr/2 != int(Nr/2 )) // uneven numbers
            scale<-1,1,1>
            translate<SubDistance/2,0,0>
          #end 

          translate<Nr*SubDistance/2 + BD/2,-2*BR,0>
        } // -----------------------------------------
  
 #local Nr = Nr + 1 ;
 #end // end 

 // bottom strut
 object{ Round_Box(<0,-BD,-BD/2>,<L+BD,0,BD/2>, BR, 0)  
         texture{ Steel_Bridge_Framework_1_Texture }
         translate< 0, 0,0>
       } 
 // top strut
 object{ Round_Box(<SubDistance/2,-BD,-BD/2>,
                   <L-SubDistance/2+BD,0,BD/2>, BR, 0)  
         texture{ Steel_Bridge_Framework_1_Texture }
         translate<0,H,0>
       } 
} // end of union 
// --------------------------------------------------
// -------------------------------- final union:
##union{ 
 object{ Side_Beam translate<0,0,-W/2+BD/2> } 
 object{ Side_Beam translate<0,0,-W/2+BD/2> scale<1,1,-1> } 

  object{ Round_Box(<0,-BD/2,-BD/3>,<L+BD,0,BD/3>, BR, 0)  
          texture{ Steel_Bridge_Framework_1_Texture }
          translate< 0,0,-W/4+BD>
        } 
  object{ Round_Box(<0,-BD/2,-BD/3>,<L+BD,0,BD/3>, BR, 0)  
          texture{ Steel_Bridge_Framework_1_Texture }
          translate< 0,0, W/4-BD>
        } 
  union{ // sub union
   #local Nr = 0; // start counter at zero!
   #while (Nr <= NSub )

    // traversals
    object{ Round_Box(<-BD/2,-BD,-W/2>,<BD/2,0,W/2>, BR, 0)  
            texture{ Steel_Bridge_Framework_1_Texture }
            translate<Nr*SubDistance + BD/2,0,0>
          }
    //diagonals
    #if( Nr< NSub )
    object{ Round_Box(<-BD/4,-BD,-W/2+BD/2>,<BD/4,-BD/2,W/2-BD/2>, BR, 0)  
            texture{ Steel_Bridge_Framework_1_Texture }
          matrix< 1  , 0, 0, //  matrix-shear_y_to_x 
                  0, 1, 0,
              1*(SubDistance-BD)/(W-BD)  , 0, 1,
                  0  , 0, 0>
            #if( (Nr/2) = int(Nr/2) ) // even numbers
                 scale<1,1,-1>
            #end
            translate<(Nr+0.5)*SubDistance + BD/2,0,0>
          }
    #end // end diagonals
  
   #local Nr = Nr + 1 ;
   #end // end 
  } // end sub union

} // end final union
#end // --------------------------------------------- end of macro
//----------------------------------------------------------------//////////
//----------------------------------------------------------------//////////
//----------------------------------------------------------------//////////





//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//------------------------------------------------------------------------------------//
//------------------------------------------------------------------- optional texture 
/*
#declare Steel_Bridge_Framework_1_Texture =
         texture { pigment{ color rgb< 1, 1, 1>*0.5 }  
                   normal { bumps 0.25 scale 0.35 }
                   finish { phong 1 }
                 } // end of texture 
*/
//------------------------------------------------------------------------------------//
#include "Steel_Bridge_Framework_1.inc" 
//------------------------------------------------------------------------------------// 
object{ Steel_Bridge_Framework_1( 
                        10.00 , // bridge length
                         2.00 , // bridge height 
                         4.00 , // bridge width
                         0.30,  // beam diameter
                         0.03, // beam border radius
                       )// -------------------------- 

  rotate<0, 0,0> translate<0,0.00,0>
} // end of object 'Steel_Bridge_Framework_1' -----------------------------------------// 
//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------
*/


#version Steel_Bridge_Framework_1_Inc_Temp;
#end
//------------------------------------- end of include file

