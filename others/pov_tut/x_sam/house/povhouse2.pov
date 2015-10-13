// POV-Ray 3.6 / 3.7 Scene File "povhouse2.pov"
// author: Friedrich A. Lohmueller, 2004/Aug-2009/Jan-2011  
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
//------------------------------------------------------------------------

#declare Camera_1 = camera { 
                             angle 12.5
                             location  <20.0 , 20.0 ,-30.0>
                             right     x*image_width/image_height
                             look_at   <1.0 , 1.5 , 2.0>
                           }
camera{Camera_1}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<-1500,2500,-2500> color White}
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
#macro Axis_( AxisLen, Dark_Texture,Light_Texture) 
 union{
    cylinder { <0,-AxisLen-1,0>,<0,AxisLen,0>,0.05
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
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark} 
          scale 0.5 translate <AxisLenX+0.05,0.4,-0.10>}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
           scale 0.5 translate <-0.75,AxisLenY+0.50,-0.10>}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
               scale 0.5 translate <-0.75,0.2,AxisLenZ+0.10>}
#end // of #if 
} // end of union
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<1,0.45,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ( 4.5, 4.5, 11, Texture_A_Dark, Texture_A_Light) no_shadow}
//-------------------------------------------------- end of coordinate axes


// ground -----------------------------------------------------------------
//---------------------------------<<< settings of squered plane dimensions
#declare RasterScale = 1.0;
#declare RasterHalfLine  = 0.025;  
#declare RasterHalfLineZ = 0.025; 
//-------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
       finish { ambient 0.15 diffuse 0.85}
 #end// of Raster(RScale, HLine)-macro    
//-------------------------------------------------------------------------
    
 
plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{ color White*1.3}
                  finish { phong 0.1}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
 
//------------------------------------------------ end of squered plane XZ

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

#declare Hx = 2.00;
#declare Hy = 3.50;
#declare Hz = 4.00;
#declare Roof_Angle = 38; 
#declare Wall_D = 0.20 ;// the thickness of the Wall 

#declare Roof_D = 0.10; // the thickness of the roof
#declare Roof_O = 0.20; // overhang 
#declare Roof_L = Hx+0.80;// try it !!! 

#declare Wall_Texture_1 = 
      texture { pigment{ color White*1.2}
                normal { bumps 0.5 scale 0.005} 
                finish { phong 1}
              } // end of texture
#declare Wall_Texture_2 = 
      texture { pigment{ color White*1.2}
                finish { phong 1}
              } // end of texture

#declare Roof_Texture = 
 // layered texture!!!
      texture { pigment{ color Scarlet*1.3}
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

//--------------------------------------------------------
// the walls caved out ----------------------- the Walls
intersection{
box { <-Hx,0,0>,< Hx,Hy,Hz>   
      texture {Wall_Texture_1}  
//    no_shadow
    } // end of box --------- 

plane{ <0,1,0>,0 
      texture {Wall_Texture_1}  
       rotate<0,0,Roof_Angle>
       translate<0,Hy,0>
     }

plane{ <0,1,0>,0 
      texture {Wall_Texture_1}  
       rotate<0,0,-Roof_Angle>
       translate<0,Hy,0>
     }
 // inside caved out
box { <-Hx+Wall_D,0.10,Wall_D>,
      <Hx-Wall_D,Hy,Hz-Wall_D>  
      texture {Wall_Texture_2}  
      inverse
     }

}// end of intersection  ------------------------- end of Walls

// the Roof 
box { < -Roof_L, 0.00, -Roof_O>,< Roof_D/2, Roof_D, Hz+Roof_O>  
      texture {Roof_Texture translate<-0.05,0,0>}  
      rotate<0,0, Roof_Angle>
      translate<0,Hy,0>
     }
box { < -Roof_L, 0.00, -Roof_O>,< Roof_D/2, Roof_D, Hz+Roof_O>  
      texture {Roof_Texture translate<-0.05,0,0>}  
      rotate<0,0, Roof_Angle>
      translate<0,Hy,0> scale<-1,1,1>
     }
//------------------------------------------------- end of Roof

//----------------------------------------------------------end
