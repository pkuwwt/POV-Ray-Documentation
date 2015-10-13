// POV-Ray 3.6/3.7 include file "Pyramid_0.inc"
// author: Friedrich A, Lohmueller, March-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Pyramid_0_Inc_Temp)
#declare Pyramid_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
#macro Pyramid_0 ( Top___Width,      // = 1.00; // half width at the top                                  
                   Base___Width,     // = 3.00; // half width at the base
                   Total___Height,   // = 3.00; // total height of the pyramid
                   Number_of___Steps,// = 8;    // number of steps
                   Pyramid___Texture_xz,// pyramid texture in x and z
                   Pyramid___Texture_y  // pyramid texture in y
                 ) //------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.00001;
//---------------------------------------------------------------------------------------
#local Step___Height = Total___Height/Number_of___Steps;
#local Step___Width  = (Base___Width-Top___Width)/(Number_of___Steps-1);
//---------------------------------------------------------------------------------------

union{
 #local Nr = 0;     // start
 #local EndNr = Number_of___Steps; // end
 #while (Nr< EndNr) 
   #local P___Width = Base___Width-Step___Width*Nr; 
   #local P___Height = Step___Height; 
   
   union{ // inner union 
     //---------------------------------------------------------- visible in x and z
     box{ <-P___Width, 0.00+D, -P___Width>,< P___Width, P___Height-D, P___Width>  
          texture{ Pyramid___Texture_xz } // pyramid texture in x and z 
         } // end of box 
     //----------------------------------------------------------------- visible in y
     box{ <-P___Width+D, 0.00, -P___Width+D>,< P___Width-D, P___Height, P___Width-D>  
          texture{ Pyramid___Texture_y } // pyramid texture in y 
         } // end of box 
     //------------------------------------------------------------------------------
  
     translate<0,Total___Height-(EndNr-Nr)*Step___Height,0>
   } // end of inner union 

 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 


} // end of union //---------------------------------------------------------------------


// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
#declare Pyramid_Texture_1 = 
 texture{ pigment{ color rgb <1.00, 0.87, 0.73>} // ~ LightWood
          finish { diffuse 0.8  phong 1 reflection 0.00}
        } // end of texture
#declare Pyramid_Texture_2 = 
 texture{ pigment{ color rgb <1.00, 0.87, 0.73>} // ~ LightWood light
          finish { diffuse 0.9  phong 1 reflection 0.00}
        } // end of texture
//---------------------------------------------------------------------------------------
#include "Pyramid_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ Pyramid_0 ( 1.00, // half width at the top                                  
                    3.00, // half width at the base
                    3.00, // total height of the pyramid
                    8,    // number of steps
                    Pyramid_Texture_1, // pyramid texture in x and z
                    Pyramid_Texture_2  // pyramid texture in x and z
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Pyramid_0_Inc_Temp;
#end
//------------------------------------- end of include file

