// POV-Ray 3.6 include file "RW_Axis_10.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller, March-2011
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RW_Axis_10_Inc_Temp)
#declare RW_Axis_10_Inc_Temp = version;
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
#macro RW_Axis_10(  Wheel_Diameter___, // in meter
                    Number_Of_Spokes___, // 
                    Add_Connector_And_Counterweight__, 
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
#ifndef (           RW_Wheel_10_Inc_Temp )
#include "RW_System/RW_Wheel_10.inc"
#end
//------------------------------------------------------------------------
#local Wheel = 
 object{ RW_Wheel_10( Wheel_Diameter___, // in meter
                      Number_Of_Spokes___, // 
                      Add_Connector_And_Counterweight__  // Connector with "1" at x+ with 0.5*wheel radius ; without 0 or else
                    )} //-------------------------------------------------      
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
//----------------------------------------------------------------------------- textures
//------------------------------------------------------------------------ 
#include "RW_System/RW_Axis_10.inc"
//------------------------------------------------------------------------ 
union{ 
 object{ RW_Axis_10( 1.00,  // wheel diameter in meter
                     16,    // Number_Of_Spokes 
                     1   // Add_Connector_And_Counterweight__,  // Connector with "1" at x+ with 0.5*wheel radius ; without 0 or else
                     1.435, //   gauge in meter
                   
                   ) //---------------------------------------------------     

 translate<0.00,0.50, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RW_Axis_10_Inc_Temp;
#end
//------------------------------------- end of include file

