// POV-Ray 3.6/3.7 include file "Battlements_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006 / May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Battlements_0_Inc_Temp)
#declare Battlements_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------


//------------------------------------------------------------------------------ /////////  
#macro Battlements_0 (   Wall__W, // half wall width in x                                
                         Wall__H, // wall heigth in y 
                         Wall__D, // wall deepth in z 
                         Balustrade_H, // tower balustrade high
                         Battlement__Wall_D,       // tower wall deepth 
                         Battlement__H,           // battlements height in y
                         Battlement__R,   // half battlements width in x or z 
                         Tween__Distance, //  >2*Battlement__R;  tween distance  
                         Wall_Texture___1, // outside texture
                         Wall_Texture___2  // battlements tween texture
                       ) //------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.0001; // just a little bit 
//------------------------------------------------------------- security checks  
 
#if (Tween__Distance <= 2*Battlement__R) #local Tween__Distance = 2*Battlement__R + D ; #end 

#local Number_of_Battlements = int(2*Wall__W /Tween__Distance ); 
#local Battlements_Distance = Tween__Distance; 

//------------------------------------------------------------- elements 

#local Battlements_Cut_Off =
box { <-Battlement__R,-Battlement__H,-D>,< Battlement__R,D,Battlement__Wall_D+D> 
      rotate<0,0,0> translate<0,0,0> 
    } // end of box

//-------------------------------------------------------------
//------------------------------------------------------------- construction
difference{ 
// wall base shape 
box { <-Wall__W,0,-0>,< Wall__W, Wall__H, Wall__D> 
      texture { Wall_Texture___1 } 
 
    } // end of box

// backside top level caved out 
box { <-Wall__W-D,-Balustrade_H, Battlement__Wall_D >,< Wall__W+D,  D, Wall__D+D> 
        translate<0,Wall__H,0> 
      texture { Wall_Texture___1 } 
    } // end of box

union{ //  union of the Battlements_Cut_Offs
 #local Nr = -Number_of_Battlements/2 ;     // start
 #local EndNr = Number_of_Battlements/2; // end
 #while (Nr< EndNr) 

  object{ Battlements_Cut_Off translate< Battlements_Distance*(Nr+0.5), 0,0>} 

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 


 translate<0,Wall__H,0> 
 texture { Wall_Texture___2 }  
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
#declare Wall_Texture_1 = // sand stone
         texture { pigment{ color rgb< 0.90, 0.78, 0.60>}
                   normal { pigment_pattern{ brick 
                                             color rgb 0.2, 
                                             color rgb 0.8 
                                             scale Brick_Scale 
                                             translate Brick_Translate
                                             rotate<0,0,0>} Brick_Intensity}
                   finish { diffuse 0.9 phong 0.1}
                 } // end of texture 
#declare Wall_Texture_2 = // sand stone
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
#include "Battlements_0.inc" 
//-------------------------------------------------------------------------------------// 


object{ Battlements_0(   3.00, // Wall__W, // half wall width in x                                
                         4.00, // Wall__H, // wall heigth in y 
                         1.20, // Wall__D, // wall deepth in z 
                         1.50, // Balustrade_H, // balustrade high
                         0.30, // Battlement__Wall_D, // battlement wall deepth 
                         0.80, // Battlement__H,    // battlements height in y
                         0.25, // Battlement__R,  // half battlements width in x or z 
                         1, // Tween__Distance, //  >2*Battlement__R;  tween distance 
                         Wall_Texture_1, // outside texture
                         Wall_Texture_2  // battlements tween texture
                       ) //------------------------------------------------------------// 
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Battlements_0_Inc_Temp;
#end
//------------------------------------- end of include file

