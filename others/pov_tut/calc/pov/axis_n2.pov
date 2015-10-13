// POV-Ray 3.6 / 3.7 Scene File "axis_n2.pov"
// author: Friedrich A. Lohmueller, 2003/Aug-2009 / Jan-2011 
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{assumed_gamma 1.0} 
#include "colors.inc"
#include "textures.inc"
// camera -----------------------------------------------------------
#declare Cam0 = camera{ //ultra_wide_angle 
                        angle 16 
                        location  <0.0 , 1.0 ,-30.0>
                        right     x*image_width/image_height
                        look_at   <0.25 , 1.0 , 0.0>}
#declare Cam1 = camera{ ultra_wide_angle angle 90 
                        location  <20.0 , 20.5 ,-30.0>
                        right     x*image_width/image_height
                        look_at   <0.0 , 1.0 , 0.0>}
camera{Cam0}
// sun ---------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky ---------------------------------------------------------------
sphere{<0,0,0>,1 hollow 
              texture{pigment{gradient <0,1,0>
                              color_map{[0.0 color Blue ]
                                        [0.5 color White]
                                        [1.0 color Blue ]}
                              quick_color White 
                              scale 2 translate<0,-1,0>}
                      finish {ambient 1 diffuse 0}
                     } 
           scale 10000}
//---------------------------------------------------------------------
//---------------------------------------------------------------------
#macro Axis_( AxisLen, RedTexture,WhiteTexture) // --------------------- 
union{
    cylinder {<0,-AxisLen,0>,<0,AxisLen,0>,0.05
              texture{checker texture{RedTexture} texture{WhiteTexture}
                      translate<0.1,0,0.1>}}
    cone{<0,AxisLen,0>,0.2,<0,AxisLen+0.7,0>,0
         texture{RedTexture}}
     } // end of union "Axis"                  
#end // of macro Axis (AxisLen)
//--------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, TexRed, TexWhite)
//--------------------- 3 Achsen zeichnen -----------------------------
union{
object{Axis_(AxisLenX, TexRed, TexWhite)   rotate< 0,0,-90>}   // x-Axis
object{Axis_(AxisLenY, TexRed, TexWhite)   rotate< 0,0,  0>}   // y-Axis
object{Axis_(AxisLenZ, TexRed, TexWhite)   rotate<90,0,  0>}   // z-Axis
//--------------------- Achsenbezeichnungen ---------------------------
text{ttf"arial.ttf",  "x",  0.15,  0 no_shadow
     texture{TexRed} 
     scale 0.5 translate <AxisLenX+0.05,0.20,-0.12>}
text{ttf"arial.ttf",  "y",  0.15,  0 no_shadow 
     texture{TexRed} 
     scale 0.5 translate <-0.35,AxisLenY+0.50,-0.05>}
text{ttf"arial.ttf",  "z",  0.15,  0 no_shadow
     texture{TexRed} 
     scale 0.5 translate <-0.75,0.2,AxisLenZ+0.50>}
} // end of union
#end// of macro "AxisXYZ(...)"
//----------------------------------------------------------------------


//--------------------------drawing the axis ---- Achsen zeichnen ------
#declare Tex_Dark = texture{ pigment{ color rgb<1,0.45,0>}
                             finish { phong 1}}
#declare Tex_White =texture{ pigment{ color rgb<1,1,1>}
                             finish { phong 1}}

object{ AxisXYZ( 3.5, 3, 0.0001, Tex_Dark, Tex_White)}
//--------------------------end of coordinates ---- Ende der Koordinaten


// background ---------------------------------------------------<<<< Raster macro
//----------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.4]
                          [0+HLine color rgbt<1,1,1,0>*0.4]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.4]
                          [1.000   color rgbt<1,1,1,0>*0.4]} }
       finish {ambient 0.1 diffuse 0.9}
 #end// of Raster(RScale, HLine)-macro    
//-----------------------------------------------------------------<<< Grid macro
#macro Grid (RasterScale, RasterHalfLine, Background_pigment)
 plane{<0,1,0>, 0      // uses layerd textures!!!!
       texture{Background_pigment  finish { phong 0.1}}
       texture{Raster( RasterScale, RasterHalfLine) rotate<0,0,0> }
       texture{Raster( RasterScale, RasterHalfLine) rotate<0,90,0>}
      scale 1}
#end // end of macro  Grid (RasterScale, RasterHalfLine, Background_Texture)
//---------------------------------------------------------------------------

object{ Grid ( 0.5, 0.03, pigment{color rgb<1,1,1>*1.5} )  rotate<-90,0,0>}

