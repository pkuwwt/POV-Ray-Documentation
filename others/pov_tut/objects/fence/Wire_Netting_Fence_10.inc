// POV-Ray 3.6/3.7 include file "Wire_Netting_Fence_10.inc"
// author: Friedrich A, Lohmueller, Oct-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Wire_Netting_Fence_10_Inc_Temp)
#declare Wire_Netting_Fence_10_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------ a wire netting fence -----------------
//------------------------------------------------------------------------------ /////////  
#macro Wire_Netting_Fence_10  ( Fence___Width_X, // width of fence in x direction
                                Fence___Heigth_Y,// width of fence in y direction
                                Wire_Net___Width,  //  net width   
                                Wire_Net___Radius, //
                                Wire___Color,      // color of the wire
                                Fence_Post___Radius,  // Zaunpfahl
                                Fence_Post___Texture
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
//---------------------------------------------------------------------------------------------
#local Fence___Post = cylinder{ <0,-0.50,0>,<0,Fence___Heigth_Y,0>,Fence_Post___Radius
                                texture{ Fence_Post___Texture}}
//---------------------------------------------------------------------------------------------

//------------------------------------------------------ the complete wire netting fence:
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

object{ Fence___Post translate<              0,0,-Fence_Post___Radius>} 
object{ Fence___Post translate<Fence___Width_X,0,-Fence_Post___Radius>} 
translate<0,0,Fence_Post___Radius> 
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
#declare Fence_Post_Texture = 
         texture { pigment{ color rgb< 1, 1, 1>*0.75 } 
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1}
                 } // end of texture 

//---------------------------------------------------------------------------------------//
#include "Wire_Netting_Fence_00.inc" // a wire netting fence
//-------------------------------------
//global_settings { max_trace_level 10 }//(1...256) [default = 5] 
//---------------------------------------------------------------------------------------// 
object{ Wire_Netting_Fence_00(  2.00, // Fence_Width_X, // width of fence in x direction
                                1.80, // Fence_Heigth_Y,// width of fence in y direction
                                0.079, // Wire_Net_Width,  //  net width   
                                0.08,  // Wire_Net_Radius, //
                                <1,1,1>*0.2, // Wire_Color // color of the wire
                                0.04, // Fence_Post___Radius,  // Zaunpfahl
                                Fence_Post_Texture // 
                              ) //-------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------//
//-----------------------------------------------------------------------------------------
*/


#version Wire_Netting_Fence_10_Inc_Temp;
#end
//------------------------------------- end of include file

