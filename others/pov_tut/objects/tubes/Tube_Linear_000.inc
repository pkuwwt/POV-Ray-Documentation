// POV-Ray 3.6/3.7 include file "Tube_Linear_000.inc"
// author: Friedrich A, Lohmueller, June-2009
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Tube_Linear_000_Inc_Temp)
#declare Tube_Linear_000_Inc_Temp = version;
#version 3.6;
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//--------------------------------------------------------------------------
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"
#end
//--------------------------------------------------------------------------
#macro Tube_Linear_000 (
                  T_L, // lenght
                  T_D, // tube material thickness
                  T_R, // radius
                  F_R, // flange radius
                  F_D, // flange thickness
                  FB_R, // Flange_Border_Radius
                  Nuts_ON, // 0 = no nuts but holes; 1 = nuts - no holes
                  Nut_Scale, // ~0.035
                  Number_of_Nuts, // ~ 16,

                ) // ------------------------------------
//---------------------------------------------------------
#ifndef( Tube_Texture )
#declare Tube_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.01 scale <0.005,0.15,0.15> }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Tube_Inside_Texture )
#declare Tube_Inside_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Flange_Texture_1 )
#declare Flange_Texture_1 =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Flange_Texture_2 )
#declare Flange_Texture_2 =
          texture { pigment{ color rgb< 1, 1, 1>*0.65 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Flange_Hole_Texture )
#declare Flange_Hole_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Nut_Texture_1 )
#declare Nut_Texture_1 =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
#ifndef( Nut_Texture_2 )
#declare Nut_Texture_2 =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#end
//---------------------------------------------------------
#local D = 0.0001; // just a little bit !!!
//---------------------------------------------------------
//#local Nut_Scale = 0.035;
#local Nut =
union{
object{ Hexagon
        scale <1,1,1>
        texture { Nut_Texture_2 }
        scale <0.4,1,1>*Nut_Scale/2 rotate<0,0,0> translate<Nut_Scale/2*0.4,0,0>
       } // end of object
cylinder{ <0,0,0>, <Nut_Scale*1.15/2,0,0>, Nut_Scale/2*0.5
         texture { Nut_Texture_1 }
       } // cyl


}// end uni
//---------------------------------------------------------
#local Flange_Base =
 difference{  // (point A, point B, Radius, EdgeRadius, UseMerge)
   object{ Round_Cylinder(<0,0,0>, <F_D  ,0,0>,F_R, FB_R, 0)
           texture{Flange_Texture_1}}
   cylinder{ <-D,0,0>,<F_D+D,0,0>,T_R-T_D/2 texture{Tube_Inside_Texture} }
 } // end of diff
//---------------------------------------------------------
#local Flange =

#if (Nuts_ON = 1)
union{

 object{ Flange_Base }
 union{
  #local Nr = 0;     // start
  #local EndNr = Number_of_Nuts; // end
  #while (Nr< EndNr)
   object{ Nut
           translate<F_D,0,-T_R-(F_R-T_R)/2>
           rotate<Nr * 360/EndNr,0,0>}
  #local Nr = Nr + 1;    // next Nr
  #end // ---------------  end of loop
 } // end of union
#else
difference{

 object{ Flange_Base}
 #local Nr = 0;     // start
 #local EndNr = Number_of_Nuts; // end
 #while (Nr< EndNr)
 cylinder{<-D,0,0>,<F_D+D,0,0>,Nut_Scale/2*0.5
           texture{ Flange_Hole_Texture }
           translate<0,0,-T_R-(F_R-T_R)/2>
           rotate<Nr * 360/EndNr,0,0>}
  #local Nr = Nr + 1;    // next Nr
  #end // ---------------  end of loop


#end
}// end uni or diff
//---------------------------------------------------------
union{

 // flange at start
 object{ Flange
         scale < 1,1,1>
         rotate<0,0,0>
         translate<0,0,0>
      }
 // the tube
 difference{
   cylinder{ < 0,0,0>,<T_L  ,0,0>,T_R     texture{Tube_Texture} }
   cylinder{ <-D,0,0>,<T_L+D,0,0>,T_R-T_D texture{Tube_Inside_Texture} }
 } // end of difference
 // flange at end
 object{ Flange
         scale <-1,1,1>
         rotate<0,0,0>
         translate<T_L,0,0>
       } //

} // end of union
#end // ---------------------------------------------------- end of macro
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------


//--------------------------------------------------------------------------
//--------------------------------------------------------------------------




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample:
/*
//----------------------------------------------------------------------------- textures
// ------------------------------------------- optional textures
#declare Tube_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.01 scale <0.005,0.15,0.15> }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Tube_Inside_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Flange_Texture_1 =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Flange_Texture_2 =
          texture { pigment{ color rgb< 1, 1, 1>*0.65 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Flange_Hole_Texture =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Nut_Texture_1 =
          texture { pigment{ color rgb< 1, 1, 1>*0.75 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
#declare Nut_Texture_2 =
          texture { pigment{ color rgb< 1, 1, 1>*0.55 }
                    normal { bumps 0.015 scale 0.005 }
                    finish { phong 1 reflection 0.00}
                 } // end of texture
//-------------------------------------------------------------------------------

object{ Tube_Linear_000 (
                   1.500, // T_L, // tube lenght in x
                   0.015, // T_D, // tube material thickness
                   0.300, // T_R, // radius
                   0.450, // F_R, // flange radius
                   0.050, // F_D, // flange thickness
                   0.005, // FB_R, // Flanch_Border_Radius
                   1, // Nuts_ON  // 0 = no nuts but holes; 1 = nuts - no holes
                   0.065, // Nut_Scale
                   16, // Number_of_Nuts
                ) // ------------------------------------

        rotate<0,0,0>
        translate<0,0,0>
      }//--------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Tube_Linear_000_Inc_Temp;
#end
//------------------------------------- end of include file
