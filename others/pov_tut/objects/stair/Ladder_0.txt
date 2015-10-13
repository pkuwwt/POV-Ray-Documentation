// PoVRay 3.6/3.7 Include File "Ladder_0.inc"
// author: Friedrich A. Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de  
// email: Friedrich.Lohmueller_AT_t-online.de
#ifndef( Ladder_0_Inc_Temp)
#declare Ladder_0_Inc_Temp = version;
#version 3.6;

//------------------------------------------------------- macro Ladder_0(...)
#macro Ladder_0 (    Ladder_Heigth,
                     Ladder_Halfwidth_x,
                     Ladder_Radius,
                     Step_Radius,
                     Step_Distance, 
                     Ladder_Texture
                   ) //-----------------------
#local Number_of_Steps = int(Ladder_Heigth / Step_Distance);
#local Step_Distance = Ladder_Heigth/ Number_of_Steps;

#local Step = cylinder {<-Ladder_Halfwidth_x,0,0>,<Ladder_Halfwidth_x,0,0>,Step_Radius 
              texture { Ladder_Texture rotate<0,90,0> } }
#local Nr = 1;              // start
#local EndNr = Number_of_Steps; // end
union{
 #while (Nr< EndNr) 
   object{ Step  translate<0,Nr*Step_Distance,0>} 
   #declare Nr = Nr + 1;  // next Nr
  
 #end // --------------- end of loop 

 cylinder{ <0,0,0>,<0,Ladder_Heigth,0>,Ladder_Radius 
           texture { Ladder_Texture rotate<90,0,0> } 
           translate< Ladder_Halfwidth_x,0,0>} 
 cylinder{ <0,0,0>,<0,Ladder_Heigth,0>,Ladder_Radius 
           texture { Ladder_Texture rotate<90,0,0> } 
           translate<-Ladder_Halfwidth_x,0,0>} 

}// end of union
#end // ------------------------------------------------- end of #macro Ladder_0 (...)
 
#version Ladder_0_Inc_Temp;
#end
//----------------------------------------------------------------------------------
//sample: 
/*
//--------------------------------------------------------------------
#declare Ladder_Texture =
 texture{pigment{ color White }
         finish { diffuse 0.9 phong 1}}
//--------------------------------------------------------------------
#include "Ladder_0.inc"
//--------------------------------------------------------------------
object{ Ladder_0 (   2.00,  // Ladder_Heigth,
                     0.225, // Ladder_Halfwidth_x,
                     0.025, // Ladder_Side_Radius, 
                     0.010, // Step_Radius,
                     0.25,  // Step_Distance, 
                     Ladder_Texture // Ladder_Texture
                   ) //-----------------------
        scale<1,1,1> rotate<0,0,0> translate<0,0,0>} 
//--------------------------------------------------------------------
*/
//-------------------------------------------------------------- end of include file

