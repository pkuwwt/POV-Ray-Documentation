// POV-Ray 3.6 / 3.7 Scene File "Roof_0_demo.pov"
// author: Friedrich A. Lohmueller, Jan-2006/Aug-2009/Jan-2011/May-2014
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7; 
global_settings{ assumed_gamma 1.0 } 
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"

// camera -----------------------------------------------------
#declare Camera_0 = camera{ /*ultra_wide_angle*/ angle 32      
                            location  <-2.0, 17.0, -17.0>
                            right x*image_width/image_height
                            look_at <-2.0 , 4.0, -0.5>}
camera{Camera_0} 
// sun ---------------------------------------------------------------
light_source{<2500,2500,-1500> color White}
// sky ---------------------------------------------------------------
sphere{<0,0,0>,1 hollow 
              texture{pigment{gradient <0,1,0>
                              color_map{[0 color White]
                                        [1 color Blue ]}
                              quick_color White }               

                      finish {ambient 1 diffuse 0}
                     } 
           scale 10000}
// ground ------------------------------------------------------------
plane{<0,1,0>, 0 
      texture{pigment{ color rgb<0.15,0.35,0.00>}
              normal { bumps 0.5 scale 0.025}
              finish { phong 0.1}}}
//--------------------------------------------------------------------

 

//--------------------------------------------------------------------- roof textures <<<<<<<<<<<<<
#declare RoofTrans = <-1.25,0,0>;// to regulate the start of the roof brics
#declare Roof_Base_Color = <1,1,1>*1;// = <1,0.34,0.160>*1
#declare Roof_Color_Factor = 0.4; 
#declare Roof_Texture1 = texture{
   pigment{gradient x 
           color_map{[0.00 color rgb Roof_Base_Color*Roof_Color_Factor ]
                     [0.90 color rgb Roof_Base_Color*Roof_Color_Factor ]
                     [0.95 color rgb Roof_Base_Color*0.0 ]
                     [1.00 color rgb Roof_Base_Color*Roof_Color_Factor ]
                    }
           scale < 1, 1, 1>*0.38  quick_color  Scarlet*1.25}
   normal { bumps 0.5 scale 0.01} 
   finish { phong 1}
   translate RoofTrans}

#declare Roof_Texture2 = texture{
   Roof_Texture1  
   finish { ambient 0.15 diffuse 0.85 phong 1}}
//-------------------------------------------------------------------------------------<<<<<<<<<<<<


// --------------------------------------------------------------------------------------------
#declare Wall_Height = 3.00;
// --------------------------------------------------------------------------------------------
#include "Roof_0.inc"
// --------------------------------------------------------------------------------------------
union{
box {<0,0,0>,< 5.00, Wall_Height,8.00> 
     texture{ pigment{ color White*1.1}
              normal { bumps 0.5 scale 0.005}
               finish {ambient 0.45 diffuse 0.55 phong 0.5}}}
//-------------------------------------------------------------------------------------// 
object{ Roof_0 (   35,    // Roof___Angle1, // roof angle                              
                    5.00, // Roof___WideX,  //   base length of the roof part in x-direction
                    8.00, // Roof___WideZ,  //   base length of the roof part in z-direction  
                   0.50,  // Roof___Over,     // overhang
                   0.075, // R_Cyl,          // radius cylinders
                   0.20,  // Cyl_D,         // distance cylinders
                   Roof_Texture1, // Roof___Texture1, // cylinder texture
                   Roof_Texture2  // Roof___Texture2  // base box texture
                ) //------------------------------------------------------ 
        translate<0,Wall_Height,0>}
//---------------------------------------------------------------------------------------
translate<0,0,0>
rotate<0,-35 ,0>
translate<0,0,0>
} // end of union
// --------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------// 
object{ Roof_0 (   45,    // Roof___Angle1, // roof angle                              
                    4.00, // Roof___WideX,  //   base length of the roof part in x-direction
                    4.00, // Roof___WideZ,  //   base length of the roof part in z-direction  
                   0.50,  // Roof___Over,     // overhang
                   0.075, // R_Cyl,          // radius cylinders
                   0.20,  // Cyl_D,         // distance cylinders
                   Roof_Texture1, // Roof___Texture1, // cylinder texture
                   Roof_Texture2  // Roof___Texture2  // base box texture
                ) //------------------------------------------------------  
        
rotate<0,0 ,0>
translate<-7,0.5,-2>}
//---------------------------------------------------------------------------------------
