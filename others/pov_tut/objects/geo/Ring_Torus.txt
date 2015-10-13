// POV-Ray 3.6 / 3.7 include file "Ring_Torus.inc"
// author: Friedrich A, Lohmueller, Jan-2014
// Inspired by a proposal sent by Bruno Gimeno
// homepage: http://www.f-lohmueller.de/
//------------------------------------------------------------------------
#ifndef( Ring_Torus_Inc_Temp)
#declare Ring_Torus_Inc_Temp = version;
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

//--------------------------------------------------------------/////////
// -------------------------------------------------------------/////////
#macro Ring_Torus ( Major_Radius,
                    Minor_Radius,
                    Wire_Radius, 
                    Number_Rings_horizontal, Number_Rings_vertical,
                   ) //---------------------------------------------

#if( ( Number_Rings_vertical > 0 )|( Number_Rings_horizontal > 0 ) )

union{ // final union in macro
   #if( Number_Rings_vertical > 0 )
     #for (A,0,360,360/Number_Rings_vertical)
        object {
              torus {Minor_Radius,Wire_Radius}
              rotate z*90 
              translate z*Major_Radius 
              rotate y*A
               }
      #end // #end of Vertical torus loop
   #end // of "if( Number_Rings_vertical > 0 )"
   #if( Number_Rings_horizontal > 0 ) 
      #for (B,0,360,360/Number_Rings_horizontal)
        object {
              torus {Major_Radius+(Minor_Radius*cosd(B)),Wire_Radius}
              translate y*Minor_Radius*sind(B)
               }
      #end // #end of Horizontal torus loop
   #end // of "#if( Number_Rings_horizontal > 0 )"
      } // end of final union
#else
 #warning "There are no horizontal or vertical rings defined!"
 // just to avoid a fatal error!
 sphere{<0,0,0>,0.001 pigment{ color rgbf<1,1,1,1>}}// clear sphere 
#end // 

#end // --------------------------------------------- end of macro //////
//-----------------------------------------------------------------//////
//-----------------------------------------------------------------//////






//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example: 
/*
//----------------------------------------------------------------------------- textures
//-----------------------------------------------------------------//////
#include "shapes_lo2/Ring_Torus.inc" 
//-----------------------------------------------------------------//////
object{ Ring_Torus (3.00, 1.00, 0.025, // R_major, R_minor, R_Wire,
                     24, 0 // Number_Rings_horizontal, Number_Rings_vertical
                   ) //-----------------------------------------------------
        //texture{ Polished_Chrome } 
        pigment {Red} finish {phong .5 reflection .75}
        translate<0,1.125,0>  
      }
object{ Ring_Torus (3,1.125,0.100,0,36)  
        texture{ Polished_Chrome } 
                //pigment {Red} finish {phong .5 reflection .75}
        
        translate<0,1.125,0>  
      }
//-----------------------------------------------------------------//////
// example 2:
//-----------------------------------------------------------------//////
#include "shapes_lo2/Ring_Torus.inc" 
//-----------------------------------------------------------------//////
object{ Ring_Torus (3.00, 1.00, 0.05, // R_major, R_minor, R_Wire,
                     24, 36 // Number_Rings_horizontal, Number_Rings_vertical
                   ) //-----------------------------------------------------
        texture{ Polished_Chrome } 
        translate<0,1.05,0>  
      }
//-----------------------------------------------------------------//////


//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Ring_Torus_Inc_Temp;
#end
//------------------------------------- end of include file

