// POV-Ray 3.6/3.7 Scene File "While_demo1.pov"
// author: Friedrich A. Lohmueller, March-2010 / Jan-2014
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
  #declare Camera_Location = < 0.00, 2.00,-15.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 0.25,  0.00> ;
  #declare Camera_Angle    =  25 ;
#break
#case (1)
  #declare Camera_Location =  <5.0 ,6.0 ,-9.0> ;  // diagonal view
  #declare Camera_Look_At  =  < 0.2 , 0.8 , 0.0> ;
  #declare Camera_Angle    =  25 ;
#break
#case (2)
  #declare Camera_Location = < 0.00, 5.00,  0+0.000> ;  // top view
  #declare Camera_Look_At  = < 0.00, 0.00,  0+0.001> ;
  #declare Camera_Angle    = 90 ;
#break
#else
  #declare Camera_Location = < 0.00, 1.00, -3.50> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  75 ;
#break
#break
#end // of "#switch ( Camera_Number )"  
//--------------------------------------------------------------------------
camera{ // ultra_wide_angle // orthographic 
        location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2000, 500> color rgb<1,1,1>*0.9}                // sun 
light_source{ Camera_Location   color rgb<0.9,0.9,1>*0.1 shadowless}// flash
// sky ---------------------------------------------------------------------
sphere{<0,0,0>,1 hollow 
              texture{pigment{gradient <0,1,0> scale 2
                              color_map{[0.0 color rgb<1,1,1>  ]
                                        [0.5 color rgb<1,0.75,0.0> ]
                                        [1.0 color rgb<1,1,1>  ]}
                              quick_color White }
                      finish {ambient 1 diffuse 0}
                     } 
           scale 10000}
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#declare FloorTex = //half transparent checkered ground
  texture { pigment{ checker color rgbf<1,1,1,1 > //clear
                             color rgb <1,0.6,0.0 >   }
            finish {  reflection 0.0}
          }

plane{<0,1,0>, 0  texture{FloorTex}}
//--------------------------------------------------------------------------
//------------------------------ the Axes --------------------------------
//------------------------------------------------------------------------
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
//------------------------------------------------------------------------
#macro AxisXYZ( AxisLenX, AxisLenY, AxisLenZ, Tex_Dark, Tex_Light)
//--------------------- drawing of 3 Axes --------------------------------
union{
#if (AxisLenX != 0)
 object { Axis_(AxisLenX, Tex_Dark, Tex_Light)   rotate< 0,0,-90>}// x-Axis
 text   { ttf "arial.ttf",  "x",  0.15,  0  texture{Tex_Dark} 
          rotate<10,-35,0> scale 0.65 translate <AxisLenX+0.05,0.4,-0.10> no_shadow}
#end // of #if 
#if (AxisLenY != 0)
 object { Axis_(AxisLenY, Tex_Dark, Tex_Light)   rotate< 0,0,  0>}// y-Axis
 text   { ttf "arial.ttf",  "y",  0.15,  0  texture{Tex_Dark}    
          rotate< 0,0,0> scale 0.65 translate <-0.65,AxisLenY+0.20,-0.10>  rotate<0,-40,0> no_shadow}
#end // of #if 
#if (AxisLenZ != 0)
 object { Axis_(AxisLenZ, Tex_Dark, Tex_Light)   rotate<90,0,  0>}// z-Axis
 text   { ttf "arial.ttf",  "z",  0.15,  0  texture{Tex_Dark}
          rotate<10,-35,0> scale 0.9 translate <-0.75,0.2,AxisLenZ+0.10> no_shadow}
#end // of #if 
} // end of union                      
#end// of macro "AxisXYZ( ... )"
//------------------------------------------------------------------------

#declare Texture_A_Dark  = texture {
                               pigment{ color rgb<0.9,0.0,0>}
                               finish { phong 1}
                             }
#declare Texture_A_Light = texture { 
                               pigment{ color rgb<1,1,1>}
                               finish { phong 1}
                             }

object{ AxisXYZ( 2.2, 1.8 , 3, Texture_A_Dark, Texture_A_Light) scale 1 }
//-------------------------------------------------- end of coordinate axes
//-------------------------------------------------------------------------- 
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
 
#declare Nr = 0;   // start
#while ( Nr < 30 ) // loop

     sphere{ <1,0,0>,0.25
             rotate<0,Nr * 360/30 ,0>
             texture{ pigment{ color rgb<1,0.65,0>}
                      finish { phong 1.0} 
                    } // end texture
            } // end sphere

#declare Nr = Nr + 1; // next 
#end // ---------------- end loop

