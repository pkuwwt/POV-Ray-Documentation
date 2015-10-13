// POV-Ray 3.6 Scene File "spline_demo.pov"
// created by  Friedrich A. Lohmueller, 2003
// Demonstrates spline function  "spline{...}"
//------------------------------------------------------------------------
#version 3.6;
global_settings {  assumed_gamma 1.0 }
//------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"

//------------------------------------------------------------------------
#declare Camera_1 = camera { 
                             angle 14
                             location  <17.0 , 20.0 ,-21.0>
                             right     x*image_width/image_height
                             look_at   < 1 , 1.4 , 0.0>
                           }
camera{Camera_1}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{< -100,1500,-500> color White}
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
           scale 0.5 translate <-0.75,AxisLenY+0.50,-0.10>}
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
                               pigment{color rgb<1,0.65,0.00>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{color rgb<1,1,1>}
                               finish {ambient 0.15 diffuse 0.85 phong 1}
                             }

object{ AxisXYZ( 4.5, 3.0, 5, Texture_A_Dark, Texture_A_Light)}
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
#macro Marker(Position, Color )//----------------------------------------
union{
  sphere  { <0,0,0>, 0.15 
            texture { pigment{ color Color } 
                      finish { ambient 0.1 diffuse 0.85  phong 1}
                    } // end of texture 
            translate Position  
          }  // end of sphere ----------------------------------- 
  cylinder{ <0,-0.0001,0>,<0,Position.y,0>,0.05 
            texture { pigment { color White*1.2}
                     finish  { ambient 0.15 diffuse 0.85 phong 1}
                   } // end of texture
             translate<Position.x,0,Position.z>
          } // end of cylinder

}  // end of union
#end//-----------------------------------------------------------


//#declare P1 = < -2, 1.0, -2>;
#declare P1 = < -2, 1.0,  0>;
#declare P2 = < -0, 1.0, -2>;
#declare P3 = <  2, 1.0, -2>;
#declare P4 = <  2, 1.0,  0>;
#declare P5 = <  0, 1.0,  0>;
#declare P6 = <  0, 1.0,  2>;
#declare P7 = <  2, 1.0,  2>;
//#declare P8 = <  4, 1.0,  2>;
#declare P8 = < 01, 1.0,  7>;



// show the Positions
object{ Marker(P1, Red )}
object{ Marker(P2, Orange )}
object{ Marker(P3, Orange )}
object{ Marker(P4, Orange )}
object{ Marker(P5, Orange )}
object{ Marker(P6, Orange )}
object{ Marker(P7, Orange )}
object{ Marker(P8, Red )}




#declare Spline_1 =
  spline {
    natural_spline
   -0.20, P1, // controll point

    0.00, P2, // start
    0.20, P3,
    0.40, P4,
    0.60, P5,
    0.80, P6,
    1.00, P7, // end

    1.20, P8 // controll point
  }


union{
 #declare Nr = 0;     // start
 #declare EndNr = 1; // end
 #while (Nr< EndNr) 

 sphere{ <0,0,0>,0.07
         scale<1,1,1>
     
	 texture{ pigment{color rgb <1-Nr/2,0.75+Nr/4,0>}
	          finish {ambient 0.15 diffuse 0.85 phong 1}
                }
                
         translate Spline_1(Nr) 
       } // end of sphere

 #declare Nr = Nr + 0.005;  // next Nr
 #end // --------------- end of loop 

rotate<0,0,0> 
translate<0,0,0>
} // end of union  ----------------------------------------


