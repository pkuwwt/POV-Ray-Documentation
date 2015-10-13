// POV-Ray 3.6/3.7 include file "Random_Planting_100.inc"
// author: Friedrich A, Lohmueller, Dec-2005, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Random_Planting_100_Inc_Temp)
#declare Random_Planting_100_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
#macro Random_Planting_100 ( Object1_to_Plant, // object type 1 to plant                                   
                             Object2_to_Plant, // object type 2 to plant                                  
                             Random_Choice__Seed, 
                             Choice_Threshold, // from 0.00 = only type1 up to 1.00 = only type2 
                             Number_in_X, // number of objects in x direction
                             Number_in_Z, // number of objects in z direction
                             Base_Distance_X, //
                             Base_Distance_Z, // ~2.75
                             Base_Tilt_Angel, // ~ 10
                             Tilt_Angel_Ramdom_Factor, // ~1
                             Base_Object_Scale, // ~ 1
                             Object_Scale_Ramdom_Factor, // ~ 0.5
                             Seed_0, // Ramdom seed for tilt on x-axis 
                             Seed_1, // Ramdom seed for rotating around y-axis
                             Seed_2, // Ramdom seed for scaling
                             Seed_3, // Ramdom seed for moving in x and z
                           
                           ) //---------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
// #local D = 0.00001;
//---------------------------------------------------------------------------------------

// --------------------------------------------------------------------------------------
// Choosing random series
#local Random_0 = seed (Seed_0); 
#local Random_1 = seed (Seed_1); 
#local Random_2 = seed (Seed_2); 
#local Random_3 = seed (Seed_3);
#local Random_Choice = seed(Random_Choice__Seed);
union{
 #local NrX = 0;     // start x
 #local EndNrX =  Number_in_X; // end   x
 #while (NrX< EndNrX+1) 
    // inner loop
    #local NrZ = 0;     // start z
    #local EndNrZ =  Number_in_Z; // end   z
    #while (NrZ< EndNrZ+1) 
    
    #if ( rand(Random_Choice) < Choice_Threshold)  
     object{ Object2_to_Plant
    #else 
     object{ Object1_to_Plant
    #end
             rotate<Base_Tilt_Angel*Tilt_Angel_Ramdom_Factor*2*(0.5-rand(Random_0)),0,0>
             rotate<0,360*rand(Random_1),0>
             scale  Base_Object_Scale+Object_Scale_Ramdom_Factor*rand(Random_2)
             translate <NrX*Base_Distance_X+2*(-0.5+rand(Random_3)), 0, NrZ*Base_Distance_Z+2*(-0.5+rand(Random_3))>} 

    #local NrZ = NrZ + 1;  // next Nr z
    #end // --------------- end of loop z
    // end inner loop
 #local NrX = NrX + 1;  // next Nr x
 #end // --------------- end of loop x
 // end of outer loop


} // end of union --------------------------
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#include "Tree_00.inc" // include 1st type of tree
#include "Tree_10.inc" // include 2nd type of tree
//-------------------------------------------------------------------------------------// 
#include "Random_Planting_100.inc" 
//-------------------------------------------------------------------------------------// 
object{ Random_Planting_100( object{ Tree_00}, //  object type 1 to plant, //                                   
                             object{ Tree_10}, //  object type 2 to plant, //                                   
                             24127, // Random_Choice__Seed, integer 0 ~ 65536
                             0.50, // Choice_Threshold, // from 0.00 = only type1 up to 1.00 = only type2 
                             6, // Number_in_X, // number of objects in x direction
                             4, // Number_in_Z, // number of objects in z direction
                             2.75, // Base_Distance_X, //
                             2.75, // Base_Distance_Z, // 
                             10,   // Base_Tilt_Angel, // degrees
                             1.00, // Tilt_Angel_Ramdom_Factor, // 
                             1.00, // Base_Object_Scale, // ~ 1
                             0.50, // Object_Scale_Ramdom_Factor, // ~ 0.5
                             // integers 0 ~ 65536
                             6432, // Seed_0, // Ramdom seed for tilt on x-axis 
                             1153, // Seed_1, // Ramdom seed for rotating around y-axis
                              342, // Seed_2, // Ramdom seed for scaling
                             2655  // Seed_3, // Ramdom seed for moving in x and z
                           ) //--------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<-8.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Random_Planting_100_Inc_Temp;
#end
//------------------------------------- end of include file

