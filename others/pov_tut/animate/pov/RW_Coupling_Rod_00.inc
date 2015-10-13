// POV-Ray 3.6/3.7 include file "RW_Coupling_Rod_00.inc"
// author: Friedrich A, Lohmueller, Aug-2012
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RW_Coupling_Rod_00_Inc_Temp)
#declare RW_Coupling_Rod_00_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
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
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
#macro RW_Coupling_Rod_00 (  Rod_Len,// coupling rod length in x+ from link to link                               
                             Rod_H,  // height in y+/- of rod
                             Rod_D,  // depth in -z // 
                             Rod_End_R,     // radius of the end links, >Rod_H/2 !!!
                             Oil_Fillers_On, // 0 = non, 1= On 
                          ) //----------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#ifndef (Rod_Metal_1)
#declare Rod_Metal_1 =  texture{pigment{ rgb<1,1,1>*0.55} finish {phong 0.2 reflection{ 0.3 metallic}}} 
#end
#ifndef (Rod_Metal_2)
#declare Rod_Metal_2 =  texture{pigment{ rgb<1,1,1>*0.45} finish {phong 0.2 reflection{ 0.25 metallic}}} 
#end
#ifndef (Rod_Texture_1)
#declare Rod_Texture_1 = texture{ pigment{ color rgb<1,0.65,0.45>*0.40} normal{ bumps 0.125 scale 0.05} finish{ phong 0.2}}
#end
//---------------------------------------------------------------------------------------
#local D = 0.00001;
// --------------------------------------------------------------------------------------
#local Screw_1 = 
 object{ Hexagon 
        rotate<0,0,-90>
        scale <1,0.5,1>*Rod_D/4 translate<0,0.005,0>
        texture{ Rod_Metal_2 }
        scale <1,1,1>*1.00 rotate<0,40,0> translate<0,0,0>
       } // end of  Hexagon 
// ------------------------------
#local Oil_Filler = 
union{ 
 difference{                                                                                     
   box{ <-Rod_End_R*0.75,Rod_End_R*0.4,-Rod_D*0.85>,<Rod_End_R*0.75,Rod_End_R*1.25,-Rod_D*0.15>  }
   cylinder{<0,0,-Rod_D>,<0,0,0>,0.7*Rod_End_R  translate< 1.05*Rod_End_R,Rod_End_R*1.25,0>}  
   cylinder{<0,0,-Rod_D>,<0,0,0>,0.7*Rod_End_R  translate<-1.05*Rod_End_R,Rod_End_R*1.25,0>}  
   texture{Rod_Metal_1 }
 } // end difference 

 object{ Screw_1 translate<0,Rod_End_R*1.25,-Rod_D/2> } 
} // end union 
// ------------------------------
#local End_Link = 
union{ 
 object { Round_Cylinder(<0,0,-Rod_D>,<0,0,0>,Rod_End_R, 0.0075, 0)     texture{Rod_Metal_1 }  } 
 object { Round_Cylinder(<0,0,-Rod_D>,<0,0,0>,Rod_End_R*0.7, 0.0075, 0) texture{Rod_Metal_2 }  translate< 0,0,-Rod_D*0.1>  } 
 cylinder{<0,0,-Rod_D>,<0,0,0>,Rod_End_R*0.5  texture{Rod_Texture_1}                           translate< 0,0,-Rod_D*0.125> } 
 #if( Oil_Fillers_On = 1 ) 
 object{ Oil_Filler } 
 #end // of "#if( Oil_Fillers_On = 1 )" 
} // end union 
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
union{ // final union in macro

 // linear part
 difference{ 
     box{ <0,-Rod_H/2,-Rod_D>,<Rod_Len, Rod_H/2,0>  texture{Rod_Metal_1} } 
       //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
     object{ Round_Cylinder(<Rod_End_R*1.1/2,0,0>,<Rod_Len/2-(Rod_End_R*1.1/2),0,0>, 0.5 , 0.1,   0)  
             scale<2,Rod_H*0.6,Rod_D/4>  texture{Rod_Texture_1}  translate <0,0,-Rod_D>} 
  }// end  linear part

 // end cylinder links
  //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
 object { End_Link translate<      0,0,0> } 
 object { End_Link translate<Rod_Len,0,0> } 

 
} // end of final union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  



//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
//#declare Rod_Metal_1 =  texture{pigment{ rgb<1,1,1>*0.5} finish {phong 0.2 reflection{ 0.3 metallic}}} 
//#declare Rod_Metal_2 =  texture{pigment{ rgb<1,1,1>*0.45} finish {phong 0.2 reflection{ 0.25 metallic}}} 
#declare Rod_Texture_1 = texture{ pigment{ color rgb<1,1,1>*0.05} normal{ bumps 0.125 scale 0.05} finish{ phong 0.2}}
//---------------------------------------------------------------------------------------
#include "RW_System/RW_Coupling_Rod_00.inc" 
//-------------------------------------------------------------------------------------// 
object{ RW_Coupling_Rod_00( 1.50, // Rod_Len,  // coupling rod length in x+ from link to link                               
                                   0.15, // Rod_H,  // height in y+/- of rod
                                   0.07, // Rod_D,  // depth in -z // 
                                   0.25, // Rod_End_R // radius of the end links, >Rod_H/2 !!!  
                                   1,    // Oil_Fillers_On // 0 = non, 1= On 
                                  ) //-------------------------------------
                   ) //----------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.50, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version RW_Coupling_Rod_00_Inc_Temp;
#end
//------------------------------------- end of include file

