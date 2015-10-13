// POV-Ray 3.7 Scene File "sassafras_m000.pov"
// author: Friedrich A. Lohmueller, Oct-2013
// homepage: http://www.f-lohmueller.de
// demo file for using Albaro tree 
//  +w640 +h640
//--------------------------------------------------------------------------
#version 3.7;
global_settings{ assumed_gamma 1.0 } 
#default{ finish{ ambient 0.1 diffuse 0.9}}
//--------------------------------------------------------------------------
background {rgb <0.95,0.95,0.90>*0.8}
//--------------------------------------------------------------------------
light_source { < 2000,2000,-1500>, rgb 1.0 }            // sun 
light_source {  <0, 12, -30>     , rgb 0.2 shadowless } // flashlight
//--------------------------------------------------------------------------
camera{ 
        location <0, 12, -57>
        right    x*image_width/image_height
        angle 25  
        look_at <3, 12.00, 0> 
      }
//--------------------------------------------------------------------------
//-------------------------------------------------------------------<<<<<<<
// tree textures: ---------------------------------------
#declare Stem_Texture = 
 texture{ pigment{ color rgb< 0.75, 0.5, 0.3>*0.25 } 
          normal { bumps 0.75 scale <0.025,0.075,0.025> }
          finish { phong 0.2 reflection 0.00}         
        } // end of texture 
//------------------------------------------------------- 
#declare Leaves_Texture_1 = 
 texture{ pigment{ color rgbf< 0.2, 0.5, 0.0, 0.1>*0.75 }   
          normal { bumps 0.15 scale 0.05 }
          finish { phong 1 reflection 0.00}
        } // end of texture 
//-------------------------------------------------------- 
#declare Leaves_Texture_2 = 
 texture{ pigment{ color rgbf< 0.2, 0.5, 0.0, 0.2>*0.25 }   
          normal { bumps 0.15 scale 0.05 }
          finish { phong 0.2 reflection 0.00}
        } // end of texture 
//-------------------------------------------------------- 
//--------------------------------------------------------------------------
#include "sassafras_m.inc"
//#declare Tree_Height = sassafras_13_height; //  ~23.29, not used here!
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
      translate<0,0,0>
    } // end of union 
//--------------------------------------------------------------------------



//--------------------------------------------------------------------------
// tree without leaves
   object{ sassafras_13_stems
           texture{ Stem_Texture }
           scale 0.7 
           rotate <0,45,0>
           translate <11,0,0>
        } //------------------------
//--------------------------------------------------------------------------
 