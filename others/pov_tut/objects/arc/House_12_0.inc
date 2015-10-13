// POV-Ray 3.6/3.7 include file "House_12_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006, update Feb-2007, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( House_12_0_Inc_Temp)
#declare House_12_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// needs also: 
// #include "Window_1.inc"                                             
// #include "Door_1.inc"                                             
// via following houses include files
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

#ifndef(  House_2_0_Inc_Temp)
#include "House_2_0.inc" 
#end
#ifndef(  House_1_0_Inc_Temp)
#include "House_1_0.inc" 
#end

//------------------------------------------------------------------------------ /////////  
#macro House_12_0 ( // main house: x = +/-2.80, h = 5.20, z = 7.50,
                    // side part : z = 4.60, x ~ 2.50, h = 4.70. 
                     Wall__Texture_Outside
                     Wall__Texture_Inside 
                     Window__Texture
                     Roof__Texture
                   )  //----------------------------------------------------------------//
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------// 
#local  H1_x = 2.30; 
#local  H1_xCut = H1_x/sqrt(2);
#local  H1_xCut_z = 4.40; 
//---------------------------------------------------------------------------------------
#local House_1_x =
difference{
object{ House_1_0(  H1_x, // Half_House_Width_X, // >= 2.00
                    4.50, // Total_House_Width_Z,// >= 2.00
                    4.70, // House_Height_Y,     // >= 2.00
                    45,   // Roof___Angle, // ca. 10 ~ 60 degrees
                    Wall__Texture_Outside
                    Wall__Texture_Inside 
                    Window__Texture
                    Roof__Texture
                   )} //----------------------------------------------------------------//
box{ <-10,0,0>,<10,8,6> 
        rotate<0,-45,0>  
        scale <1,1,1> 
     translate<0,0,H1_xCut_z>
     texture { Wall__Texture_Outside } 
       }
box{ <-6,0,0>,<6,8,6> 
        rotate<0, -45,0>  
        scale <-1,1,1> 
     translate<0,0,H1_xCut_z>
     texture { Wall__Texture_Outside } 
       }
translate<0,0,-H1_xCut_z>// +(H1_x+0.20)/sqrt(2)>
} // end of union 
//---------------------------------------------------------------------------------------

#local Cut_Position = <-2.80,0,7.50-2.40>;
#local House_2_z = 
//-------------------------------------------------------------------------------------// 
difference{ 
object{ House_2_0(  2.80, // Half_House_Width_X, // >= 2.00
                    7.50, // Total_House_Width_Z,// >= 2.00
                    5.20, // House_Height_Y,     // >= 2.00
                    45,   // Roof___Angle, // ca. 10 ~ 60 degrees
                      
                    Wall__Texture_Outside
                    Wall__Texture_Inside 
                    Window__Texture                                                    
                    Roof__Texture
                   ) //----------------------------------------------------------------//
     }
box{ <-H1_xCut-2,0,-H1_xCut-2>,<H1_xCut,5.5,H1_xCut> rotate<0,45,0> 
      translate Cut_Position
      texture { Wall__Texture_Outside } 
    } 
}// end of difference
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------- all together:
union{ 
 object{ House_2_z }
 object{ House_1_x  
        rotate<0,90,0> 
        translate Cut_Position +< H1_x-0.00,0,0>
       } 
}// end of union 
//---------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Wall_Texture_Outside = 
      texture { pigment{ color White*1.1}
                normal { bumps 0.5 scale 0.005} 
                finish { phong 1}
              } // end of texture
//----------------------------------------------------------------
#declare Wall_Texture_Inside = 
      texture { pigment{ color White*1.1}
                finish { phong 1}
              } // end of texture
//----------------------------------------------------------------
#declare Roof_Texture = 
// layered texture!!!
      texture { pigment{ color  rgb<0.8,0.30,0.2>*0.9} 
                normal { gradient z scallop_wave scale<1,1,0.15>} 
                finish { phong 1}
              } // end of texture
 
      texture { pigment{ gradient x 
                         color_map{[0.00 color Clear]
                                   [0.90 color Clear]
                                   [0.95 color White*0.1]
                                   [1.00 color White*0.1]}
                          scale 0.25}
                 finish { phong 1}
              } // end of texture
                                   
//---------------------------------------------------------------
#declare Window_Texture = 
         texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.35 } // brown  
                  // pigment{ color White*1.2}
                  finish { phong 0.1}}
//-------------------------------------------------------------------------------------// 
#include "House_12_0.inc"
//-------------------------------------------------------------------------------------// 
object{ House_12_0 ( // main house: x = +/-2.80, h = 5.20, z = 7.50,
                     // side part : z = 4.60, x ~ 2.50, h = 4.70. 
                     Wall_Texture_Outside
                     Wall_Texture_Inside 
                     Window_Texture
                     Roof_Texture
                   )  //----------------------------------------------------------------//
        rotate<0,-110,0>
        translate<5.00,0.00, 3.00>
      }   
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version House_12_0_Inc_Temp;
#end
//------------------------------------- end of include file

