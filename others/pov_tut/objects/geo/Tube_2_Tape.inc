// POV-Ray 3.6/3.7 include file "Tube_2_Tape.inc"
// author: Friedrich A, Lohmueller, Aug-2009
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Tube_2_Tape_Inc_Temp)
#declare Tube_2_Tape_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////
#macro Tube_2_Tape (     Radius_1_,
                         Radius_2_,
                         Length_,
                         End_Width_,

                         End_Center_Y_,
                         End_Center_Z_,

                         Accuracy, // >= 1
                         Merge_On )
//---------------------------------------------------------------------------------------
#local D = 0.000001;
//---------------------------------------------------------------------------------------
#local Scale_X = 0.15; // ~
#local Number_of_Elements = 500*Accuracy*Length_;

#local R1 = 1;
#local R2 = (Radius_2_/Radius_1_);
#local Center_Shift_Y_= End_Center_Y_/Radius_1_;
#local Center_Shift_Z_= End_Center_Z_/Radius_1_;
#local Z_Factor = End_Width_/Radius_1_;
#local Bounding_Width = max( R1+D, +max(R2,R1) +End_Width_/Radius_1_+max(End_Center_Z_,End_Center_Y_))/Radius_1_;

#local R_Difference = abs(R2-R1);
//---------------------------------------------------------------------------------------
//--------------------------------
//--------------------------------
#macro  Cos_010( X )
  (0.5-0.5*cos(2*pi*X))
#end
//--------------------------------
#macro  Cos_01( X )
  (0.5-0.5*cos(  pi*X))
#end
//--------------------------------
#macro  Cos_10( X )
  ( 1-(0.5-0.5*cos(  pi*X)))
#end
//--------------------------------
//--------------------------------
//---------------------------------------------------------------------------------------
intersection {
 #if (Merge_On = 1 )
merge {
 #else
union {
 #end

 #local Nr = 0;     // start
 #local EndNr = Number_of_Elements; // end
 #while (Nr< EndNr+1 )
   #if (R2 <= R1)
    #local Shrink_Scale = Cos_01(Nr/EndNr)+D;
    #local Shrink_Trans = Cos_01(Nr/EndNr);
    #local Trans_Z      = Cos_01(Nr/EndNr)+D ;
   #else  // (R2 > R1)
    #local Shrink_Scale = -Cos_01(Nr/EndNr)-D;
    #local Shrink_Trans =  Cos_01(Nr/EndNr);
    #local Trans_Z      =  Cos_01(Nr/EndNr)-D ;
   #end //
   // scales YZ
   #local Scale_Y = R1 - R_Difference*Shrink_Scale;
   #local Scale_Z = R1 - R_Difference*Shrink_Scale;
   // borders right/left
   #local Translate_Z =  Z_Factor*Trans_Z;
   // center translated
   #local Center_Translate_Y =  Center_Shift_Y_*Shrink_Trans;
   #local Center_Translate_Z =  Center_Shift_Z_*Shrink_Trans;
 #if (Merge_On = 1 )
merge {
 #else
union {
 #end

   sphere{<0,0,0>,1 scale <Scale_X,Scale_Y,Scale_Z>  translate<Nr*1/EndNr , 0, Translate_Z>}
   sphere{<0,0,0>,1 scale <Scale_X,Scale_Y,Scale_Z>  translate<Nr*1/EndNr , 0,-Translate_Z>}
   cylinder{<0,0,-Translate_Z>,<0,0,Translate_Z>,1 scale <Scale_X,Scale_Y,1>   translate<Nr*1/EndNr , 0 , 0> }

   translate<0,Center_Translate_Y,Center_Translate_Z>
 }//union or merge

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop

 } // end of union or merge ----------------------------------------------------

box{ <0,-Bounding_Width,-Bounding_Width>,<1,Bounding_Width,Bounding_Width> }
scale< Length_ ,Radius_1_,Radius_1_>
} // end of intersection -------------------------------------------------------
#end //-------------------------------- end of macro
//------------------------------------------------------------------------------ /////////




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example:
/*
// --------------------------------------------------------------------
// --------------------------------------------------------------------
#declare D = 0.0001;
// --------------------------------------------------------------------
#include "Tube_2_Tape.inc"
// --------------------------------------------------------------------
#declare R1 = 0.60;
#declare R2 = 0.2;
#declare Len = 1.20;
#declare End_Width = 0.70;
#declare End_Center_Y = 0.50;
#declare End_Center_Z = 0.90;
// --------------------------------------------------------------------
object{ Tube_2_Tape (     R1, // Radius_1_,
                          R2, // Radius_2_,
                          Len, // Length_,    [1->1000;2->500]
                          End_Width, // End_Width_,

                          End_Center_Y, // End_Center_Y
                          End_Center_Z, // End_Center_Z

                          1, // Accuracy, // >= 1
                          0, // Merge_On )

                        ) //-------------------------------------------
        texture { pigment{ color rgb< 1,1,1>*1.2}// 0.75, 1.0, 0.0> }
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1 reflection 0.00}
                } // end of texture

        scale<1,1,1>
        rotate<0,0,0>
        translate<0,0,0>
      } // ------------------------------------------------------------
 cylinder{ <-1,0,0>,<D,0,0>, R1 pigment{ color rgbt< 1,1,1,0.8>*1.0}}

 merge{
        box{<-D,R2,-End_Width>,<0.5+D,-R2,End_Width> }
        cylinder{ <0,0,0>,<0.5,0,0>, R2 translate<0,0, End_Width>}
        cylinder{ <0,0,0>,<0.5,0,0>, R2 translate<0,0,-End_Width>}
        translate<Len-D,End_Center_Y,End_Center_Z>
        pigment{ color rgbt< 1,1,1,0.7>*1.0}
      }
// --------------------------------------------------------------------
// --------------------------------------------------------------------
*/


#version Tube_2_Tape_Inc_Temp;
#end
//------------------------------------- end of include file
