// POV-Ray 3.6 / 3.7 include file "Track_Chain_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006 / May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Track_Chain_0_Inc_Temp)
#declare Track_Chain_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"                                             
#end

//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
#macro Track_Chain_0 ( Chain_Length__,  // total legth in x
                       Chain_Radius__,  // half total height in y 
                       Chain_Depth__,   // depth in z 
                       
                       Chain_Color__,    //  base color of the chains  
                       Wheel_Texture__   //  texture of the wheels  
                     ) //--------------------------------------------

// -------------------
#local D = 0.0001; 
// -------------------
//-------------------------------------------  
#local Chain_R =  Chain_Radius__; 
#local Chain_L = (Chain_Length__-Chain_R)/2;
#local Chain_Z =  Chain_Depth__/2;
#local Chain_D =  0.03; 

//------------------------------------------- 
#local CWheel_R = Chain_R-Chain_D; 
#local CWheel_Z = Chain_Z*0.7; 
//------------------------------------------- 
#local Number_of_Wheels = int( Chain_Length__/(2*Chain_Radius__)); 
#local Wheel_Distance = 2*Chain_L/Number_of_Wheels;
//------------------------------------------- 
//------------------------------------------- 
#local Chain_Frequency_R = 80*Chain_R;
#local Chain_Frequency_X = 1/(10); 
//------------------------------------------------------------------------
#local Chain_Texture_Radial = 
       texture { pigment{ color Chain_Color__ } 
                 normal { pigment_pattern{ radial 
                                           frequency Chain_Frequency_R 
                                           sine_wave
                                         color_map {[0.0, rgb 0]
                                                    [0.1, rgb 1]
                                                    [0.9, rgb 1]
                                                    [1.0, rgb 0]}
                                         rotate<90,0,0> } 0.5}
                 finish { phong 1}
               } // end of texture --------------------------------------- 

#local Chain_Texture_Linear = 
       texture { pigment{ color Chain_Color__ } 
                 normal { pigment_pattern{ gradient x 
                                           scale<Chain_Frequency_X ,1,1> 
                                           sine_wave
                                         color_map {[0.0, rgb 0]
                                                    [0.1, rgb 1]
                                                    [0.9, rgb 1]
                                                    [1.0, rgb 0]}
                                         rotate<0,0,0>} 0.5}
                 finish { phong 1}
               } // end of texture --------------------------------------- 
//------------------------------------------------------------------------
//------------------------------------------------------------------------
#local CWheel_Half = 
difference{ 
  union{ 
   cylinder{ <0,0,-CWheel_Z>,<0,0,-CWheel_Z/2>, CWheel_R }
          //   scale <1,1,1> rotate<0,0,0> translate<0,0,0>
   cone{ <0,0,-CWheel_Z/2>,CWheel_R ,<0,0,0>, CWheel_R/4 }
 }
 cylinder { <0,0,-CWheel_Z-D>,<0,0,-CWheel_Z/2>, CWheel_R-1.5*Chain_D   
         } // end of cylinder  ------------------------------------
} // end diff

#local CWheel = 
union{ 
 object{ CWheel_Half}
 object{ CWheel_Half  scale <1,1,-1> }
// axis 
 cylinder { <0,0,-CWheel_Z+0.01>,<0,0,CWheel_Z-0.01>, CWheel_R/4 
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         } // end of cylinder  ------------------------------------
texture {Wheel_Texture__  } 
translate<0,0,0>
} // end union

//------------------------------------------------------------------------
union{ //#macro Segment_of_CylinderRing ( R_out, R_in, Height, Segment_Angle)

 object{ Segment_of_CylinderRing ( Chain_R, Chain_R-Chain_D ,2*Chain_Z, 180)   
         scale <1,1,1> rotate<0,-90,0> rotate<-90,0,0> 
         texture { Chain_Texture_Radial }
         translate<Chain_L,0, Chain_Z>
      }//----------------------------------------------------------
 object{ Segment_of_CylinderRing ( Chain_R, Chain_R-Chain_D ,2*Chain_Z, 180)   
         scale <1,1,1> rotate<0,-90,0> rotate<-90,0,0> 
         texture { Chain_Texture_Radial }
         translate<Chain_L,0, Chain_Z> scale<-1,1,1>
      }//----------------------------------------------------------
 box { <-Chain_L,-Chain_D,-Chain_Z>,<Chain_L,0,Chain_Z>
         texture { Chain_Texture_Linear }
         translate<0,Chain_R,0>
      }//----------------------------------------------------------
 box { <-Chain_L,-Chain_D,-Chain_Z>,<Chain_L,0,Chain_Z>
         texture { Chain_Texture_Linear }
         translate<0,Chain_R,0> scale<1,-1,1>
      }//----------------------------------------------------------
 // the wheels: 
 #local Nr = 0;     
 #while (Nr< Number_of_Wheels+1) 
 object{ CWheel translate<-Chain_L+Nr*Wheel_Distance,0,0>} 
 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 


//--------------------
translate<0,Chain_R,0>
} // end of union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-----------------------------------------------------------------------------
#local Chain_Color =  color rgb< 1, 1, 1>*0.65;     // base color of the chains
#local Wheel_Texture =  texture { pigment{ color rgb< 1, 0.80, 0.55>*0.5 } 
                                  normal { bumps 0.5 scale 0.01 }
                                  finish { phong 1 reflection 0.00}
                                } // end of texture 
//-----------------------------------------------------------------------------
#include "Track_Chain_0.inc"
//-----------------------------------------------------------------------------
object{ Track_Chain_0( 2.20, // Chain_Length > 4*Chain_Radius; total legth in x
                       0.30, // Chain_Radius,  // half total height in y 
                       0.45, // Chain_Depth__,   // depth in z 
                       Chain_Color,   // base color of the chains  
                       Wheel_Texture   //  texture of the wheels  
                     ) //----------------------------------------- 
        scale <1,1,1> 
        rotate<0,0,0> 
        translate<0,0,0> }//---------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
*/


#version Track_Chain_0_Inc_Temp;
#end
//------------------------------------- end of include file

