// POV-Ray 3.7 Scene File "povloop8.pov"
// author: Friedrich A. Lohmueller, Jan-2014
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 }
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
//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
#declare Camera_Number = 1 ;
//---------------------------------------------------------------------------------
// camera -------------------------------------------------------------------------
#switch ( Camera_Number )
#case (0)
  #declare Camera_Location = < 0.00, 1.00,-13.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00 , 0.0> ;
  #declare Camera_Angle    =  45 ;
#break
#case (1)
  #declare Camera_Location =  < 5.00, 6.00,-8.00> ;  // diagonal view
  #declare Camera_Look_At  =  < 0.5, 1.5 ,  0.0>;
  #declare Camera_Angle    =  48 ;
#break
#case (2)
  #declare Camera_Location = <10.00, 1.00,  0.00> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  50 ;
#break
#case (3)
  #declare Camera_Location = < 0.00,14.00,  0+0.000> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0+0.001> ;
  #declare Camera_Angle    =  50 ;
#break
#else
  #declare Camera_Location = < 0.00, 1.00,-13.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00 , 0.0> ;
  #declare Camera_Angle    =  45 ;
#break
#break
#end // of "#switch ( Camera_Number )"  
//--------------------------------------------------------------------------
camera{ ultra_wide_angle // orthographic 
        location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//--------------------------------------------------------------------------
// sun ---------------------------------------------------------------------
light_source{< 1800,4500, -2500> color rgb<1,1,1>*0.9}                // sun 
//light_source{ Camera_Location   color rgb<0.9,0.9,1>*0.05 shadowless} // flash
// sky ---------------------------------------------------------------------
sphere{<0,0,0>,1 hollow
       texture{pigment{gradient <0,1,0>
                       color_map{[0.00 color rgb<0.75,1,1>*0.05 ]
                                 [0.15 color rgb<0.75,1,1>*0.05 ]
                                 [0.50 color rgb<0.75,1,1>]
                                 [0.85 color rgb<0.75,1,1>*0.05 ]
                                 [1.00 color rgb<0.75,1,1>*0.05 ]}
                       quick_color rgb<1,1,1>
                       scale 2 translate<0,-1,0> 
                       rotate<-25,0,0> }
               finish {ambient 1 diffuse 0}
              }
       scale 10000}
// -------------------------------------------------------------------------
// -------------------------------------------------------------------------
// ground ------------------------------------------------------------------
//--------------------------------------------------------------------------
/*
//----------------------------------------------------------<<< settings of squared plane dimensions
#declare RasterScale = 0.1 ;
#declare RasterHalfLine  = 0.065 ;  
#declare RasterHalfLineZ = 0.065 ; 
//--------------------------------------------------------------------------
#macro Raster(RScale, HLine) 
       pigment{ gradient x scale RScale
                color_map{[0.000   color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,0>*0.6]
                          [0+HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,1>]
                          [1-HLine color rgbt<1,1,1,0>*0.6]
                          [1.000   color rgbt<1,1,1,0>*0.6]} }
 #end// of Raster(RScale, HLine)-macro    
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
    

plane { <0,1,0>, 0    // plane with layered textures
        texture { pigment{color White*1.1}
                  finish {ambient 0.45 diffuse 0.85}}
        texture { Raster(RasterScale,RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(RasterScale,RasterHalfLineZ) rotate<0,90,0>}

        texture { Raster(10*RasterScale,0.2*RasterHalfLine ) rotate<0,0,0> }
        texture { Raster(10*RasterScale,0.2*RasterHalfLineZ) rotate<0,90,0>}
        rotate<0,0,0>
      }
//------------------------------------------------ end of squared plane XZ
*/
//--------------------------------------------------------------------------
//------------------------------ the Axes ----------------------------------  start coordinate axes
//--------------------------------------------------------------------------
#macro Axis_( AxisLen, Dark_Texture,Light_Texture) 
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
//--------------------------------------------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, Tex_Dark, Tex_Light)
//--------------------- drawing of 3 Axes ----------------------------------
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark} 
          rotate<0,-25,0> scale 0.65 translate <AxisLenX+0.0,0.3, 0.10> no_shadow}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
          rotate<0,0,0> scale 0.65 translate <-0.55,AxisLenY+0.20,-0.10>  rotate<0,-25,0> no_shadow}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<0,-25,0> scale 1.0 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow}
#end // of #if 
} // end of union                      
#end// of macro "AxisXYZ( ... )"
//--------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<0.5,0,0.25>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ( 4.4, 3.25, 17.5, Texture_A_Dark, Texture_A_Light) scale 1 }
//---------------------------------------------------------------------------- end of coordinate axes
//----------------------------------------------------------------------------
//---------------------------- objects in scene ------------------------------
//----------------------------------------------------------------------------
 

//----------------------------------------------------------------------
//----------------------------------------------------------------------
//----------------------------------------------------------------------
#declare Element = 
 cylinder  {<0,0,0>,<1,1,0>,0.05 scale <1,1,1>  translate<0,0,0> 
          
        }
//---------------------------------------------------------

#declare Radius     = 2.50;
#declare N_rev      = 3;
#declare N_p_rev  = 2500; 
#declare H_p_rev  = 0.8;
#declare H = H_p_rev/N_p_rev;
//---------------------------------------------------------
union{
#declare Nr = 0;                // start
#declare EndNr = N_rev*N_p_rev; // end
#while (Nr< EndNr)              // loop
 object{ Element
         translate<Radius,Nr*H,0> 
         rotate<0,Nr * 360/N_p_rev ,0>
       } //

#declare Nr = Nr + 1;  // next Nr
#end // --------------------------//  end of loop 

 texture{ pigment{ color rgb<1,1,1> *0.85 } 
          normal { bumps 0.75 scale 0.15 } 
          finish { phong 1 specular 0.5 reflection 0.2 }
        } //-------------------------------

rotate<0,0,0>
} // end union 


//------------------------------------------------------------------- end
