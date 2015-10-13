// PoVRay 3.7 Scene File "media_scaling_macro_10.pov"
// author: Friedrich A. Lohmueller, Sept-2014.
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
#declare Camera_Number = 0 ;
//---------------------------------------------------------------------------------
// camera -------------------------------------------------------------------------
#switch ( Camera_Number )
#case (0)
  #declare Camera_Location = < 0.00, 1.00, -3.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 2.00,  0.00> ;
  #declare Camera_Angle    =  85 ;
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
light_source{< 3000,3000,-3000> color rgb<1,1,1>*0.9}                // sun
light_source{ Camera_Location   color rgb<0.9,0.9,1>*0.1 shadowless}// flash
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <0.2,0.5,1.0>*0.7]
                                   [0.35 rgb <0.2,0.3,0.8>*0.3]
                                   [0.65 rgb <0.2,0.3,0.8>*0.3]
                                   [1.00 rgb <0.2,0.5,1.0>*0.7]
                                 }
                       scale 2
                     } // end of pigment
           } //end of skysphere
//------------------------------
// fog on the ground ------------------------------------------------------
fog { fog_type   2
      distance   50
      color      White*0.75
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }                                                    // end of fog
// ground------------------------------------------------------------------
plane { <0,1,0>, 0
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
                 normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

#macro Cloud( Cloud_Scale )
sphere{ <0,0,0>, 1
 pigment{rgbt 1}
 hollow
 interior{ //-----------
 media{
  emission <1,1,1>/Cloud_Scale
  scattering{ 1,<1,1,1>/Cloud_Scale}
  density{ spherical
   turbulence 0
   color_map {
         [0 rgb 0.0]//border
         [1 rgb 1.0]//center
   } // end color_map
  } // end of density
 } // end of media ---
} // end of interior
scale Cloud_Scale
} //----- end of sphere
#end // end of macro
//----------------------------------------

object{ Cloud( 10 )  // Cloud( Cloud_Scale )
  // don't do any additional scaling here!
  translate<0,1,15>
}
//-----------------------------------------