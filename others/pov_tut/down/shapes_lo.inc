// PoVRay 3.6 Include File "shapes_lo.pov" 
// Version date 15-Aug-2012 
// created by Friedrich A. Lohmueller, 05-Oct-2002, 15-Aug-2012, 06-April-2013
// email:  Friedrich.Lohmueller_AT_t-online.de
// website: http://www.f-lohmueller.de 
//---------------------------------------------------------------------------
// last changes 06-April-2013 / 19-May-2013: 
// update for use with shapes3.inc 
// The following macros are now in shapes3.inc
// all revised and updated, solved some fundamental construction issues 
// (mostly visible with intersection or transparent materials !!)
//  
//  macro Segment_of_Object  
//  macro Segment_of_CylinderRing 
//  macro Segment_of_Torus 
// 
// #macro Column_N (N, Radius, Height ) 
// #macro Pyramid_N (N, Radius1, Radius2, Height )

// #macro Egg_Shape (Lower_Scale, Upper_Scale) 
// #declare Egg  (uses #macro Egg_Shape) 
// #macro Facetted_Sphere (Quarter_Segments, Radial_Segments) 
// #macro Facetted_Egg_Shape (Quarter_Segments, Radial_Segments, Lower_Scale, Upper_Scale)
// #macro Facetted_Egg(N_Quarter_Segments, N_Radial_Segments) 
// #macro Ring_Sphere (Rmaj_H, Rmaj_V, Rmin_H, Rmin_V, Number_of_Rings_horizontal, Number_of_Rings_vertical)
//
// This file contains the following shapes declared by macro or as objects:
//
// for compatibility to older versions, defined with right handed angle: 
//   #macro Cylinder_Ring_Segment ( R_out, R_in, Height, Segment_Angle)  
// for compatibility to older versions, defined with right handed angle: 
//   #macro Torus_Segment( R_major, R_minor, Segment_Angle)   
// for compatibility to older versions
// #macro Round_N_Pyramid (N, Wire_Radius, Pyramid_R1, Pyramid_R2, Pyramid_Height, Fill_On, Merge_On)  
// #macro Round_Tube_Ring_N  (  N, Tube_R, Base_Width,  Edge_R ) 
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
#include "debug.inc"

#ifndef ( SHAPES3_INC_TEMP )
#include "Shapes3.inc"
#end 

//-------------------------------------------------------------------------
#ifndef( Shapes_Lo_Inc_Temp )
#declare Shapes_Lo_Inc_Temp = version;
#version 3.6;


//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
// for compatibility to older versions, defined with right handed angle: 
#macro Cylinder_Ring_Segment   ( R_out_old, R_in_old, Height_old, Segment_Angle_old)
 object{ Segment_of_CylinderRing ( R_out_old, R_in_old, Height_old, Segment_Angle_old)
         scale<1,1,-1>}
#end //--------------------------------------------------------------------
// for compatibility to older versions, defined with right handed angle: 
#macro Torus_Segment ( R_major_old, R_minor_old, Segment_Angle_old)
 object{ Segment_of_Torus( R_major_old, R_minor_old, Segment_Angle_old)
         scale<1,1,-1>}
#end //--------------------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------


//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
#macro Round_N_Pyramid( 
                        N, Wire_Radius,
                        Pyramid_R1,
                        Pyramid_R2,
                        Pyramid_Height,
                        Fill_On, Merge_On
                      ) //---------------
#ifndef (SHAPES3_INC_TEMP )  #include "shapes3.inc" #end
object{ Round_Pyramid_N_out( // defined by  circum circle radii  ! 
                             N , // number of side faces 
                             <0,0,0>,   Pyramid_R1, // A, radius A, 
                             <0,Pyramid_Height+2*Wire_Radius,0>,  Pyramid_R2, //  B, radius B, 
                             Wire_Radius, // wire radius or border radius 
                             Fill_On,  Merge_On  // 
                           ) //-----------------
   translate<0, -Wire_Radius, 0 >
} // end object  
#end // end of macro ------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------
#macro Round_Tube_Ring_N  (  N, Tube_R, Base_Width,  Edge_R ) 
#ifndef (SHAPES3_INC_TEMP )  #include "shapes3.inc" #end
object { Round_N_Tube_Polygon(  N, Tube_R, Base_Width,  Edge_R, 0, 0)   
} // end object  
#end // end of macro ------------------------------------------------------
//-------------------------------------------------------------------------
//-------------------------------------------------------------------------



#version Shapes_Lo_Inc_Temp;
#end
//--------------------------------------------------------------------- end of include file ---------------
