// PoVRay 3.7 Scene File "Plane_00demo.pov"
// author: Friedrich A, Lohmueller, Jan-2006/Aug-2009/Jan-2011
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
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
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 13   // diagonal view
                            location <-17.25 , 2.65 ,-70.0>
                            right     x*image_width/image_height
                            look_at   <-5.15 , 5.25 , 30.0>}
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
light_source{<-1500,2500,-2500> color White}

// sky -------------------------------------------------------------- 
plane{<0,1,0>,1 hollow  
       texture{ pigment{ bozo turbulence 0.92
                         color_map { [0.00 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.60 rgb <0.20, 0.20, 1.0>*0.9]
                                     [0.70 rgb <1,1,1>]
                                     [0.85 rgb <0.25,0.25,0.25>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                        scale<1,1,5.5>*1.5  translate<2,0,35>
                       }
                finish {ambient 1 diffuse 0} }      
       scale 10000}
// fog on the ground -------------------------------------------------
fog { fog_type   2
      distance   1000
      color      White*0.7  
      fog_offset 0.1
      fog_alt    7.5
      turbulence 0.8
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
















//----------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------- textures
#declare APlane_Outside_Texture =       
    texture { pigment{color Silver}
              finish { phong 1} }

#declare APlane_Wings_Texture =          
    texture { pigment{color Silver}
              finish { phong 1} } 
 
#declare  APlane_Inside_Texture=                
    texture { pigment{color White}
              finish { phong 1 } } 
              
#declare Window_Glass =                       
     texture{  NBbeerbottle }    
            
#declare Blades_Texture =                     
    texture { Chrome_Metal
              finish { phong 1}}

#declare Engine_Texture =                      
    texture { APlane_Outside_Texture }

#declare Undercarriage_Metal =                   
    texture { pigment { color Silver}
              finish  { phong 1}}

#declare Pneu_Texture = 
    texture { pigment{ color Gray20}         
              finish { phong 1}}

//---------------------------------------------------------------------------------------------
#include "Plane_00.inc" 
//------------------------------------------------------// 
object{ Plane_00(   5, // Number_of___Blades,             
                    10,// Rotation_Angle___Right, //
                    15,// Rotation_Angle___Left, //
                    1, // Rotor_On___Right, // activates rotation blur 
                    1, // Rotor_On___Left, // activates rotation blur 
                 
                    Window_Glass,  // glass texture without interior
                    APlane_Outside_Texture // airplane texture of the outside, 
                    APlane_Inside_Texture, // airplane inside texture
                   
                    Blades_Texture, //
                    Engine_Texture, //
                    Undercarriage_Metal, //
                    Pneu_Texture, //  
                 ) //------------------------------------------------------------ 
        // Length over ground:  from x = -10.25 to x = +3.75 
        // total Length over ground 14.00 ; 
        // Height = 4.00 ;  
        rotate<0,0,10>  // fix rotation for tail wheel touch down 
        translate<0.50,3.00, 0.00>  // fix height for all wheels on the ground 
        //-----------------------------------------------------------------------
        scale 1
        // rotate<0,0,-10> // starting
        
        rotate<0, 90-10,0> translate<-3,0,30> }
//--------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------
//-------------------------------------------------------------------------------------// 
#include "Street_10.inc"  // street with center stripes with continuous border lines
//-------------------------------------------------------------------------------------// 
object{ Street_10( 28,     // Street_Widthm, // 
                   1000 , // Street_Length, //
                   0.50,  // Stripes_Width, // 
                   4.00,  // Stripes_Length // = 0 => continuous line!!!                                
                 ) //------------------------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00,   -50.00>}
//-------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------

//---------------------------------------------------------------//
#declare Zebra_Texture = 
         texture { pigment{ color rgb< 1, 1, 1>*1.1 } 
                // normal { bumps 0.5 scale 0.05 }
                   finish { diffuse 0.9 phong 1 reflection 0.00}
                 } // end of texture 
//---------------------------------------------------------------//
#include "Zebra_Stripes_000.inc"
//---------------------------------------------------------------//
object{ Zebra_Stripes_000( 1.80, // Zebra_Stipe___Width, 
                           20.00, // Zebra_Stipe___Length, 
                           7, // Numbers_of___Stripes,
                           1  // Symmetric___On
                         ) //-----------------------------------//
         texture { Zebra_Texture }  
         rotate<0,0,0> 
         scale <1,1,1>
         translate<0,0.05,35> 
      } //------------------























