// POV-Ray 3.6/3.7 include file "Cog_Wheel_In_1.inc"
// author: Friedrich A, Lohmueller, Feb-2010
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Cog_Wheel_In_1_Inc_Temp)
#declare Cog_Wheel_In_1_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

//------------------------------------------------------------------------------ /////////  
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#macro Cog_Wheel_In_1 (  // around the y axis, symmetric to xz plane
                         Cog_Number, 
                         Cog_Distance, 
                         Cog_Wheel_Y, 
                      ) 
//---------------------------------------------------------------------------------------
// -------------------------------------------------------- default textures 
#ifndef ( Golds_Inc_Temp )
#include "golds.inc"
#end 
//--------------------------------------------------------------------------
#ifndef( Gear_Texture_Blanc )
#declare Gear_Texture_Blanc = 
        texture { T_Gold_1A
                  finish { phong 1 reflection{ 0.40 metallic 0.5} }
                } // end of texture
#end 
#ifndef( Gear_Texture_Raw )
#declare Gear_Texture_Raw = 
        texture { T_Gold_1B
                  normal { bumps 0.25 scale 0.005} 
                  finish { phong 0.5 reflection{ 0.35 metallic 0.5} }
                } // end of texture
#end 
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
#local D = 0.0001;
#local Gear_Circumference = Cog_Distance*Cog_Number;
#local Cog_Wheel_Radius_  = Gear_Circumference/(2*pi); 
//------------------------------------------------------------------------- 
//-------------------------------------------------------------------------
#local Cogs_Subtract = 
intersection{ 
    cylinder{ <0,-Cog_Wheel_Y/2-2*D,0>,<0,Cog_Wheel_Y/2+2*D,0>,Cog_Distance/4
              scale<1.3,1,1>
              translate<Cog_Wheel_Radius_,0,0> 
              texture {  Gear_Texture_Blanc } 
            } // end of cylinder --------------------------------------
  
   cylinder { <0,-Cog_Wheel_Y/2-D,0>,<0,Cog_Wheel_Y/2+D,0>,Cog_Wheel_Radius_ + Cog_Distance/4*1.3*0.85 
              // pigment{Red} 
             texture {  Gear_Texture_Raw } 
            } // end of cylinder
} // end of intersection 
#local Cogs_Add = 
intersection{ 
    cylinder{ <0,-Cog_Wheel_Y/2-2*D,0>,<0,Cog_Wheel_Y/2+2*D,0>,Cog_Distance/4
              scale<1.3,1,1>
              translate<Cog_Wheel_Radius_,0,0> 
              texture {  Gear_Texture_Blanc } 
            } // end of cylinder --------------------------------------
    cylinder{ <0,-Cog_Wheel_Y/2,0>,<0,Cog_Wheel_Y/2,0>,Cog_Distance/4-D
              scale<1.3,1,1>
              translate<Cog_Wheel_Radius_,0,0> 
              texture {  Gear_Texture_Raw } 
            } // end of cylinder --------------------------------------
    cylinder{ <0,-Cog_Wheel_Y/2-D,0>,<0,Cog_Wheel_Y/2+D,0>,Cog_Wheel_Radius_ - Cog_Distance/4*1.3*0.90  inverse
               //pigment{Red} 
             texture {  Gear_Texture_Blanc } 
            } // end of cylinder
} // end of intersection 
//------------------------------------------------------------------------------------------- 
//------------------------------------------------------------------------------------------- 
union{
 // kernel of the gear minus notches
difference{
 cylinder{ <0,-Cog_Wheel_Y/2,0>,<0,Cog_Wheel_Y/2,0>,Cog_Wheel_Radius_ + Cog_Distance 
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
           texture {  Gear_Texture_Raw } 
         } // end of cylinder
 cylinder{ <0,-Cog_Wheel_Y/2-D,0>,<0,Cog_Wheel_Y+D,0>,Cog_Wheel_Radius_  
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
           texture {  Gear_Texture_Raw } 
         } // end of cylinder
 // abziehen
 #local Nr = 0;     // start
 #local EndNr = Cog_Number; // end
 #while (Nr< EndNr) 
      object{  Cogs_Subtract  
               rotate<0,(Nr+0.5) * 360/EndNr,0>  
            } // ------------------------------- 
 #local Nr = Nr + 1; // next Nr
 #end // end of loop 
 } // end of difference -----------------------------------------------
 //--------------------------------------------------------------------
 
 //--------------------------------------------------------------------
 // adding the cogs
 #local Nr = 0;     // start
 #local EndNr = Cog_Number; // end
 #while (Nr< EndNr) 
   object{  Cogs_Add
            rotate<0,Nr * 360/EndNr,0>  
  } // end  

 #local Nr = Nr + 1;    // next Nr
 #end // ---------------  end of loop 

} // end of union -----------------------------------------------------------------------
#end //--------------------------------------------------------------------- end of macro
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------



//---------------------------------------------------------------------
//---------------------------------------------------------------------
#macro Cog_Wheel_Radius (Cog_Number, Cog_Distance)  //----------------------
  Cog_Distance*Cog_Number/(2*pi)
#end //----------------------------------------------------------------
//---------------------------------------------------------------------



//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example: 
/*
//---------------------------------------------------------------------
//---------------------------------------------------------------------
// optional textures !!!
#declare Gear_Texture_Blanc = 
        texture { Polished_Chrome 
                } // end of texture
#declare Gear_Texture_Raw = 
        texture { pigment{ color rgb<1,0.80,0.45>*0.8} 
                  normal { bumps 0.35 scale 0.005} 
                  //finish { phong 0.5 reflection{ 0.15 metallic 0.25} }
                } // end of texture
//---------------------------------------------------------------------
#include "Cog_Wheel_In_1.inc"
#include "Cog_Wheel_1.inc"    
// around y axis, symmetric to xz plane
// declares also macro 'Cog_Wheel_Radius (Cog_Number, Cog_Distance)' 
//---------------------------------------------------------------------
#local N_1 = 36; 
#local N_2 = 18; 
#local CD = 0.15; // cog distance 
#local CZ = 0.5;  // wheel thickness

#local Time = clock +0.5 ;

#local Turn =  Time*360/N_2;//  smallest
//---------------------------------------------------------------------
union{

 object{ Cog_Wheel_In_1 ( 36, CD, CZ) // Cog_Number, Cog_Distance, Gear_Y , 
         rotate<90,0,-Turn>
         translate<0,0,0>
       } //---------------------- 
 
 object{ Cog_Wheel_1    ( 18, CD, CZ) // Cog_Number, Cog_Distance, Gear_Y,
         rotate<90,0, 180/N_2 - 2*Turn>
         scale<0.98,0.98,1>
         translate<0.001+ Cog_Wheel_Radius(N_2,CD)-Cog_Wheel_Radius(N_1,CD),0,0>} 
 //--------------------------------------------------------------------
 rotate<0,0,30>
 rotate<40,-10,0> 
 translate<0.0,1.1,0>
 } // end of union
//---------------------------------------------------------------------
//---------------------------------------------------------------------
*/


#version Cog_Wheel_In_1_Inc_Temp;
#end
//------------------------------------- end of include file

