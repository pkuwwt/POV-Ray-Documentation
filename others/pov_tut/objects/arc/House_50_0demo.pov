// PoVRay 3.7 Scene File "House_50_0demo.pov"
// author: Friedrich A. Lohmueller, Feb-2007/Aug-2009/Jan-2011
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
#declare Camera_0 = camera{/*ultra_wide_angle*/ angle 46      // front view
                            location  <0.0 , 2.25 ,-5.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.25 , 0.0>}
#declare Camera_1 = camera{/*ultra_wide_angle*/ angle 56   // diagonal view
                            location  <10.0 , 2.05 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.5 , 1.35 , 4.35>}
#declare Camera_2 = camera{/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera{/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{<2000,1500,-2500> color White*0.8} // sun
light_source{<10.0 , 2.05 ,-3.0> color White*0.2} // flash light

// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.55 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.65 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.00 rgb <0.5,0.5,0.5>]}
                        scale<1,1,1.5>*2.5  translate< 1,0,2>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   100
      color      White  
      fog_offset 0.1
      fog_alt    2
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
 
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Wall_Texture_Outside = 
      texture { pigment{ color rgb< 1, 0.87, 0.55>*1.0}               
                normal { pigment_pattern{ gradient y  scallop_wave 
                                           color_map {[0, rgb 0.8]
                                                      [0.975, rgb 0.8]
                                                      [1, rgb 0.2]}
                                           scale 0.10}
                         0.3 translate<0,-0.16,0>}
                finish { phong 0.1}
              } // end of texture
//--------------------------------------------------------                                 
#declare Wall_Texture_Inside = 
      texture { pigment{ color White*1.0}
                finish { phong 1}
              } // end of texture
//--------------------------------------------------------
#declare Roof_Texture = 
// layered texture!!!
      texture { pigment{ color rgb<1,1,1>*0.65} //Scarlet*1.3
                normal { gradient z scallop_wave scale<1,1,0.10>} 
                finish { phong 1}
              } // end of texture
 
      texture { pigment{ gradient x 
                         color_map{[0.00 color Clear]
                                   [0.90 color Clear]
                                   [0.95 color White*0.1]
                                   [1.00 color White*0.1]}
                          scale 0.25}
                 finish { phong 1}
              } // end of texture

//--------------------------------------------------------
#declare Window_Texture = 
         texture{ pigment{ color White*1.2}
                  finish { phong 0.1}}
//--------------------------------------------------------
#declare Base_Texture =  //texture{Wall_Texture_Outside} 
         texture{ pigment{ brick color rgb< 0.75, 0.7, 0.60>*0.35  // color mortar
                                 color rgb< 0.75, 0.7, 0.60>*0.70  // color brick
                           brick_size <0.25, 0.05, 0.25> // format in x ,y and z- direction 
                           mortar 0.0125                  // size of the mortar 
                           scale 1.25
                        } // end of pigment
                  normal {wrinkles 0.75 scale 0.01}
                  finish {ambient 0.15 diffuse 0.95 phong 0.2} 
                  rotate<0,0,0>  translate< 0.00, 0.00, 0.00>
               } // end of texture
//--------------------------------------------------------
#declare Veranda_Texture = 
      texture { pigment{ color rgb< 1, 1, 1>*1.0}               
                normal { pigment_pattern{ gradient x  scallop_wave 
                                           color_map {[0, rgb 0.8]
                                                      [0.975, rgb 0.8]
                                                      [1, rgb 0.2]}
                                           scale 0.15}
                         0.3 translate<-0.16,0,0>}
                finish { phong 0.0}
              } // end of texture
//--------------------------------------------------------
#declare Veranda_Beam_Texture1 =  //texture{Wall_Texture_Outside} 
         texture{ pigment{ color rgb< 1, 1, 1>*1.15}
                  finish { phong 0.0}} 
#declare Veranda_Beam_Texture2 =  //texture{Wall_Texture_Outside} 
         texture{ pigment{ color rgb< 1, 1, 1>*1.05}
                  finish { phong 0.0}} 
//--------------------------------------------------------                                 
//----------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#include "House_50_0.inc" 
//-------------------------------------------------------------------------------------// 
object{ House_50_0( 4.00, // Half_House_Width_X, // >= 3.00 
                    9.00, // Total_House_Width_Z,// >= 4.00
                    3.90, // House_Height_Y,     // >= 3.50
                    15,   // Roof___Angle, // ca. 10 ~ 60 degrees, adapt House_Height_Y ! 
                    // door and windows open/closed  

                    0.7, //Window_Open_Frontside_1,  left: 0=closed  ~ 1=open 
                    0.7, //Window_Open_Frontside_2,middle: 0=closed  ~ 1=open 
                    0.3, //Window_Open_Frontside_3, right: 0=closed  ~ 1=open 
                    0.2, //Window_Open_Backside_1,  left: 0=closed  ~ 1=open 
                    0.0, //Window_Open_Backside_2,middle: 0=closed  ~ 1=open 
                    0.0, //Window_Open_Backside_3, right: 0=closed  ~ 1=open 
                    0.7, //Window_Open_RightSide_1, back: 0=closed  ~ 1=open 
                    0.5, //Door_Open___Rightside_2,middle: 0=closed  ~ 1=open 
                    0.0, //Window_Open_RightSide_3,front: 0=closed  ~ 1=open 
                    0.3, //Window_Open_LeftSide_1,  back: 0=closed  ~ 1=open 
                    1.0, //Window_Open_LeftSide_2,middle: 0=closed  ~ 1=open 
                    1.0, //Window_Open_LeftSide_3, front: 0=closed  ~ 1=open 
                    // textures  
                    Wall_Texture_Outside  ,
                    Wall_Texture_Inside   , 
                    Window_Texture        ,
                    Roof_Texture          , 
                    Base_Texture          ,
                    Veranda_Texture       , 
                    Veranda_Beam_Texture1 ,
                    Veranda_Beam_Texture2 
                   ) //----------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0, 0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------







