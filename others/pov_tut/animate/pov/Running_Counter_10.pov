// POV-Ray 3.7 Scene File "Running_Counter_10.pov"
// author: Friedrich A. Lohmueller, May-2009/Aug-2009/Jan-2011
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
//--------------------------------------------------------------------------------------------------------<<<<
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------- Camera_Position, Camera_look_at, Camera_Angle
#declare Camera_Number = 1 ;
//--------------------------------------------------------------------------------------------------------<<<<
#switch ( Camera_Number )
#case (0)
  #declare Camera_Position = < 0.65, 0.40, -2.00> ;  // front view
  #declare Camera_Look_At  = < 0.65, 0.40,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#case (1)
  #declare Camera_Position = < 0.625, 0.35, -2.00> ;  // front view
  #declare Camera_Look_At  = < 0.625, 0.35,  0.00> ;
  #declare Camera_Angle    =  33 ;
#break
#else
  #declare Camera_Position = < 2.00, 1.50, -2.00> ;  // diagonal view
  #declare Camera_Look_At  = < 0.50, 0.40,  0.00> ;
  #declare Camera_Angle    =  45 ;
#break
#end // of "#switch ( Camera_Number )" -----------------------------
//------------------------------------------------------------------ 
camera{ // ultra_wide_angle
        location Camera_Position
        right    x*image_width/image_height
        angle    Camera_Angle
        look_at  Camera_Look_At
      }
//-------------------------------------------------------------------------------------------------------<<<<<
//--------------------------------------------------------------------------------------------------------<<<<
//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky -------------------------------------------------------------------
sky_sphere{ pigment{ gradient <0,1,0>
                     color_map{ [0   color rgb<1,1,1>         ]//White
                                [0.4 color rgb<0.14,0.14,0.56>]//~Navy
                                [0.6 color rgb<0.14,0.14,0.56>]//~Navy
                                [1.0 color rgb<1,1,1>         ]//White
                              }
                     scale 2 }
           } // end of sky_sphere
//------------------------------------------------------------------------

//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//------------------------ textures
#declare Number_Texture = 
  texture{ 
     pigment{ color rgb<1,1,1>*1.5}
     finish {  phong 1}
   } // end of texture 
#declare Background_Texture =
  texture{ 
     pigment{ color rgb<1,1,1>*0.05}  
     finish { phong 1 reflection 0.1}
   } // end of texture 
//-----------------------------------


//-----------------------------------
//-----------------------------------
#declare Number = 
         99-frame_number;
// splitting it in two parts:
#declare Number_10 = 
         int(Number/10);  
#declare Number_1 = 
          (Number-Number_10*10 );  
//-----------------------------------
#declare Text_10 = 
text { ttf "arial.ttf",
     str(Number_10,0,0),0.001,0
     pigment{ color rgb<1,1,1> }
     translate<0,0,-0.001>
   } // end of text object ----------
//-----------------------------------
#declare Text_1 = 
text { ttf "arial.ttf",
     str(Number_1,0,0),0.001,0
     pigment{ color rgb<1,1,1> }
     translate<0,0,-0.001>
   } // end of text object ----------
//-----------------------------------
//-----------------------------------
union{
//----------------------------------- 
 box  { <0,0,0>,< 1.25,1,0.01>
        texture{ Background_Texture } 
      } // --------------------------
 // don't write things like "08" !
 #if(Number>9)// --------------------
 object{ Text_10 
         texture{ Number_Texture }  
         scale <1,1,1>
         rotate< 0,0,0>
         translate< 0.125,0.2,0>
       } // -------------------------  
 #end //-----------------------------

 object{ Text_1 
         texture{ Number_Texture }  
         scale <1,1,1>
         rotate< 0,0,0>
         translate<0.675,0.2,0>
       } // ------------------------- 
scale <1,0.65,1>
rotate< 0,0,0>
translate< 0, 0,0>
} // end union ----------------------                                         
//-----------------------------------

