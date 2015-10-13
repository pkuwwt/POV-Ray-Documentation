// PoVRay 3.6 / 3.7 Scene File "VRand_in_Object_HF1.pov"
// author: Friedrich A. Lohmüller, April-2013
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
  #declare Camera_Location = < 0.00, 2.00, -3.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 2.20,  0.00> ;
  #declare Camera_Angle    =  75 ;
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
light_source{< -3000,3000,-2000> color rgb<1,1,1>*0.9}               // sun 
light_source{ Camera_Location   color rgb<0.9,0.9,1>*0.1 shadowless}// flash
// sky ---------------------------------------------------------------------
sky_sphere { pigment { gradient <0,1,0>
                       color_map { [0.00 rgb <1.0,1.0,1.0>]
                                   [0.30 rgb <0.2,0.3,0.8>]
                                   [0.70 rgb <0.2,0.3,0.8>]
                                   [1.00 rgb <1.0,1.0,1.0>] 
                                 } 
                       scale 2         
                     } // end of pigment
           } //end of skysphere
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   500
    color      White
    fog_offset 0.1
    fog_alt    2.0
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

//---------------------------------------------------------------------
//---------------------------------------------------------------------
#declare Mountain  = 
height_field{ 
   png "Mount1.png" smooth double_illuminate
   // file types: 
   // gif | tga | pot | png | pgm | ppm | jpeg | tiff | sys
   // [water_level N] // truncate/clip below N (0.0 ... 1.0)
   translate<-0.5,-0.001,-0.5>
   rotate<0,-110,0>
   scale<50,12,40> 
   texture{ 
      pigment{ color rgb <0.85,0.6,0.4>}
      normal { bumps 0.75 scale 0.025  }
   } // end of texture
   translate<2,0,30>
} // end of height_field ---------------------
//--------------------------------------------
//--------------------------------------------
//------------------ 
#include "rand.inc" // random functions 
#declare Random_1 = seed (12433);
//--------------------------------------------
//--------------------------------------------
union{

 #local Nr = 0;     // start
 #local EndNr = 4000; // end
 #while (Nr< EndNr)
   sphere{ <0,0,0>, 0.80
      translate 
        VRand_In_Obj( Mountain, Random_1)
      texture{  
        pigment{ color rgb<0.6,0.05,0.1>}
        finish{ phong 1 reflection{0.15}}
      } // end of texture
   } // end of object
 #local Nr = Nr + 1;  // next Nr
 #end // ----------- end of loop

rotate<0,-20,0>
translate<10,0,0>} // end of union
//--------------------------------------------
//--------------------------------------------









