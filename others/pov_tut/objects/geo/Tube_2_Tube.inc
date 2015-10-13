// POV-Ray 3.6/3.7 include file "Tube_2_Tube.inc"
// author: Friedrich A, Lohmueller, Aug-2009
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Tube_2_Tube_Inc_Temp)
#declare Tube_2_Tube_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////
#ifndef ( Transforms_Inc_Temp )
#include "transforms.inc"
#end

#macro Tube_2_Tube(       Radius_1_,
                          Radius_2_,
                          Length_,

                          End_Center_Y_,
                          End_Center_Z_,

                          Accuracy, // >= 1
                          Merge_On )
//---------------------------------------------------------------------------------------
#local D = 0.000001;  // just a little bit !
//---------------------------------------------------------------------------------------
#local Scale_X = 0.1; // ~
#local Number_of_Elements = 500*Length_;

#local Bounding_Width = max( Radius_1_, Radius_2_+max(End_Center_Z_,End_Center_Y_));

#local R_Difference = Radius_2_-Radius_1_;
//---------------------------------------------------------------------------------------
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
   // scale
   #local Scale_ZY = Radius_2_ - R_Difference*(0.50000-0.50000*cos(1*pi*Nr/(EndNr) + pi)) +D;
   // center translated
   #local Center_Translate_Y =  End_Center_Y_*(0.50000-0.50000*cos(1*pi*Nr/EndNr));
   #local Center_Translate_Z =  End_Center_Z_*(0.50000-0.50000*cos(1*pi*Nr/EndNr));

   sphere{ <0,0,0>,1
           scale <Scale_X,Scale_ZY,Scale_ZY>
           translate<Nr*1/EndNr  ,Center_Translate_Y, Center_Translate_Z>}

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop

 } // end of union or merge ----------------------------------------------------
box{ <0,-Bounding_Width,-Bounding_Width>,<1,Bounding_Width,Bounding_Width> }
scale< Length_ ,1, 1>
} // end of intersection -------------------------------------------------------
#end //-------------------------------- end of macro
//------------------------------------------------------------------------------ /////////




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example:
/*
//---------------------------------------------------------------------
// --------------------------------------------------------------------
#declare R1 = 0.50;  // start radius at <0,0,0>
#declare R2 = 0.30;  // end radius at <Len,End_Center_Y,End_Center_Z>
#declare Len = 1;
#declare End_Center_Y= 0.50;
#declare End_Center_Z= 0.50;

// --------------------------------------------------------------------
#include "Tube_2_Tube.inc"
// --------------------------------------------------------------------
object{ Tube_2_Tube     (  R1, // Radius_1_,
                           R2, // Radius_2_,
                           Len, // Length_,    [1->1000;2->500]

                           End_Center_Y, // End_Center_Y_,
                           End_Center_Z, // End_Center_Z_,

                           1, // Accuracy, // >= 1
                           0, // Merge_On )

                        ) //-------------------------------------------
        texture { pigment{ color rgb< 1,1,1>*1.2}// 0.75, 1.0, 0.0> } //  yellow lemon
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1 reflection 0.00}
                } // end of texture

        scale<1,1,1>
        rotate<0,00,0>
        translate< 0, 0.0, 0>

      } // ------------------------------------------------------------
 cylinder{ <0,0,0>,< +0.5,0,0>, R2 translate<Len,End_Center_Y,End_Center_Z> pigment{ color rgbt< 1,1,1,0.7>*1.0}}
 cylinder{ <-0.5,0,0>,<0,0,0>, R1 pigment{ color rgbt< 1,1,1,0.7>*1.0}}
// --------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Tube_2_Tube_Inc_Temp;
#end
//------------------------------------- end of include file
