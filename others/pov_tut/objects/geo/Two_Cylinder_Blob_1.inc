// POV-Ray 3.6 / 3.7 include file "Two_Cylinder_Blob_1.inc"
// author: Friedrich A, Lohmueller, Feb-2010, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Two_Cylinder_Blob_1_Inc_Temp)
#declare Two_Cylinder_Blob_1_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"                                             
#end
//-------------------------------------------------------------------------//////////// 
//-------------------------------------------------------------------------//////////// 
// Two_Cylinder_Blob_1
#macro Two_Cylinder_Blob_1 ( Pitch, // ~0.0127, // distance of the 2 cylinders
                             SD,    // ~0.0009, // slice thickness
                             Cyl_R, // ~0.0051, // cylinder radius 
                             Fillet_R , // ~ 0.0081, // fillet radius
                             Axis_R, // ~0.0032, // <Cyl_R, 0=non
                             Border_R, // ~ 0.0005, // 
                          ) 
//-------------------------------------------------------------------------------------
#local D = 0.00001;
#local BR = Border_R; 

#if ( BR > SD/2) 
  #local BR = SD/2 -2*D; 
  #debug concat("Border radius ",str(Border_R,12,10)," < slice tickness/2",str(SD,12,10), "\n"
                "Border radius set to ",str(BR,12,10),"\n")
#end

// distance of fillet from centerline of right and left cylinder:
#local Fillet_Y  = sqrt( pow(Fillet_R+Cyl_R,2) - pow(Pitch/2,2));                              
// S =  tangent point of the cylinders!
#local S_X = Fillet_R/(Cyl_R + Fillet_R)*Pitch;// proportional 
#local S_Y = Cyl_R/(Cyl_R + Fillet_R)*Fillet_Y;       
//---------------------------------------------
#local Cut_Angle =  degrees(asin( (Pitch/2)/( Cyl_R + Fillet_R) ) )  ; 
//-------------------------------------------------------------------------------------  
//-------------------------------------------------------------------------------------
union{ //2
#if (Axis_R > 0) 
difference{ //2
#end
 union{ // 1
  // right and left round slice
  object{ Round_Cylinder(<0,0,-SD/2>,<0,0,SD/2>,Cyl_R,BR,0) translate< Pitch/2,0,0> } 
  object{ Round_Cylinder(<0,0,-SD/2>,<0,0,SD/2>,Cyl_R,BR,0) translate<-Pitch/2,0,0> } 
  difference{  // 1 
    box{<-S_X,-S_Y,-SD/2-D/2>,<S_X,S_Y,SD/2> }
    // side cut out
    cylinder{ <0,0,-SD/2-D>, <0,0,SD/2+D>, Fillet_R translate<0, Fillet_Y,0>} 
    cylinder{ <0,0,-SD/2-D>, <0,0,SD/2+D>, Fillet_R translate<0,-Fillet_Y,0>} 
    // border cut: 
    cylinder{ <0,0,-SD/2-D>, <0,0,-SD/2+BR>, Fillet_R+BR translate<0, Fillet_Y,0>} 
    cylinder{ <0,0, SD/2+D>, <0,0, SD/2-BR>, Fillet_R+BR translate<0, Fillet_Y,0>} 
    cylinder{ <0,0,-SD/2-D>, <0,0,-SD/2+BR>, Fillet_R+BR translate<0,-Fillet_Y,0>} 
    cylinder{ <0,0, SD/2+D>, <0,0, SD/2-BR>, Fillet_R+BR translate<0,-Fillet_Y,0>} 
   } // diff 1
 }// end uni 1 
 
#if (Axis_R > 0) 
  // holes for axes
  cylinder{ <0,0,-SD/2-D>, <0,0,SD/2+D>,  Axis_R translate< Pitch/2,0,0>} 
  cylinder{ <0,0,-SD/2-D>, <0,0,SD/2+D>,  Axis_R translate<-Pitch/2,0,0>} 
 }// end difference 2
#end
 
 // rounded side cuts
 object{ Segment_of_Torus( Fillet_R+BR,BR,  2*Cut_Angle)  rotate<-90,0,-90+Cut_Angle>
         translate<0, Fillet_Y,-SD/2+BR  > } 
 object{ Segment_of_Torus( Fillet_R+BR,BR,  2*Cut_Angle)  rotate<-90,0,-90+Cut_Angle>
         translate<0, Fillet_Y, SD/2-BR  > } 
 object{ Segment_of_Torus( Fillet_R+BR,BR,  2*Cut_Angle)  rotate<-90,0,-90+Cut_Angle>
         translate<0, Fillet_Y,-SD/2+BR  > scale<1,-1,1>} 
 object{ Segment_of_Torus( Fillet_R+BR,BR,  2*Cut_Angle)  rotate<-90,0,-90+Cut_Angle>
         translate<0, Fillet_Y, SD/2-BR  > scale<1,-1,1>} 
 
}// end uni 2 //----------------------------------------------------------------------------
#end //------------------------------------------------------------------------ end of macro       
//------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- //////////// 




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example: 
/*
//---------------------------------------------------------------------------- 
//----------------------------------------------------------------------------
#include "Two_Cylinder_Blob_1.inc"
//----------------------------------------------------------------------------
object{ Two_Cylinder_Blob_1 ( 0.0127, // Pitch, // distance of the 2 cylinders
                              0.0009, // SD,    // slice thickness
                              0.0051, // Cyl_R, // cylinder radius 
                              0.0081, // Fillet_R , // fillet radius
                              0.0022, // Axis_R, // < Cyl_R, 0=non
                              0.0005, // Border_R, //  
                            ) 

        texture { pigment{ color rgb<1, 1,1>}
                 // normal { bumps 0.15 scale 0.0005}
                  finish { phong 1.0 reflection 0.10}
                } // end of texture

        scale<1,1,1>  rotate<0,0,0>  translate<0,0,0>  
      } // end of sphere ----------------------------------- 
 
object{ Two_Cylinder_Blob_1 ( 0.0127, // Pitch, // distance of the 2 cylinders
                              0.0009*5, // SD,    // slice thickness
                              0.0051, // Cyl_R, // cylinder radius 
                              0.0081, // Fillet_R , // fillet radius
                              0.0000, // Axis_R, // < Cyl_R, 0=non
                              0.0005, // Border_R, //  
                            ) 

        texture { pigment{ color rgb<1, 1,1>}
                 // normal { bumps 0.15 scale 0.0005}
                  finish { phong 1.0 reflection 0.10}
                } // end of texture

        scale<1,1,1>  rotate<0,0,0>  translate<0,0,0.015>  
      } // end of sphere ----------------------------------- 
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Two_Cylinder_Blob_1_Inc_Temp;
#end
//------------------------------------- end of include file

