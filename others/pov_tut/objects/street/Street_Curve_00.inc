// POV-Ray 3.6/3.7 include file "Street_Curve_00.inc"
// created by Friedrich A, Lohmueller, Dec-2005
// update July-2013 for use with shapes3.inc, stripes length error corrected
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Street_Curve_00_Inc_Temp)
#declare Street_Curve_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(Colors_Inc_Temp)
#include "colors.inc"
#end
#ifndef(Textures_Inc_Temp)
#include "textures.inc"
#end
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//#ifndef(  Shapes_Lo_Inc_Temp)
//#include "shapes_lo.inc"
//#end
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"
#end

#ifndef(  Street_Texture )
#declare Street_Texture = 
      texture{ pigment{ color rgb<1,1,1>*0.3}
               normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture
#end
#ifndef( Stripes_Texture )
#declare Stripes_Texture = 
      texture{ pigment{ color rgb<1,1,1>*1.1}
             //normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.5}
             } // end of texture
#end

//------------------------------------------------------------------------------ /////////
#macro Street_Curve_00(  Street_Width,  // total width
                         Curve_Angle,   // degrees, right handed
                         Curve_Radius,  // 
                         Stripes_Width, // 
                         Stripes_Length  
                      ) //--------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.001;
//---------------------------------------------------------------------------------------
union{
//#macro Segment_of_CylinderRing ( R_out, R_in, Height, Segment_Angle)
object{  Segment_of_CylinderRing ( Curve_Radius+Street_Width/2, Curve_Radius-Street_Width/2 ,D, -Curve_Angle)   
         texture{Street_Texture} 
      }//----------------------------------------------------------
   // right line
   // left line
 #local circumference = 2*pi*Curve_Radius; 
 #local Total_Number_of_Stripes = int( circumference /(2*Stripes_Length));
 #local Number_of_Stripes = int( Total_Number_of_Stripes * Curve_Angle/360); 
 #local Stripes_Angle = Curve_Angle/Number_of_Stripes/2;
 
 #local Nr = 0;   // start
 #local EndNr = Number_of_Stripes; // end
 #while (Nr< EndNr) 
 // middle stripes
 object{ Segment_of_CylinderRing ( Curve_Radius+Stripes_Width/2, Curve_Radius-Stripes_Width/2 ,2*D, -Stripes_Angle)   
         texture{ Stripes_Texture }  
         rotate<0,-Nr*2*Stripes_Angle,0> 
       } // end of object 

 #local Nr = Nr + 1;    // next Nr
 #end // ---------------  end of loop 

translate<-Curve_Radius,0,0> 
} // end of union
// ------------------------------------------------------------------------------ ////////
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
/* 
// alternative declaration of textures
#declare Street_Texture = 
      texture{ pigment{ color rgb<1,1,1>*0.4}
               normal { bumps 0.25 scale 0.005}
               finish { diffuse 0.9 phong 0.1}
             } // end of texture
#end
#ifndef( Stripes_Texture )
#declare Stripes_Texture = 
      texture{ pigment{ color rgb<1,1,1>*1.1}
             //normal { bumps 0.5 scale 0.005}
               finish { diffuse 0.9 phong 0.5}
             } // end of texture
*/
//-------------------------------------------------------------------------------------// 
#include "Street_Curve_00.inc" 
//-------------------------------------------------------------------------------------// 
object{ Street_Curve_00( 4.00,  // Street_Widthm, // 
                         90,    // Curve_Angle,   // degrees
                         8.00,  // Curve_Radius,  // 
                         0.10,  // Stripes_Width, // 
                         1.00,  // Stripes_Length                                  
                      ) //-------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, -5.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------


*/


#version Street_Curve_00_Inc_Temp;
#end
//------------------------------------- end of include file

