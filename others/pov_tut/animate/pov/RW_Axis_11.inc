// POV-Ray 3.6/3.7  include file "RW_Axis_11.inc"                                                                                                                                // author: Friedrich A, Lohmueller, Aug-2012
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RW_Axis_11_Inc_Temp)
#declare RW_Axis_11_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end
//-------------------------------------------------------------------///////////////////  
//------------------------------------------------------------------- RW_Axis_10 macro
#macro RW_Axis_11(  Wheel_Diameter___, // in meter
                    Number_Of_Spokes___, // 
                    Connector_Radius___ // 0 or >wheel diameter/2 = non
                               // must be between:  < 0 and < 0.5 wheel diameter                    
                    Counterweight_Depth___, //  0 = non,  < 0.5 wheel diameter 
                    Gauge___, // gauge in meter
                 ) //---------------------------------------------------
//------------------------------------------------------------------------
// declares default textures: 
#ifndef (Wheel_Metal_1)
#declare Wheel_Metal_1 =  texture{Polished_Chrome pigment{quick_color White} finish {phong 1}}
#end
#ifndef (Wheel_Metal_2)
#declare Wheel_Metal_2 =  texture{pigment{ rgb<1,1,1>*0.6 quick_color White} finish {phong 0.2 reflection{ 0.3 metallic}}} 
#end
#ifndef (Wheel_Texture_1)
#declare Wheel_Texture_1 = texture{ pigment{ color rgb<1,0.65,0.45>*0.40} normal{ bumps 0.125 scale 0.05} finish{ phong 0.2}}
#end
#ifndef (Wheel_Texture_2)
#declare Wheel_Texture_2 = texture{ pigment{ color rgb<0.9,0.57,0.50>*0.55} normal{ bumps 0.15 scale 0.0125} finish{ phong 0.1}} 
#end
//------------------------------------------------------------------------
//------------------------------------------------------------------------
#ifndef (           RW_Wheel_11_Inc_Temp )
#include "RW_System/RW_Wheel_11.inc"
#end
//------------------------------------------------------------------------
#local Wheel = 
object{ RW_Wheel_11(  Wheel_Diameter___, // in meter
                      Number_Of_Spokes___,  // 
                      Connector_Radius___,  // 0 or >wheel diameter/2 = non
                               // must be between:  < 0 and < 0.5 wheel diameter                    
                       Counterweight_Depth___, //  0 = non,  < 0.5 wheel diameter 
 
                    )  } // --------------------------------------------//
     
//------------------------------------------------------------------------ 
//------------------------------------------------------------------------ 
union{ 

object{ Wheel translate<0,0,-Gauge___/2> }
object{ Wheel translate<0,0,-Gauge___/2> scale<-1,1,-1> }
cylinder{ <0,0,-Gauge___/2>, <0,0, Gauge___/2>, 0.05 texture{ Wheel_Texture_1 } }

} // end of union ------------------
#end //------------------------------------------------------------------------ end of macro
//------------------------------------------------------------------------------------//////




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//--------------------------------------------------------------- optional textures --//
#declare Wheel_Metal_1 =  texture{Polished_Chrome pigment{quick_color White} finish {phong 1}}
#declare Wheel_Metal_2 =  texture{pigment{ rgb<1,1,1>*0.6 quick_color White} finish {phong 0.2 reflection{ 0.3 metallic}}} 
#declare Wheel_Texture_1 = texture{ pigment{ color rgb<1,0.65,0.45>*0.40} normal{ bumps 0.125 scale 0.05} finish{ phong 0.2}}
#declare Wheel_Texture_2 = texture{ pigment{ color rgb<0.9,0.57,0.50>*0.55} normal{ bumps 0.15 scale 0.0125} finish{ phong 0.1}} 
//-------------------------
#declare Gauge_ = 1.435; // 
//-------------------------------------------------------------------------------------// 
#include "RW_System/RW_Axis_11.inc" 
//-------------------------------------------------------------------------------------// 
object{ RW_Wheel_11(  1.20, // Wheel_Diameter___, // in meter
                      16,   // Number_Of_Spokes___, // 
                      0.25, // Connector_Radius___ // 0 or >wheel diameter/2 = non
                            // must be between:  < 0 and < 0.5 wheel diameter                    
                      0.15, // Counterweight_Depth___, //  0 = non,  < 0.5 wheel diameter 
                      Gauge_, // gauge in meter
                    ) // --------------------------------------------------------------//
        scale <1,1,1> 
        rotate<0,0,0.00> 
        translate<0.00,0.60, 0.00>
      } //
//-------------------------------------------------------------------------------------//
//-------------------------------------------------------------------------------------//
*/


#version RW_Axis_11_Inc_Temp;
#end
//------------------------------------- end of include file

