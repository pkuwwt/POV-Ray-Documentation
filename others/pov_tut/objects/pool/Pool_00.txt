// POV-Ray 3.6/3.7 include file "Pool_00.inc"
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Pool_00_Inc_Temp)
#declare Pool_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
/*
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
#ifndef(  Shapes_Lo_Inc_Temp)
#include "shapes_lo.inc"                                             
#end
*/

//------------------------------------------------------------------------------ /////////  
//---------------------------------------------------------//
#macro Pool_00 ( Pool_X, // width in x
                 Pool_Z, // width in z 
                 Pool_Border_Width, // >0
                 Pool_Border_Height, // >0
                 Pool_Depth_Y,       // negativ value!  
                 Pool_Border_Texture_, // 
                 Pool_Water_Texture_//
               ) 
//---------------------------------------------------------//
#local D = 0.0001; 
//---------------------------------------------------------//
union{ 
  // pool border
  difference{ 
  box { <       -Pool_Border_Width, Pool_Depth_Y-0.10,        -Pool_Border_Width>,
        < Pool_X+Pool_Border_Width, Pool_Border_Height, Pool_Z+Pool_Border_Width>}   
  box { <     -0, Pool_Depth_Y,            0>,
        < Pool_X, Pool_Border_Height+D, Pool_Z>}   
      scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
      texture { Pool_Border_Texture_ }  
    } // end of difference --------------------------------------
  // pool water

  box { <     -0, Pool_Depth_Y-D,            0>,
        < Pool_X, D, Pool_Z>}   
      texture { Pool_Water_Texture_ }  


} // end of union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-------------------------------------------------- pool textures
//---------------------------------------------------------//
#declare  Pool_Border_Texture = 
       texture{ pigment{ color rgb <1.00, 1.00, 1.00>*1.1} 
                normal { agate 0.5 scale 0.15 rotate<0,0,0> }
                 finish { phong 1 } 
                rotate<0,0,0> scale 0.25 translate<0,0,0>
              } // end of texture 

#declare Pool_Water_Texture =
         texture { Polished_Chrome
                   normal { bumps 0.15 scale 0.25} 
                   finish { reflection 0.65 } 
                 } // end of texture 
//---------------------------------------------------------//
#include "Pool_00.inc" 
//---------------------------------------------------------// 
object{ Pool_00( 4.00, // width in x
                 6.00, // width in z 
                 0.50, // >0,  Pool_Border_Width,  
                 0.15, // Pool_Border_Height, // >0
                 -1.50, // Pool_Depth_Y, // negativ value!  
                 Pool_Border_Texture, // 
                 Pool_Water_Texture //
               ) 
    scale <1,1,1> 
    rotate<0,0,0> 
    translate<0,0,0>  
 } // end of object "Pool_00" -----------------------------//
//---------------------------------------------------------//
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Pool_00_Inc_Temp;
#end
//------------------------------------- end of include file

