// PoVRay 3.7 Scene File "Palisade_Fence_0demo.pov"
// author: Friedrich A. Lohmueller, Jan-2006/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 75      // front view
                            location  <0.0 , 1.0 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 55   // diagonal view
                            location  < 22.00, 0.50,-6.00>
                            right     x*image_width/image_height
                            look_at    <5.00, 6,  0.00>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}

// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.50 rgb <0.20, 0.20, 1.0>*0.9]
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



//--------------------------------------------------------------------------------
//---------------------------------------------------------------------- textures
#declare Pile_Body_Texture = 
         texture { pigment { color rgb<0.40,0.28,0.20>*1.0 }
                   normal  { bumps 0.5 scale <0.005,0.25,0.005>*0.5}
                   finish  { diffuse 0.9 phong 0.5 reflection 0.00 }
                 } // end of texture

#declare Pile_Tip_Texture = 
         texture { pigment { color rgb< 0.75, 0.5, 0.30> }
                   normal  { bumps 0.15 scale <0.005,0.25,0.005>}
                   finish  { diffuse 0.9 phong 0.5 reflection 0.00 }
                 } // end of texture
//--------------------------------------------------------------------------------
#include "Palisade_Fence_0.inc"
//--------------------------------------------------------------------------------
union{
object{ Palisade_Fence_0( 6.60, // fence length
                          3.50, // pile height,               
                          0.40, // pile tip height,   
                          0.15, // Pile radius,  
                          0.9, //~0.9 relative pile distance in percent of radius
                          Pile_Body_Texture, // dark wooden
                          Pile_Tip_Texture   // tip 
                        )} //-------------------------
object{ Palisade_Fence_0( 6.70, // fence length
                          3.50, // pile height,               
                          0.40, // pile tip height,   
                          0.15, // Pile radius,  
                          0.9, //~0.9 relative pile distance in percent of radius
                          Pile_Body_Texture, // dark wooden
                          Pile_Tip_Texture   // tip 
                        ) //-------------------------
  translate<8.50,0,0.00>}         
      }  // end of object ------------------------------------------------------- 
//-------------------------------------------------------------------------------
union{
object{ Palisade_Fence_0( 6.60, // fence length
                          3.50, // pile height,               
                          0.40, // pile tip height,   
                          0.15, // Pile radius,  
                          0.9, //~0.9 relative pile distance in percent of radius
                          Pile_Body_Texture, // dark wooden
                          Pile_Tip_Texture   // tip 
                        )} //-------------------------
object{ Palisade_Fence_0( 6.70, // fence length
                          3.50, // pile height,               
                          0.40, // pile tip height,   
                          0.15, // Pile radius,  
                          0.9, //~0.9 relative pile distance in percent of radius
                          Pile_Body_Texture, // dark wooden
                          Pile_Tip_Texture   // tip 
                        ) //-------------------------
                       translate<8.50,0,0.00>}         
  translate<0.00,0,15.00>    
      }  // end of object ------------------------------------------------------- 
//-------------------------------------------------------------------------------
object{ Palisade_Fence_0( 15.00, // fence length
                          3.50, // pile height,               
                          0.40, // pile tip height,   
                          0.15, // Pile radius,  
                          0.9, //~0.9 relative pile distance in percent of radius
                          Pile_Body_Texture, // dark wooden
                          Pile_Tip_Texture   // tip 
                        ) //-------------------------
          scale<1,1,1>  rotate<0,-90,0>  translate<15.10,0,0.10>  
      }  // end of object ------------------------------------------------------- 

object{ Palisade_Fence_0( 15.00, // fence length
                          3.50, // pile height,               
                          0.40, // pile tip height,   
                          0.15, // Pile radius,  
                          0.9, //~0.9 relative pile distance in percent of radius
                          Pile_Body_Texture, // dark wooden
                          Pile_Tip_Texture   // tip 
                        ) //-------------------------
          scale<1,1,1>  rotate<0,90,0>  translate< 0.00,0,0.00>   scale< 1,1,-1> 
      }  // end of object ------------------------------------------------------- 

//-------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#include "Tree_00.inc" // include 1st type of tree
#include "Tree_10.inc" // include 2nd type of tree
//-------------------------------------------------------------------------------------// 
#include "Random_Planting_100.inc" 
//-------------------------------------------------------------------------------------// 
object{ Random_Planting_100( object{ Tree_00 scale 0.8 translate<0,-0.5,0>}, //  object type 1 to plant, //                                   
                             object{ Tree_10},           //  object type 2 to plant, //                                   
                             21357, // Random_Choice__Seed, integer 0 ~ 65536
                             0.30, // Choice_Threshold, // from 0.00 = only type1 up to 1.00 = only type2 
                             6, // Number_in_X, // number of objects in x direction
                             12, // Number_in_Z, // number of objects in z direction
                             3.00, // Base_Distance_X, //
                             3.00, // Base_Distance_Z, // 
                             10,   // Base_Tilt_Angel, // degrees
                             1.00, // Tilt_Angel_Ramdom_Factor, // 
                             1.00, // Base_Object_Scale, // ~ 1
                             0.50, // Object_Scale_Ramdom_Factor, // ~ 0.5
                             6432, // Seed_0, // Ramdom seed for tilt on x-axis 
                             1153, // Seed_1, // Ramdom seed for rotating around y-axis
                              342, // Seed_2, // Ramdom seed for scaling
                             2655  // Seed_3, // Ramdom seed for moving in x and z
                           ) //--------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<-55.00,0.00,5.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------











