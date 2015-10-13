// POV-Ray 3.6/3.7 include file "Fender_1.inc"
// author: Friedrich A, Lohmueller, June-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//--------------------------------------------------------------------------
#ifndef( Fender_1_Inc_Temp)
#declare Fender_1_Inc_Temp = version;
#version 3.6;

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"                                             
#end

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#macro Fender_1 (   Rmaj_, // major radius, 
                    Rmin_, // minor radius,  
                    RD_, // steal thickness 
                    SAngle_, // fender angle, 
                 ) // -------------------------
#include "shapes3.inc"
//--------------------------------------------------------------------------
#ifndef( Fender_Outside_Texture )
#declare Fender_Outside_Texture  =  
        texture{ pigment{ color rgb<1,1,1>} 
                 finish { phong 1}
               } // end of texture 
#end 
#ifndef( Fender_Inside_Texture )
#declare Fender_Inside_Texture  =  
        texture{ pigment{ color rgb<1,1,1>*0.5} 
                 finish { phong 1}
               } // end of texture 
#end 
#ifndef( Fender_Border_Texture )
#declare Fender_Border_Texture  =  
        texture{ pigment{ color rgb<1,1,1>*1.3} 
                 finish { phong 1}
               } // end of texture 
#end 

//--------------------------------------------------------------------------
#local D = 0.0001;
//-----------------------------------------------
#local Rmaj = Rmaj_; // ~ 1;
#local Rmin = Rmin_; // ~ 0.1;
#local RD = RD_; //  ~ 0.02;
#local SAngle = SAngle_; // ~80;                              
//-----------------------------------------------
#local AddAng = 2*Rmaj*degrees(atan( Rmin/Rmaj)) ;
//--------------------------------------------------------------------------
intersection{

 union{

    object{ Segment_of_CylinderRing( Rmaj+Rmin, // major radius,
                                     Rmaj, // minor radius,  
                                     2*Rmin, // height H,
                                    -SAngle  // angle (in degrees)  
                                   ) //-------------------------------
            texture{ Fender_Border_Texture } 
            rotate<-90,0,90> translate<0,0,Rmin>
          } // end of object
    //----------------------------------------------------------------
    cylinder{ <0,0,-Rmin-D>,< 0,0,Rmin>, Rmin translate<0,Rmaj+Rmin,0>
              texture{ Fender_Border_Texture } 
            } // end of cylinder  ------------------------------------

    cylinder{ <0,0,-Rmin-D>,< 0,0,Rmin>, Rmin translate<0,Rmaj+Rmin,0>
              texture{ Fender_Border_Texture } 
              rotate<0,0,SAngle>  
            } // end of cylinder -------------------------------------

  }// end of union
 //--------------------------------------------------------------------------

 //--------------------------------------------------------------------------
 object{ Segment_of_Torus ( Rmaj, // radius major, 
                            Rmin, // radius minor, 
                            -SAngle-2*AddAng  // segment angle (in degrees)
                          ) //-----------------------------------
         texture { Fender_Outside_Texture }
         rotate<-90,0,90> rotate<0,0,-AddAng> 
       } // end of Torus_Segment(...) ---------------------------              
 //--------------------------------------------------------------------------
 torus{ Rmaj, Rmin-RD  rotate<90,0,0>  
        texture { Fender_Inside_Texture }
        inverse } 
 //--------------------------------------------------------------------------

} // end of intersection
//---------------------------------------------------------------------------------------
#end //--------------------------------------------------------------------- end of macro
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-------------------------------------------------------------------- optional textures
#declare Fender_Outside_Texture  =  
        texture{ pigment{ color rgb<1,1,1>} 
                 finish { phong 1}
               } // end of texture 
#declare Fender_Inside_Texture  =  
        texture{ pigment{ color rgb<1,1,1>*0.5} 
                 finish { phong 1}
               } // end of texture 
#declare Fender_Border_Texture  =  
        texture{ pigment{ color rgb<1,1,1>*1.3} 
                 finish { phong 1}
               } // end of texture 
//---------------------------------------------------------------------------------------
#include "Fender_1.inc" 
//-------------------------------------------------------------------------------------// 
object{ Fender_1 ( 0.7, // major radius, 
                   0.2, // minor radius, end radius 
                   0.02,// steal thickness 
                   70,  // fender angle, 
                 ) // ------------------------- 
        scale <1,1,1>*1 
        rotate<70,0,0>
        translate<0,0,0>
      } //-----------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Fender_1_Inc_Temp;
#end
//------------------------------------- end of include file

