// PoVRay 3.7 Scene File "Object_Pattern_with_Textures_1.pov"
// author: Friedrich A. Lohmueller
// Demo file for object pattern with textures
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
#declare Camera_Number = 0 ;
//---------------------------------------------------------------------------------
// camera -------------------------------------------------------------------------
#switch ( Camera_Number )
#case (0)
  #declare Camera_Location = < 0.00, 1.00, -3.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  55 ;
#break
#case (1)
  #declare Camera_Location =  < 2.0 , 2.5 ,-3.0> ;  // diagonal view
  #declare Camera_Look_At  =  < 0.0 , 1.0 , 0.0> ;
  #declare Camera_Angle    =  90 ;
#break
#case (2)
  #declare Camera_Location = < 3.0, 1.0 , 0.0> ;  // right side view
  #declare Camera_Look_At  = < 0.0, 1.0,  0.0> ;
  #declare Camera_Angle    =  90 ;
#break
#case (3)
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

// sun ---------------------------------------------------------------------
light_source{< 3000,3000,-3000> color rgb<1,1,1>*0.9}               // sun
light_source{ Camera_Location   color rgb<0.9,0.9,1>*0.1 shadowless}// flash
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>]
                                   [0.30 rgb <0.0,0.1,1.0>]
                                   [0.70 rgb <0.0,0.1,1.0>]
                                   [1.00 rgb <1.0,1.0,1.0>]
                                 }
                       scale 2
                     } // end of pigment
           } //end of skysphere
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    3.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0
       texture{ pigment{ color rgb <1.00,0.95,0.8>}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 }
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



#declare My_Pattern_Object =
text { ttf "arialbd.ttf", "POV-Ray", 0.105, 0.0 // thickness, offset
       scale<0.8,1.25,1>*0.5
       rotate<0,0,20>
       translate<0.30,0.05,-0.025 >
      } // end of text object ---------------------------------------------


#declare Outside_Texture =
       texture{ pigment{ Candy_Cane scale <-1,1,1>*0.1 }
                normal { bumps 0.45 scale 0.05 }
                finish { specular 0.6 }
              }
#declare Inside_Texture =
       texture{ Polished_Chrome
                normal { bumps 0.35 scale 0.05 }
              }

// test the pattern object position:
//object{ My_Pattern_Object  pigment{ YellowGreen}}

// object with texture by object pattern:
object{ Round_Box( <0,0,0>,<2,1,1>, 0.1, 0)
   texture{
       object {
          My_Pattern_Object
          texture{ Outside_Texture}   // outside
          texture{ Inside_Texture }    // inside
       } // end object pattern
      // optional texture modifiers:
    // turbulence <0.1,0,0>
    } // end texture
  rotate<0,30,0>
  translate <-1,0.5,0>
} // end box




