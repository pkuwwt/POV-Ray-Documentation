// POV-Ray 3.6 Scene File "spline_fly1.pov"
// created by Friedrich A. Lohmueller, 2003 
// Demonstrates the Spline_Trans macro of Rune S. Johansen
//------------------------------------------------------------------------
#version 3.6;
global_settings {  assumed_gamma 1.0 }
//------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"

#include "transforms.inc"
//------------------------------------------------------------------------
#declare Camera_1 = camera { 
                             angle 15
                             location  <14.0 , 20.0 ,-20.0>
                             right     x*image_width/image_height
                             look_at   <0.8 , 2.5 , 0.0>
                           }
camera{Camera_1}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<-1000,2500,-2500> color White}
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere 
//------------------------------------------------------------------------

//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
#macro Axis( AxisLen, Dark_Texture,Light_Texture) 
 union{
    cylinder { <0,-AxisLen,0>,<0,AxisLen,0>,0.05
               texture{checker texture{Dark_Texture } 
                               texture{Light_Texture}
                       translate<0.1,0,0.1>}
             }
    cone{<0,AxisLen,0>,0.2,<0,AxisLen+0.7,0>,0
          texture{Dark_Texture}
         }
     } // end of union                   
#end // of macro "Axis()"
//------------------------------------------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, Tex_Dark, Tex_Light)
//--------------------- drawing of 3 Axes --------------------------------
union{
#if (AxisLenX != 0)
 object { Axis(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark} 
          scale 0.5 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
           scale 0.5 translate <-0.3,AxisLenY+0.50,-0.10>}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.35,0.2,AxisLenZ+0.10>}
#end // of #if 
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{color rgb<1,0.35,0>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{color rgb<1,1,1>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }

object{ AxisXYZ( 4.5, 5.4, 6, Texture_A_Dark, Texture_A_Light)}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.025;  
#declare RasterHalfLineZ = 0.025; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<0,0,0,0>]
                          [0+HLine color rgbt<0,0,0,0>]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<0,0,0,0>]
                          [1.000   color rgbt<0,0,0,0>]} }
       finish { ambient 0.15 diffuse 0.85}
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squered plane XZ

//--------------------------------------------------------------------------
//---------------------------   scenery objects  ---------------------------
//--------------------------------------------------------------------------
//#declare MyArray = array[10]
#declare N = 10;

#declare P = array[10];// start with zero!

#declare P[0] = <-1.70, 0.25, -2.00>; 
#declare P[1] = <-1.00, 0.15, -1.80>;
#declare P[2] = <-0.50, 0.10, -1.00>;
#declare P[3] = < 0.50, 0.10, -1.00>;
#declare P[4] = < 1.00, 0.45, -2.00>;

#declare P[5] = < 2.00, 0.75, -1.00>;
#declare P[6] = < 2.00, 1.25,  2.00>;
#declare P[7] = < 0.00, 0.15,  2.00>;
#declare P[8] = <-2.00, 3.25,  1.50>;
#declare P[9]= <-2.00, 0.75, -1.00>;

#declare Spline_1 =
  spline {
    natural_spline
   -0.200, P[8],
   -0.050, P[9],
    0.000, P[0], // start
    0.050, P[1], 
    0.100, P[2], 
    0.170, P[3], 
    0.220, P[4],

    0.300, P[5],
    0.490, P[6],
    0.580, P[7],
    0.800, P[8],
    0.950, P[9],
    1.000, P[0], // end at start
    1.050, P[1]
    1.100, P[2]
  }

//----------------------------------------------- the spline curve ----------

union{
 #declare Nr = 0;     // start
 #declare EndNr = 1; // end
 #while (Nr< EndNr) 

 sphere{ <0,0,0>,0.05
	 texture{ pigment{color rgb <1-2*Nr/3,0.75+Nr/4,0>}
	          finish {ambient 0.15 diffuse 0.85 phong 1}
                }
         translate Spline_1(Nr) 
       } // end of sphere
 cylinder { <0,0,0>,<0,-Spline_1(Nr).y,0>,0.01 
           texture { pigment { color rgb<0.40,0.25,0.15>}
                     normal  { bumps 0.5 scale <0.005,0.25,0.005>}
                     finish  { ambient 0.15 diffuse 0.85 phong 0.5}
                   } // end of texture
           translate Spline_1(Nr) 
         } // end of cylinder

 #declare Nr = Nr + 0.005;  // next Nr
 #end // --------------- end of loop 
} // end of union  -----------------------------------------------------------

//----------------------------------------------------------------------------
#declare Jet =                 //---------------------------------------------
union{
cone { <0,0,0>,0.5,<0,0,1.20,>,0 
       texture { pigment{color Silver}
                 finish {ambient 0.05 diffuse 0.85 phong 1}
               } // end of texture
       scale <1,0.1,1> rotate<0,0,0> translate<0,0,0>         
     } // end of cone -------------------------------------------
cone { <0,0,0>,0.05<0,0,-0.30>,0.15 
       texture { pigment{color Silver}
                 finish {ambient 0.1 diffuse 0.8 phong 1}
               } // end of texture
       scale <1,1,1> rotate<0,0,0> translate<0,0,0>         
     } // end of cone -------------------------------------------
sphere { <0,0,0>, 0.15 
         texture { Polished_Chrome
                   finish { ambient 0.1 diffuse 0.85  phong 1}
                 } // end of texture 
          scale<1,0.5,1.5>  rotate<10,0,0>  translate<0,0.10,0.3>  
       }  // end of sphere -------------------------------------- 

scale 0.5
rotate<0,0,0>
}//----------------------------------------------------------- jet fly ----


 #declare Nr = 0;     // start
 #declare EndNr = 10; // end
 #while (Nr< EndNr) 

object { Jet scale 1.2
         Spline_Trans (Spline_1,  mod( (clock+Nr/EndNr) ,1) , y, 0.03, 0.95) }
 #declare Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 

//----------------------------------------------------------------------- end 
