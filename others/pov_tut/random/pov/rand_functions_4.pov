// POV-Ray 3.6/3.7 Scene File "rand_functions_4.pov"
// author: Friedrich A. Lohmueller, Jan-2011/April-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 2.00,  1.00,-2.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.00, 0.00> ;
  #declare Camera_Angle    =  45  ;
#break
#case (2)
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (3)
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00,-20.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{ <2500, 1500, 500> color White*0.8 }
light_source{ Camera_Position  color rgb<0.8,0.8,1>*0.1}
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.24,0.34,0.56>*0.8]//~Navy
                                [0.6 color rgb<0.24,0.34,0.56>*0.8]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     rotate<50,0,50>
                     scale 2 }
           } // end of sky_sphere
//------------------------------------------------------------------------

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


// macro "Vector( ... ) from "analytical_g.inc"
//----------------------------------------------------------- macro "Vector(Start,End,Radius)"!
#macro Vector(P_start, P_end, R_Vector)
union{

cylinder{ P_start, P_end - ( vnormalize(P_end - P_start)*9.5*R_Vector), R_Vector  }
cone    { P_end - ( vnormalize(P_end - P_start)*10*R_Vector), 3*R_Vector, P_end, 0 }
}// end of union
#end //-------------------------------------------------------------------------- end of macro


//----------------------------------------------------------- macro "Vector(Start,End,Radius)"!
#macro Vector(P_start,P_end, R_Vector)
union{
 cylinder{ P_start, P_end - ( vnormalize(P_end - P_start)*9.5*R_Vector), R_Vector  }
 cone    { P_end - ( vnormalize(P_end - P_start)*10*R_Vector), 3*R_Vector, P_end, 0 }
}// end of union
#end //-------------------------------------------------------------------------- end of macro

//------------------ random functions standard include file
#include "rand.inc"
#declare Random_1 = seed (12433);
//---------------------------------------------------------

#declare MyObject =
cone { <0,0,0>,1.00,<0,1.5,0>,0
       translate<0,-0.5,0>
     } // end of cone -------------------------------------
//---------------------------------------------------------


//---------------------------------------------------------
union{
 #local Nr = 0;     // start
 #local EndNr = 3000; // end
 #while (Nr< EndNr)
   sphere{ <0,0,0>, 0.05
           translate VRand_In_Obj( MyObject, Random_1)*1
           texture{ Polished_Chrome
                    pigment{ color rgb< 1.0, 0.55, 0.0> }
                  } // end of texture
         } // end of object

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop

rotate<0, 0,0>
translate<0,0,0>} // end of union
//---------------------------------------------------------
//---------------------------------------------------------