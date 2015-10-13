// POV-Ray 3.6.2/3.7 Scene File "Cog_Wheel_1_demo.pov"
// created by  Friedrich A. Lohmueller, Febr 2010/Jan-2011
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}

//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "golds.inc"
#include "metals.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {location  <0.0 , 1.0 ,-5.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.05 , 0.0>
                            angle 28
                           }
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{< 1500,2500,-3500> color White}
// sky ---------------------------------------------------------------------
sky_sphere { pigment {  
                       color  rgb <1.0,1.0,1.0>       
                     } // end of pigment
           } //end of skysphere
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------











/* // declared in "Cog_Wheel_In_1.inc" and in "Cog_Wheel_1.inc" :
//---------------------------------------------------------------------
#macro Cog_Wheel_Radius (Cog_Number, Cog_Distance)  //-----------------  
  Cog_Distance*Cog_Number/(2*pi)
#end //----------------------------------------------------------------
*/
//---------------------------------------------------------------------
//---------------------------------------------------------------------
// optional textures !!!
#declare Gear_Texture_Blanc = 
        texture { Polished_Chrome 
                } // end of texture
#declare Gear_Texture_Raw = 
        texture { pigment{ color rgb<1,0.80,0.45>*0.8} 
                  normal { bumps 0.35 scale 0.005} 
                  //finish { phong 0.5 reflection{ 0.15 metallic 0.25} }
                } // end of texture
//---------------------------------------------------------------------
#include "Cog_Wheel_In_1.inc"
#include "Cog_Wheel_1.inc"    
// around y axis, symmetric to xz plane
// declares also macro 'Cog_Wheel_Radius (Cog_Number, Cog_Distance)' 
//---------------------------------------------------------------------
#local N_1 = 36; 
#local N_2 = 18; 
#local CD = 0.15; // cog distance 
#local CZ = 0.5;  // wheel thickness

#local Time = clock +0.5 ;

#local Turn =  Time*360/N_2;//  smallest
//---------------------------------------------------------------------
union{

 object{ Cog_Wheel_In_1 ( 36, CD, CZ) // Cog_Number, Cog_Distance, Gear_Y , 
         rotate<90,0,-Turn>
         translate<0,0,0>
       } //---------------------- 
 
 object{ Cog_Wheel_1    ( 18, CD, CZ) // Cog_Number, Cog_Distance, Gear_Y,
         rotate<90,0, 180/N_2 - 2*Turn>
         scale<0.98,0.98,1>
         translate<0.001+ Cog_Wheel_Radius(N_2,CD)-Cog_Wheel_Radius(N_1,CD),0,0>} 
 //--------------------------------------------------------------------
 rotate<0,0,30>
 rotate<40,-10,0> 
 translate<0.0,1.1,0>
 } // end of union
//---------------------------------------------------------------------
