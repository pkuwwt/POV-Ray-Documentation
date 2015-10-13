// POV-Ray 3.6/ 3.7 include file "Tower_Squared_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Tower_Squared_0_Inc_Temp)
#declare Tower_Squared_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------


//------------------------------------------------------------------------------ /////////  
#macro Tower_Squared_0 ( Tower__R, // half tower width in x and z                                
                         Tower__H, // tower heigth in y 
                         Tower__Balustrade_H, // tower balustrade high
                         Tower__Wall_D,       // tower wall deepth 
                         Battlements__H,    // battlements height in y
                         Battlements__R,   // half battlements width in x or z 
                         Tower_Texture___1, // outside texture
                         Tower_Texture___2  // battlements tween texture
                       ) //------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.0001; // just a little bit 
//------------------------------------------------------------- security checks  
 
#if (Tower__R < Tower__Wall_D) #local Tower__R = Tower__Wall_D + D ; #end 
#if (Battlements__R < Tower__R/8) #local Battlements__R = Tower__R/8 - D ; #end 
#if (Tower__H < Battlements__H) #local Battlements__H = Tower__H - D ; #end 


//------------------------------------------------------------- elements 

#local Battlements_Cut_Off =
box { <-Battlements__R,-Battlements__H,-Tower__R-D>,< Battlements__R,D,Tower__R+D> 
      rotate<0,0,0> translate<0,0,0> 
    } // end of box

//-------------------------------------------------------------
//------------------------------------------------------------- construction
difference{ 
// tower base shape 
box { <-Tower__R,0,-Tower__R>,< Tower__R, Tower__H, Tower__R> 
      texture { Tower_Texture___1 } 
      scale <1,1,1> rotate<0,0,0> translate<0,0,0> 
    } // end of box

// inside top level caved out 
box { <-Tower__R+Tower__Wall_D,-Tower__Balustrade_H,-Tower__R+Tower__Wall_D>,
      < Tower__R-Tower__Wall_D,                   D, Tower__R-Tower__Wall_D> 
      scale <1,1,1> rotate<0,0,0> translate<0,Tower__H,0> 
      texture { Tower_Texture___1 } 
    } // end of box

union{ //  union of the Battlements_Cut_Offs
  object{ Battlements_Cut_Off translate<-2*Tower__R/4,0,0> rotate<0,0,0>}  
  object{ Battlements_Cut_Off translate< 0*Tower__R/4,0,0> rotate<0,0,0>}
  object{ Battlements_Cut_Off translate< 2*Tower__R/4,0,0> rotate<0,0,0>}
  object{ Battlements_Cut_Off translate<-2*Tower__R/4,0,0> rotate<0,90,0>}  
  object{ Battlements_Cut_Off translate< 0*Tower__R/4,0,0> rotate<0,90,0>}
  object{ Battlements_Cut_Off translate< 2*Tower__R/4,0,0> rotate<0,90,0>}

  translate<0,Tower__H,0> 
  texture { Tower_Texture___2 }  
} // end of union of the Battlements_Cut_Offs 

}// end of difference
//-------------------------------------------------------------
//-------------------------------------------------------------
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Brick_Scale     = 0.066*3; 
#declare Brick_Translate = <0,-0.08,-0.12>*3;
#declare Brick_Intensity = 0.35; 
//------------------------------------------------------------- textures
#declare Tower_Texture_1 = // sand stone
         texture { pigment{ color rgb< 0.90, 0.78, 0.60>}
                   normal { pigment_pattern{ brick 
                                             color rgb 0.2, 
                                             color rgb 0.8 
                                             scale Brick_Scale 
                                             translate Brick_Translate
                                             rotate<0,0,0>} Brick_Intensity}
                   finish { diffuse 0.9 phong 0.1}
                 } // end of texture 
#declare Tower_Texture_2 = // sand stone
         texture { pigment{ color rgb< 0.90, 0.78, 0.60>*0.95}
                            // color rgb< 0.4,1,0.0>} // test_color
                   normal { pigment_pattern{ brick 
                                             color rgb 0.2, 
                                             color rgb 0.8 
                                             scale Brick_Scale
                                             translate Brick_Translate
                                             rotate<0,90,0>} Brick_Intensity}
                   finish { diffuse 0.9 phong 0.1}
                 } // end of texture 
//---------------------------------------------------------------------------------------
#include "Tower_Squared_0.inc" 
//-------------------------------------------------------------------------------------// 

#local Tower_R = 2.00; // half tower width in x and z 
#local Tower_H = 8.00; // tower heigth in y 
#local Tower_Balustrade_H = 1.50; // tower balustrade high
#local Tower_Wall_D = 0.30; // tower wall deepth 

#local Battlements_H = 0.80; // Battlements height in y 
#local Battlements_R = Tower_R/8; // half Battlements width in x or z 

object{ Tower_Squared_0( 2.00, // Tower_R, // half tower width in x and z                                
                         8.00, // Tower_H, // tower heigth in y 
                         1.50, // Tower_Balustrade_H, // tower balustrade high
                         0.30, // Tower_Wall_D,       // tower wall deepth 
                         0.80, // Battlements_H,    // battlements height in y
                         0.25, // Battlements_R,   // half battlements width in x or z 
                         Tower_Texture_1, // outside texture
                         Tower_Texture_2  // battlements tween texture
                       ) //------------------------------------------------------------// 
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Tower_Squared_0_Inc_Temp;
#end
//------------------------------------- end of include file

