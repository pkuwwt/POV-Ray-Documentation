// POV-Ray 3.6/3.7 include file "Wire_Netting_Fence_00.inc" 
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Wire_Netting_Fence_00_Inc_Temp)
#declare Wire_Netting_Fence_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------ a wire netting fence -----------------
//------------------------------------------------------------------------------ /////////  
#macro Wire_Netting_Fence_00  ( Fence___Width_X, // width of fence in x direction
                                Fence___Heigth_Y,// width of fence in y direction
                                Wire_Net___Width,  //  net width   
                                Wire_Net___Radius, //
                                Wire___Color       // color of the wire
                        ) //------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------
#macro WN_Raster_( Wire_Net___Width_, Wire_Net___Radius_, Wire___Color_) 
       pigment{ gradient x scale Wire_Net___Width_
                color_map{[0.000                 color rgb Wire___Color_]
                          [0+Wire_Net___Radius_  color rgb Wire___Color_]
                          [0+Wire_Net___Radius_  color rgbt<1,1,1,1>]
                          [1-Wire_Net___Radius_  color rgbt<1,1,1,1>]
                          [1-Wire_Net___Radius_  color rgb Wire___Color_]
                          [1.000                 color rgb Wire___Color_]} }
#end// of WN_Raster(...)-macro    
//---------------------------------------------------------------
#macro Clear___Grid_ (Wire_Net___Width__, Wire_Net___Radius__, Wire___Color__ )
 texture{ WN_Raster_(Wire_Net___Width__, Wire_Net___Radius__, Wire___Color__) rotate<0 ,45,0> rotate<90,0,0>} 
 texture{ WN_Raster_(Wire_Net___Width__, Wire_Net___Radius__, Wire___Color__) rotate<0,-45,0> rotate<90,0,0>}
#end //
//---------------------------------------------------------------

//------------------------------------------------------ the wire netting fence:
union{
// the wire net
box { <0,0,0>,< Fence___Width_X,Fence___Heigth_Y,0.001>           
      Clear___Grid_ ( Wire_Net___Width, Wire_Net___Radius, Wire___Color)
    }
// the lower wire
cylinder{ <0,0,0>,<Fence___Width_X,0,0>, Wire_Net___Radius*Wire_Net___Width 
          translate<0,Wire_Net___Radius*Wire_Net___Width,0>  pigment{color rgb  Wire___Color}} 
          
// the upper wire
cylinder{ <0,0,0>,<Fence___Width_X,0,0>, Wire_Net___Radius*Wire_Net___Width 
          translate<0,Fence___Heigth_Y-Wire_Net___Radius*Wire_Net___Width,0>  pigment{color rgb  Wire___Color}} 
} // end of union 
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------//
#include "Wire_Netting_Fence_00.inc" // a wire netting fence
//-------------------------------------
//global_settings { max_trace_level 10 }//(1...256) [default = 5] 
//---------------------------------------------------------------------------------------// 
object{ Wire_Netting_Fence_00(  2.00, // Fence_Width_X, // width of fence in x direction
                                1.50, // Fence_Heigth_Y,// width of fence in y direction
                                0.08, // Wire_Net_Width,  //  net width   
                                0.002,// Wire_Net_Radius, //
                                <1,1,1>*0.8 // Wire_Color // color of the wire
                              ) //-------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------//
//-----------------------------------------------------------------------------------------
*/


#version Wire_Netting_Fence_00_Inc_Temp;
#end
//------------------------------------- end of include file

