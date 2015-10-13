// POV-Ray 3.6 / 3.7 Scene File "povtree_001_winter.pov"
// author: Friedrich A. Lohmueller, Oct-2013
// homepage: http://www.f-lohmueller.de
//
//  +w480 +h640
//--------------------------------------------------------------------------
#version 3.7; // 3.6
global_settings{ assumed_gamma 1.0 } 
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}
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
//--------------------------------------------------------------------------------------------------------<<<<
#declare Camera_Number = 0 ;
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Location = < 0.00, 1.00, -4.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 2.00,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (1)
  #declare Camera_Location = < 5.00, 5.00,-5.00> ;  //diagonal view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  65 ;
#break
#case (2)
  #declare Camera_Location = <10.00, 1.00,  0.00> ;  // right side view
  #declare Camera_Look_At  = < 0.00, 1.00,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#else
  #declare Camera_Location = < 0.00, 1.00, -4.00> ;  // front view
  #declare Camera_Look_At  = < 0.00, 2.00,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//------------------------------------------------------------------
camera{ location Camera_Location
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      } 
//-----------------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------------<<<<<
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
      distance   50
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
//-------------------------------------------------------------
//global_settings { max_trace_level 10 }//(1...256) [default = 5]
//-------------------------------------------------------------
//-------------------------------------------------------------
#include "povtree/trees/povtree_001.inc"
// winter 
#declare LEAVES=20*BUNCHES;
#declare BOTTOM_COLOR_1=<0.4, 0.25, 0.1, 0.0, 0.0>;
#declare BOTTOM_COLOR_2=<0.3, 0.2, 0.1, 0.0, 0.0>;
#declare TOP_COLOR_1=<0.4, 0.3, 0.2, 0.0, 0.0>;
#declare TOP_COLOR_2=<0.4, 0.3, 0.2, 0.0, 0.0>;

#include "TOMTREE/TOMTREE-1.5.inc"
//-------------------------------------------------------------
#declare Tree_01 = object{ TREE double_illuminate hollow}
//-------------------------------------------------------------
object{ Tree_01 
        scale  4
        rotate<0, 0,0>
        translate<0, 0.00,0>
      } //------------------------------------------------------
//-------------------------------------------------------------- 
