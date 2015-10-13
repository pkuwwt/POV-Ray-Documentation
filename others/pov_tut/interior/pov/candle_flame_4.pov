// PoVRay 3.7 Scene File "candle_flame_4.pov"
// author: Friedrich A. Lohmueller, Oct-2008/Aug-2009 / Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
global_settings{assumed_gamma 1.0} 
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"
//-------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle 
#declare Camera_Position = <10.0, 10.0,-10.0> ;  
#declare Camera_look_at = < 0.40, 1.80, 0.00>; 
#declare Camera_Angle = 12; // in degrees
//--------------------------------------------------------------------------------------------------------<<<<
camera{ /*ultra_wide_angle*/   // don't use fish eye - for proper text 
        location  Camera_Position
        right     x*image_width/image_height
        angle Camera_Angle   
        look_at   Camera_look_at
      }
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<200,2000,-1500> color White*0.15}           // sun light
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.05}  // flash light

// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         *0.2]//White
                                [0.4 color rgb<0.14,0.14,0.56>*0.2]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>*0.2]//~Navy
                                [1.0 color rgb<1,1,1>         *0.2]//White
                              }
                     scale 2 }
           } // end of sky_sphere 
//------------------------------------------------------------------------
 
// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.025;  
#declare RasterHalfLineZ = 0.025; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.55]
                          [0+HLine color rgbt<1,1,1,0>*0.55]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.55]
                          [1.000   color rgbt<1,1,1,0>*0.55]
                         } }
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*0.45}
                 } // finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------

          
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
#macro Candle_1( Shining__On,  // Light on, 0= off, >0 = intensity of candle light  
                 C__Height,    // Candle_Height, 
                 C__Intensity, // Candle_Intensity,  
                 C__Scale      // Candle_Flame_Scale
               ) // -----------------------------------
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
      emission    color rgb < 1.0, 0.75, 0.1>*1.75
      intervals 9  
      samples 1, 20
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
       emission color rgb < 1.0, 0.75, 0.1>*2.75
       intervals 3
       samples 32
       method 3
       aa_threshold 0.1 aa_level 5
       density {crackle  turbulence 0.3
                scale 0.75 translate<0,24,0>
                color_map {
                    [0 rgb 0]
                    [0.00 rgb 0]
                    [0.07 rgb 1]
                    [0.10 rgb 1]
                    [0.12 rgb 0]
                    [1.00 rgb 0]
                }
            } // end density
       density {spherical
                color_map {
                    [0 rgb 0]
                    [0.7 rgb 1]
                    [1 rgb 1]
                }
            } // end density
           scale <1,2.5,1>*0.5
       translate<0,0.01,0>
     }// end media
 
    }//end of interior 
   scale <1,1.5,1>*0.5
   hollow // !!!! 
  }
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
          } // ------
 // wick - Docht 
union{ 
  cylinder{<0,-0.5,0>,<0,0.10,0>,0.05 pigment{rgb 0}}
  cylinder{<0, 0.1,0>,<0,0.25,0>,0.05 pigment{rgb<1,0.2,0.1>*1.3}}
  scale C__Scale
  translate<0,C__Height,0>
 } // end wick
} 
// ---------------------------------------------------------------
// ---------------------------------------------------------------
// ---------------------------------------------------------------
union{ 
object{C__Candle}
object{C__Flame translate<0,0.5,0> scale 0.75 scale C__Scale  translate<0,C__Height+0.2,0> }
#if(Shining__On>0)
light_source { <0,0,0>          
               color rgb <0.8, 0.5, 0.2>*Shining__On   
               area_light            // kind of light source (Art der Lichtquelle)
               <0, 0, 0> <0, 0.25, 0> // lights spread out across this distance 
               1, 10                // total number of lights in grid  
               adaptive 3          // 0,1,2,3...
               jitter              // adds random softening of light
               translate<0,C__Height+0.45,0>
             } //---------------- end of area_light 
#end // of "#if(Shining__On>0)"
}
#end // ---------------------------------------------------- end of macro 
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------





//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
#declare Candle_Texture = 
  texture{ pigment{ rgb<1,1,0.95>*1.3}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.02}}
         } // end texture
#declare Candle_Wax_Liquid_Texture = 
  texture{ pigment{ rgbf<1,0.9,0.6,0.1>*1.3}
           normal { bumps 0.15 scale <0.05,0.1,0.05>*2} 
           finish { reflection {0.05}}
         } // end texture
// -----------------------------------------------------------
object{ Candle_1(  0.5, // Shining__On, , 0= off, >0 = intensity of candle light 
                   2.0, //  Candle_Height, relative to diameter (d=1) 
                   0.65,//  Candle_Intensity,  
                   0.9, // Candle_Flame_Scale
                 ) // -----------------------------------
    scale 1
    translate<0,0,0> 
    } // -----------------------------------------------------
// -----------------------------------------------------------
// -----------------------------------------------------------
object{ Candle_1(  0.75, // Shining__On,, 0= off, >0 = intensity of candle light 
                   1.00, //  Candle_Height, relative to diameter (d=1) 
                   0.65,//  Candle_Intensity,  
                   0.65, // Candle_Flame_Scale
                 ) // ------------------------
    scale 1.3
    translate<1,0,0.5> 
    } // -----------------------------------------------------
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
//--------------------------------------------------------------------------------
