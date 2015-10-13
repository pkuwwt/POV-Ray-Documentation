// PoVRay 3.7 Scene File "ATree_sassafras_m400.pov"
// author: Friedrich A. Lohmueller, Oct-2013
// demo file for using Albaro tree 
//  +w640 +h640
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
  #declare Camera_Location = < 0.00, 1.00,-60.00> ;  // front view
  #declare Camera_Look_At  = < 0.00,11.50,  0.00> ;
  #declare Camera_Angle    =  23 ;
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
// sky textures --------------------------------------------------------
#declare T_Clouds  =
texture {
    pigment { bozo
        turbulence 1.5
        octaves 10
        omega 0.5
        lambda 2.5
        color_map { [0.0 color rgbf<1, 1, 1, 1> ]
                    [0.2 color rgbf<0.85, 0.85, 0.85, 0.00>*1.5 ]
                    [0.5 color rgbf<0.95, 0.95, 0.95, 0.90>*1.12  ]
                    [0.6 color rgbf<1, 1, 1, 1> ]
                    [1.0 color rgbf<1, 1, 1, 1> ] }
    }

    finish {ambient 0.95 diffuse 0.1}
}

//--------------------------------------------------------------------
union { // make sky planes: 

 plane { <0,1,0>, 500 hollow //!!!!
        texture { bozo scale 1
                  texture_map{ 
                       [ 0.0  T_Clouds ]
                       [ 0.5  T_Clouds ]
                       [ 0.6  pigment{color rgbf<1,1,1,1> }] 
                       [ 1.0  pigment{color rgbf<1,1,1,1> }] 
                      } 
                       scale <500,1,1000>} translate<-400,0,300> } 

 plane { <0,1,0> , 10000  hollow
        texture{ pigment {color rgb<0.24,0.38,0.7>*0.50}
                 finish {ambient 1 diffuse 0}}}
scale<1.5,1,1.25>  
rotate<0,0,0> translate<0,0,0>}                          // end of sky
//--------------------------------------------------------------------


// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   250
      color      White*0.75
      fog_offset 0.1
      fog_alt    1.5
      turbulence 1.8
    }                                                    // end of fog

// ground ------------------------------------------------------------
plane { <0,1,0>, 0 
        texture{ pigment{ color rgb<0.35,0.65,0.0>*0.45 }
                 normal { bumps 0.75 scale 0.015 }
                 finish { phong 0.1 }
               } // end of texture
      } // end of plane                                   // end of ground
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------
// tree textures: ---------------------------------------
#declare Stem_Texture = 
 texture{ pigment{ color rgb< 0.75, 0.5, 0.30>*0.25 } 
          normal { bumps 0.75 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        } // end of texture 
//------------------------------------------------------- 
#declare Leaves_Texture_1 = 
 texture{ pigment{ bozo 
                   color_map{
                   [0.0 color rgbf< 1,0.1,0.0, 0.2>*0.7 ]  
                   [1.0 color rgbf< 1,0.7,0.0, 0.2>*1 ]
                            } //color_map  
                 }  // pigment 
          normal { bumps 0.15 scale 0.05 }
          finish { phong 1 reflection 0.00}
        } // end of texture 
//-------------------------------------------------------- 
#declare Leaves_Texture_2 = 
 texture{ pigment{ color rgbf< 1,0.5,0.0, 0.4>*0.5}    
          normal { bumps 0.15 scale 0.05 }
          finish { phong 0.2 }
        } // end of texture 
//-------------------------------------------------------- 
//--------------------------------------------------------------------------
#include "sassafras_m.inc"
//#declare Tree_Height = sassafras_13_height; // ~23.29, not used here!
//--------------------------------------------------------------------------
// tree with leaves
   union{ 
          object{ sassafras_13_stems
                  texture{ Stem_Texture }
                } //------------------------
          object{ sassafras_13_leaves  
                  double_illuminate
                  texture{ Leaves_Texture_1 }   
                  interior_texture{ Leaves_Texture_2 }   
                } //------------------------
      rotate <0,90,0>
      translate<-1,0,0>
    } // end of union 
//--------------------------------------------------------------------------



//--------------------------------------------------------------------------
// tree without leaves
   object{ sassafras_13_stems
           texture{ Stem_Texture }
           scale 1 
           rotate <0,45,0>
           translate <11,0,25>
        } //------------------------
//--------------------------------------------------------------------------








