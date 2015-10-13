// POV-Ray 3.6/3.7  include file "Candle_2.inc"                                                                                                                                 // author: Friedrich A, Lohmueller, Aug-2009
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
// modified version of "Candle_1.inc" 
// with some improvements by Thierry Banel 
//----------------------------------------------------------------------------------------
#ifndef( Candle_2_Inc_Temp)
#declare Candle_2_Inc_Temp = version;
#version 3.6;

#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
//----------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
// -----------------------------------------------------------
#macro Candle_2 ( Shining__On,  // Light on 
                  Flame_Shadow, // 1 = on ; 0 = off
                  C__Height,    // Candle_Height, 
                  C__Intensity, // Candle_Intensity,  
                  C__Scale,      // Candle_Flame_Scale
                  Fade_Distance, //  3 ~ 5    
                  Fade_Power //   2,3,4
                ) // -----------------------------------------
// -----------------------------------------------------------
#ifndef( Candle_Texture )
#declare Candle_Texture = 
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
  #if( Flame_Shadow = 0)
  no_shadow 
  #end
  pigment { color rgbf<1, 1, 1, 1> } // fully transparent !!!
  finish { ambient 0 diffuse 0 }
  interior { 
    media {
  #if( Flame_Shadow > 0)
       absorption rgb< 0.51, 0.85, 0.95>*5*Flame_Shadow
  #end
      emission    color rgb < 1.0, 0.85, 0.1>*2.75*C__Intensity
      intervals 9*1/C__Scale  
      samples 5, 20
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
      emission color rgb < 1.0, 0.8, 0.1>*2.75*C__Intensity
      intervals 5 
      samples 30,50
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
   object{Round_Cylinder(<0,0,0>, <0,C__Height+0.02,0>, 0.5, 0.02, 0)} 
   // cylinder{ <0,0,0>,<0,C__Height,0>,0.5}
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
               color rgb <0.8, 0.3, 0.0>*0.5*Shining__On   
               area_light            // kind of light source (Art der Lichtquelle)
               <-0.25, -0.25, 0> <0.25, 0.5, 0> // lights spread out across this distance (x * z)
               4, 15                // total number of lights in grid (4x*4z = 16 lights)
               adaptive 1          // 0,1,2,3...
               //jitter              // adds random softening of light
               translate<0,C__Height+0.25+0.350,0>
  fade_distance Fade_Distance  // 3
  fade_power Fade_Power // 4
             } //---------------- end of area_light 

light_source { <0,0,0>          
               color rgb <0.8, 0.3, 0.0>*0.5*Shining__On   
               area_light            // kind of light source (Art der Lichtquelle)
               <0, -0.25,-0.25> <0, 0.5, 0.25> // lights spread out across this distance (x * z)
               4, 15                // total number of lights in grid (4x*4z = 16 lights)
               adaptive 1          // 0,1,2,3...
               //jitter              // adds random softening of light
               translate<0,C__Height+0.25+0.350,0>
  fade_distance  Fade_Distance  // 3
  fade_power Fade_Power // 4
             } //---------------- end of area_light 


#end // of "#if(Shining__On>0)"


}// end union
// ----------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------ optional textures
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
#include "Candle_2.inc"
// -------------------------------------------------------------------------------------
object{ Candle_2( 0.5,  // Shining_On, 0= off, >0 = intensity of candle light 
                  0, // Flame_Shadow, // >0 = intensity ; 0 = off
                  1.0,  // Candle_Height, relative to diameter (d=1) 
                  1.2,  // Candle_Intensity,  
                  0.7   // Candle_Flame_Scale
                  4, // Fade_Distance, //  3 ~ 5    
                  3 // Fade_Power //   2,3,4
                 ) // -------------------------
        scale 1
        rotate<0,0,0>
        translate<0.55,0,0> 
      } // ------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Candle_2_Inc_Temp;
#end
//------------------------------------- end of include file


