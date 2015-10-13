// POV-Ray 3.6/3.7 Scene File "hdr_sample_002.pov"
// author: Friedrich A. Lohmueller, Dec-2009, 22-July-2010 - 23-Dec-2010 / Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7; // 3.6;
global_settings{ assumed_gamma 1.0 }
// Note: HDRI illumination works needs POV-Ray 3.7
//#default{ finish{ ambient 0.1 diffuse 0.9 }} // not with radiosity see below
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
//--------------------------------------------------------------------------------------------------------<<<<


#declare Camera_Number = 2 ;
#declare HDRI_On       = 1; // 1 = on, 0 = off
#declare Radiosity_On  = 1; // 0=off, 1=fast; 2=medium quality; 3=high qual.; 4= medium qual.+ recursion_limit 2



//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (1)
  #declare Camera_Position = < 1.10, 2.100,-1.80> ;  //  diagonal view
  #declare Camera_Look_At  = < 0.00, 2.00,-0.60> ;
  #declare Camera_Angle    =  60 ;
#break
#case (2)
  #declare Camera_Position = < 1.00, 2.400,-1.70> ;  //  diagonal view
  #declare Camera_Look_At  = < 0.00, 1.85, -0.60> ;
  #declare Camera_Angle    =  55 ;
#break
#else
  #declare Camera_Position = < 0.00, 1.00, -5.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//-------------------------------------------------------------------------------------------------------<<<<
camera{ //#if (Ultra_Wide_Angle_On = 1) ultra_wide_angle #end  // don't use fish eye - for proper text
        location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//------------------------------------------------------------------------------------------------------<<<<<


//------------------------------------------------------------- radiosity settings start
#if (Radiosity_On > 0)

global_settings {
 #ifndef ( Rad_Quality )
 #declare Rad_Quality = 2;  // no end "}" of "global_settings" here !!
#end

//--------- radiosity settings -------------------------------- ///
// from POV-Ray samples "scene templates/patio-radio.pov

#switch (Rad_Quality)
 #case (1)
  radiosity {             // --- Settings 1 (fast) ---
    pretrace_start 0.08
    pretrace_end   0.02
    count 50
    error_bound 0.5
    recursion_limit 1
  }
 #break
 #case (2)
  radiosity {             // --- Settings 2 (medium quality) ---
    pretrace_start 0.08
    pretrace_end   0.01
    count 120
    error_bound 0.25
    recursion_limit 1
  }
 #break
 #case (3)
  radiosity {             // --- Settings 3 (high quality) ---
    pretrace_start 0.08
    pretrace_end   0.005
    count 400
    error_bound 0.1
    recursion_limit 1
  }
 #break
 #case (4)
  radiosity {             // --- Settings 4 (medium quality, recursion_limit 2) ---
    pretrace_start 0.08
    pretrace_end   0.005
    count 350
    error_bound 0.15
    recursion_limit 2
  }
 #break
 #end  // en of switch
} // end of global settings !!!!

#default{ finish { ambient 0 diffuse 1 conserve_energy }} // with radiosity no ambient!
//--------------------------------------------------------------------------
#else

#default{ finish{ ambient 0.1 diffuse 0.9 }
 } // for intel computers

#end // Radiosity_On > 0
//--------------------------------------------------------------------------

// sun ---------------------------------------------------------------------
light_source{ Camera_Position  color rgb<0.9,0.9,1>*0.1}  // flash light
//--------------------------------------------------------------------------

#if (HDRI_On) // --------------------------------------------------- HDRI environment
sky_sphere{ pigment{ image_map{ hdr "hdr/building_probe.hdr"
                                gamma 1.1
                                map_type 1 interpolate 2 }
                   }
            rotate < 0,40,0>  // adapt it to your direction
          } // end sky_sphere

#else // no HDRI
light_source{<-1700,2000, 2500> color White*0.5}           // sun light
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{
                       [ 0   color rgb<1,1,1>          ] //White
                       [ 0.4 color rgb<0.14,0.14,0.56> ] //~Navy
                       [ 0.6 color rgb<0.14,0.14,0.56> ] //~Navy
                       [ 1.0 color rgb<1,1,1>          ] //White
                       } // end color_map
                     scale 2
                   } // end pigment
          } // end of sky_sphere
#end // of "#if (HDRI_On) "
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//--------------------------------------------------------------------------
//-------------------------------------------------------- optional textures
#declare Body_Texture =
         texture { //Chrome_Metal
                   pigment{ color rgb< 1.0, 0.6,0.05>} //  light orange
                   normal { bumps 0.15 scale 0.75 }
                   finish { phong 0.3 reflection 0.05}
                 } // end of texture
#declare Inside_Texture =
         texture { pigment{ color rgb< 1, 1, 1>*0.75 } //  color Gray75
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 0.1}
                 } // end of texture
#declare Seat_Texture =
         texture { pigment{ color rgb<1,0.85,0.75>*1.1}// very light brown
                   normal { bumps 0.5 scale 0.025 }
                   finish { phong 1 reflection 0.00}
                 } // end of texture

//--------------------------------------------------------------------------
#include "Helicopter_01.inc"
#include "Table_t00.inc"
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
union{

object{ Table_t00 ( 0.800, // Table__Height,
                    0.400, // Table__Half_Width_X,
                    0.400, // Table__Half_Width_Z,
                    0.020, // Table__Feet_Radius,
                    0.030, // Table__Plate_D,
                    0.020, // Table__Plate_Overhang,
                    0, // Merge_On, for glas plate use 1
                  ) //------------------------------------------
        rotate<0,0,0>}

object{ Helicopter_01 ( 10,// Rotor_Rotation, // main rotor
                        100,// Backside_Rotor_Rotation, // main rotor

                        Body_Texture,
                        Inside_Texture,
                        Seat_Texture
                      ) //------------------------------------------
        scale <1,1,1>*0.085
        rotate<0,0,0>
        translate<0,0.80-0.003,0>
      } //------------------------------------------------------------------

//--------------------------------------------------------------------------
scale <1,1,1>*2  rotate<0,0,0> translate<-0.50,0.00,0.00>}
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------