// PoVRay 3.7 Scene File "VRand_On_Sphere_2.pov"
// author: Friedrich A. Lohmueller, April-2013
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.1 }
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
  #declare Camera_Look_At  = < 0.00, 1.20,  0.00> ;
  #declare Camera_Angle    =  65 ;
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
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.24, 0.32, 1.0>*0.7]
                                     [0.50 rgb <0.24, 0.32, 1.0>*0.7]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 0,0,0>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   50
      color      White  
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }

// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.72 }
        normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------




//--------------------------------------------------------- 
//---------------------------------------------------------
//---------------------------------------------------------
#include "rand.inc" // random functions include file
#include "transforms.inc" // for Reorientate_Trans
#declare Random_1 = seed (23528);
//---------------------------------------------------------

union{
 #local Nr = 0;     // start
 #local EndNr = 150; // end
 #while (Nr< EndNr)
   // differ a little bit form spherical position:
   #local RandScale = (1+0.1*rand(Random_1)); 
   #local Position  = RandScale * VRand_On_Sphere(Random_1);
   union{ // inner union 

   cone{ <0,0,0>, 0.02, Position, 0.01 
         texture { pigment{ color rgb< 0.75, 0.5, 0.30> }  
                   normal { bumps 0.5 scale 0.05 }
                   finish { phong 1 }
                 } // end of texture 
       } //---------------

   sphere{ <0,0,0>, 0.1  //, 1.5
           scale <1,0.5,1>// y orientated
           // turn it in direction zero to Position:
           Reorient_Trans( <0,1,0>, Position )
           translate Position // move it to position
           texture{ pigment{ color rgb< 1.0, 0.15, 0.0> }
                    normal { bumps 0.5 scale 0.05 }
                    finish { phong 1 }
                  } // end of texture
         } //---------------
   } // end inner union
 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop
 rotate<0,0,0>

 translate<0,1.25,0>
 rotate<0,0,0>
} // end of union
//---------------------------------------------------------
//---------------------------------------------------------
