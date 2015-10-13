// POV-Ray 3.6/3.7  include file "Candle_1.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller, Oct-2008
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//----------------------------------------------------------------------------------------
#ifndef( Candle_1_Inc_Temp)
#declare Candle_1_Inc_Temp = version;
#version 3.6;
//----------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
// -----------------------------------------------------------
#macro Candle_1 ( Shining__On,  // Light on 
                  C__Height,    // Candle_Height, 
                  C__Intensity, // Candle_Intensity,  
                  C__Scale      // Candle_Flame_Scale
                ) // -----------------------------------------
// -----------------------------------------------------------
#ifndef( Candle_Texture )
#declare Candle_Texture
  texture{ pigment{ rgb<1,1,0.95>*1.2}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.02}}
         } // end texture
#end //  
#ifndef( Candle_Wax_Liquid_Texture )
#declare Candle_Wax_Liquid_Texture = 
  texture{ pigment{ rgbf<1,0.9,0.7,0.1>*1.3}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.02}}
         } // end texture
#end // 

// ---------------------------------------------------------------


#local D = 0.00001;
// ---------------------------------------------------------------
#local Flame__Shape = 
merge{    // egg 
intersection{
   sphere{<0,0,0>,1}  box{<-1,-D,-1>,< 1,1  ,1>} scale <1,2.5,1>}
intersection{
   sphere{<0,0,0>,1}  box{<-1,-1 ,-1>,< 1,0+0.01,1>} }
}//- ------------------------------------------------
// ---------------------------------------------------------------


#local C__Flame =
object{
  
  Flame__Shape
  hollow
  pigment { color rgbf<1, 1, 1, 1> } // fully transparent !!!
  finish { ambient 0 diffuse 0 }
  interior { 
    media {
      emission    color rgb < 1.0, 0.75, 0.1>*1.75*C__Intensity
      intervals 9*1/C__Scale  
      examples 5, 20
      confidence 0.9999
      variance 1/100
      density{ spherical
               ramp_wave 
               turbulence 0.15
               color_map {
                  [0.0 color rgb <0.0, 0.0, 0.0>]
                  [0.6 color rgb <0.8, 0.3, 0.0>]
                  [0.9 color rgb <1.0, 0.8, 0.3>]
                  [1.0 color rgb <1.0, 1.0, 0.1>]
               } 
               scale <1,2.5,1>
             } // end density
     }//end of media
 
    media {
      emission color rgb < 1.0, 0.75, 0.1>*3.75*C__Intensity
      intervals 5 
      examples 30,50
      method 3
      aa_threshold 0.1 aa_level 5
      density{ crackle  turbulence 0.3
               scale 1.75 translate<0,14,0>
               color_map {
                  [0.00 rgb 0]
                  [0.07 rgb 1]
                  [0.10 rgb 1]
                  [0.12 rgb 0]
                  [1.00 rgb 0]
               }
             } // end density
      density{ spherical
               color_map {
                  [0 rgb 0]
                  [0.7 rgb 1]
                  [1 rgb 1]
               }
             } // end density
           scale <1,1.5,1>*0.5
       translate<0,0.01,0>
     }// end media
 
 }//end of interior 
 scale <1,1.5,1>*0.5

} // end Flame__Shape
// ---------------------------------------------------------------
// ---------------------------------------------------------------
#local C__Candle =
union{ 
difference{
  union{ 
   cylinder{ <0,0,0>,<0,C__Height,0>,0.5}
   sphere{<0,0,0>, 0.5  scale<1,0.35,1>  translate<0,C__Height,0> }
   texture { Candle_Texture }

  }
  sphere{<0,0,0>,0.455 scale<1,0.5,1> translate<0,C__Height+0.05,0>
    texture{ Candle_Wax_Liquid_Texture   } 
  }
} // end difference

 // wax lake 
 cylinder { <0,0,0>,<0,C__Height-0.075,0>,0.45 
            texture{ Candle_Wax_Liquid_Texture    } 
  }
 // wick - Docht 
union{ 
  cylinder{<0,-0.5,0>,<0,0.10,0>,0.05 pigment{rgb 0}}
  cylinder{<0, 0.1,0>,<0,0.25,0>,0.05 pigment{rgb<1,0.2,0.1>*1.3}}
  scale C__Scale
  translate<0,C__Height,0>
 } // end wick
} // end C__Candle
// ---------------------------------------------------------------
// ---------------------------------------------------------------
// ---------------------------------------------------------------
union{ 
object{C__Candle}
object{C__Flame translate<0,0.5,0> scale 0.75 
       scale C__Scale  translate<0,C__Height+0.15,0> }
// shining of the flame
#if(Shining__On>0)
light_source { <0,0,0>          
               color rgb <0.8, 0.3, 0.0>*Shining__On   
               translate<0,C__Height+0.25,0>
             } //---------------- end of area_light 
#end // of "#if(Shining__On>0)"
}// end union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example: 
/*
//----------------------------------------------------------------------------- textures
// optional texture declarations -------------------------------------------------------
#declare Candle_Texture = 
  texture{ pigment{ rgb<1,1,0.95>*1.3}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.02}}
         } // end texture
#declare Candle_Wax_Liquid_Texture = 
  texture{ pigment{ rgbf<1,0.9,0.6,0.05>*1.3}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.15}}
         } // end texture
// -------------------------------------------------------------------------------------
#include "Candle_1.inc"
// -------------------------------------------------------------------------------------
object{ Candle_1( 0.5,  // Shining_On, 0= off, >0 = intensity of candle light 
                  1.0,  // Candle_Height, relative to diameter (d=1) 
                  1.2,  // Candle_Intensity,  
                  0.7   // Candle_Flame_Scale
                ) // -------------------------
        scale 1
        rotate<0,0,0>
        translate<0.55,0,0> 
      } // ------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Candle_1_Inc_Temp;
#end
//------------------------------------- end of include file

