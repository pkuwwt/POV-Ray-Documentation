// POV-Ray 3.6 include file "Winding_Wire_1.inc"
// author: Friedrich A, Lohmueller, Jan-2014
// homepage: http://www.f-lohmueller.de/
//------------------------------------------------------------------------
#ifndef( Winding_Wire_1_Inc_Temp)
#declare Winding_Wire_1_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef ( Math_Inc_Temp )
#include "math.inc" 
#end
#ifndef ( Shapes3_Inc_Temp )
#include "shapes3.inc"
#end
//--------------------------------------------------------------------------//////
//--------------------------------------------------------------------------//////
//--------------------------------------------------------------------------//////
//------------------------------------ A quadratic coil of wire ------------//////
#macro Winding_Wire_1(  WR_ , // 0.065;// Wire radius
                        WD_ , // 0.19; // vertical wire distance: min 2*WR  (pitch)
                        BR_ , // 0.50; // column base radius (to wire center)
                        Rmaj_, // 0.30; // corner radius major of wire 
                        Revolutions_ , // 4.5 ;// 0.25, 0.5, 0.75, 1,2,3 .... 
                      ) //---------------------------------------------------------
//--------------------------------------------------------------------------//////
//-------------------------------------------
#local D = 0.00001;
//-------------------------------------------

#local WR   = WR_; // Wire radius
#local WD   = WD_; // vertical wire distance: min 2*WR  (pitch)
#local BR   = BR_; // column base radius (to wire center)
#local Rmaj = Rmaj_; // corner radius major of wire 
#local Revolutions = Revolutions_ ;// 0.25, 0.5, 0.75, 1, .... 

//------------------------------------------------------------------------------------
// Darstellung der Winkel situationen! Corner angle kleiner als 90°
//------------------------------------------------------------------------------------
#local A  = < 0.00, 0.00, -BR >;
#local B  = <   BR, WD/4, 0.00>;
#local Co = <   BR, WD/8, -BR >;//corner

//----------------------------------- 
#if(Rmaj <= WR) #local Rmaj = wR+D; #end
#if(Rmaj >= BR) #local Rmaj = BR-D; #end

//------------------------------------------------------------------------------------
#local Corner_Angle = VAngleD( Co-A,B-Co ); // -> angle in degrees!
#local Co_Len = Rmaj*tan(radians(Corner_Angle/2)); // corner linear length
#local Len_X = vlength(Co-A)-Co_Len;  // linear wire part 
#local Wire_Angle = VAngleD( Co-A, <1,0,0>);  // angle of vector ACo against xz plane

#local Th = WD/8*cos(radians(Wire_Angle)); 
#local Inner_Angle = degrees(atan2(Th,BR)); // rotation angle of 2nd part CoB
//------------------------------------------------------
#local W_Corner =   
object{ Segment_of_Torus( Rmaj, // radius major,
                          WR,   // radius minor,
                          -Corner_Angle // segment angle
                        ) //----------------------------
        rotate<0,90,0> 
        translate<-0,0,+Rmaj>
      } // ---------------------------------------------
#local Quarter =   
union{ 
     cylinder{ <0,0,0>,< Len_X,0,0>, WR  } 
     object  { W_Corner  rotate<-Inner_Angle,0,0> 
               translate< Len_X,0,0> }  
     cylinder{ <0,0,0>,< Len_X,0,0>, WR 
               translate<0,0,-Rmaj> rotate<0,-Corner_Angle,0> translate<0,0,Rmaj>
               rotate<-Inner_Angle,0,0>
               translate<Len_X,0,0> 
             } //----------------------
  translate<0,0,-BR>
  rotate<0,0,Wire_Angle>
} // end of union  --------------------------------------

//------------------------------------------------------- final union 
// Winding Wire
union{ //-----------------------------------
 #local Nr = 0;                // start
 #local EndNr = 4*Revolutions; // end
 #while (Nr< EndNr)            // loop
   object{ Quarter
           translate<0, Nr*WD/4,0>
           rotate<0,-Nr*90,0>
         } //----------------

 #local Nr = Nr + 1; // next Nr
 #end // ---------------// end of loop
} // end of final union --------------------------------------------------- //////
#end // ------------------------------------------------------ end of macro //////
//--------------------------------------------------------------------------//////
//--------------------------------------------------------------------------//////




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//--------------------------------------------------------------------------//////
//--------------------------------------------------------------------------//////
#include "shapes_lo2/Winding_Wire_1.inc"
//--------------------------------------------------------------------------//////
object{ Winding_Wire_1( 0.065, // Wire radius
                        0.19, // vertical wire distance: min 2*WR (pitch)
                        0.50, //  column base radius (to wire center)
                        0.30, //  corner radius major of wire 
                        4.5 , //  4.5 ;// revolutions: 0.25, 0.5, 0.75, 1,2,3 .... 
                      ) //--------------------------------------------------------
        texture{ pigment{ color rgb< 0.85, 0.37, 0.15>*0.59 }
                 normal { bumps 0.1 scale 0.15}
                 finish { phong 1 specular 0.0 reflection{ 0.55 metallic 0.5 } }
               } // end of texture
        rotate<0,0,0> 
        translate<0,0,0>
      } //------------------------------------------------------------------//////
//--------------------------------------------------------------------------//////
//--------------------------------------------------------------------------//////
*/


#version Winding_Wire_1_Inc_Temp;
#end
//------------------------------------- end of include file

