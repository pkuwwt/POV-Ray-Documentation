// PoVRay 3.6 / 3.7 Scene File "Column_Kernel_01_1.pov"
// author: Friedrich A. Lohmueller, Dec-2006 /Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
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
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 90   // diagonal view
                            location  <2.0 , 2.5 ,-3.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_2 = camera {/*ultra_wide_angle*/ angle 90 // right side view
                            location  <3.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {/*ultra_wide_angle*/ angle 90        // top view
                            location  <0.0 , 3.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{<-1500,2500,-2500> color White}
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
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment{ color rgb <0.825,0.57,0.35>}
                normal { bumps 0.75 scale 0.025  }
                finish { phong 0.1 } 
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



// ------------------------------------------------------------- A Ripped Column Kernel                                 
// ---------------------------------------------------- "Column_01(...)" marcro 
#macro Column_Kernel_01 (  Column_Kernel_Height___, // 
                           Column_Subdivision___,  //  
                           C_Base_Radius___, 
                           C_Top_Radius___ 
                        ) //---------------------------------
//------------------------------------------------------------------------------------
#local Rip_Top_R___  = 2*pi*C_Top_Radius___ /Column_Subdivision___*1/sqrt(2); 
#local Rip_Base_R___ = 2*pi*C_Base_Radius___/Column_Subdivision___*1/sqrt(2);
#local Rip_Top_Distance___ = C_Top_Radius___  +Rip_Top_R___ *1/sqrt(2);
#local Rip_Base_Distance___= C_Base_Radius___ +Rip_Base_R___*1/sqrt(2);
#local R_over = +Rip_Base_R___*0.1; 

// ----------------------------------------------------------------------------------- 
difference{ // column kernel
cone { <0,0,0>,C_Base_Radius___,<0,Column_Kernel_Height___,0>,C_Top_Radius___ 
     } // end of cone -----------------------------------
 
 #local Nr = 0;     // start
 #local EndNr = Column_Subdivision___; // end
 #while (Nr< EndNr) 
 cone{ <Rip_Base_Distance___,-R_over,                          0>, Rip_Base_R___,
       <Rip_Top_Distance___ , Column_Kernel_Height___ + R_over,0>, Rip_Top_R___
       rotate<0,Nr * 360/EndNr,0>      
     } // end of cone -----------------------------------
 #local Nr = Nr + 1;    // next Nr
 #end // ---------------  end of loop 
 

} // end of difference 
#end //------------------------------------------------------------------ end of macro
//------------------------------------------------------------------------------------




//-----------------------------------------------------------------------
//-----------------------------------------------------------------------
#declare Stone_Texture = // Column kernel stone texture
         texture { T_Grnt16
                   normal { agate 0.35 scale 0.05}
                   finish { phong 0.2 } 
                   scale 1 
                 } // end of texture 

#declare Column_Kernel_Texture = // with vertical subdivisions 
        texture { gradient<0,1,0> scale <1,0.67,1> turbulence 0.01  
                   texture_map{ [0.00 Stone_Texture ]
                                [0.001 pigment{ color rgb <1,1,1>*0.1} ]
                                [0.005 pigment{ color rgb <1,1,1>*0.1} ]
                                [0.006 Stone_Texture ]
                                [1.00 Stone_Texture ]
                              } // end of texture_map      
                 } // end of texture ------------------------------------ 
//-----------------------------------------------------------------------

//-----------------------------------------------------------------------
object{ Column_Kernel_01 ( 2.00, // Column_Total_Height,  // 
                           16,   // Column_Subdivision, // integer ~ 16
                           0.30, // Column_Base_Radius, 
                           0.20  // Column_Top_Radius,  
                  ) //---------------------------------

        texture { Column_Kernel_Texture}  
        scale<1,1,1>  rotate< 0,0,0>  translate<0,0,0>  
      } // end of "Column_01(...) --------------------------------------- 
//------------------------------------------------------------------- end 








