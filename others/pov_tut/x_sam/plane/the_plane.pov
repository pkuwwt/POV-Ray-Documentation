// POV-Ray 3.6 / 3.7 Scene File "the_plan.pov"
// author: Friedrich A. Lohmueller, 2002/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// http://www.f-lohmueller.de/
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
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle 35          // front view
                            location  <0.0 , 1.0 ,-30.0>
                            right     x*image_width/image_height
                            look_at   <-3.0 , 1.0 , 0.0>}
#declare Camera_1 = camera {ultra_wide_angle angle 30       // diagonal view
                            location  <22.0 , 22.5 ,-23.0>
                            right     x*image_width/image_height
                            look_at   <-2.0 , 1.0 , -1.0>}
#declare Camera_2 = camera {ultra_wide_angle angle 90     // right side view
                            location  <23.0 , 1.0 , 0.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
#declare Camera_3 = camera {ultra_wide_angle angle 90            // top view
                            location  <0.0 , 23.0 ,-0.001>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{< 1500,2500,-2500> color White}
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
    distance   200
    color      White
    fog_offset 0.1
    fog_alt    1.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, -5 
       texture{ pigment {color rgb <0.85,0.6,0.4>}
                normal  {bumps 0.75 scale 0.025  }
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- scenery objects -----------------------------
//--------------------------------------------------------------------------
#local Skin  = 0.05; // the thickness of the skin
#local G     = 0.005; // the thickness of the windows
#local R_W   = 0.35; // radius of the passenger's Windows
//-------------------------------------------------------
#local R1  = 2.00;  // radius of the body outside Radius 
#local R2  = 1.25;  // radius nose top y          Radius_Nose_TopY 
#local R3  = 4.00;  // length nose                Length_Nose
#local R4  = 2.50;  // length forehead part       Length_Forehead
#local R5  = 9.50;  // length of tail part        Length_Tail
//-------------------------------------------------------------------
#macro Radial_Rotor_TextureX (Number_of_Radial_Stripes)
 radial 
 frequency Number_of_Radial_Stripes // = number of blades
 rotate<90,0,0> 
 texture_map { [0.00  pigment {color rgbt<1,1,1,0.5>} 
                      finish  {ambient 0.15 diffuse 0.85 
                               phong 0.1}]
               [0.60 pigment{color Clear}]
               [1.00 pigment{color Clear}]
             }
#end //----------------------------------- other textures 
#declare Blades_Texture =
    texture { Chrome_Metal
              finish { phong 1}}
#declare Engine_Texture =
    texture { pigment{color rgb<1,1,1>} 
              finish { phong 1}}
//-------------------------------------------------------

#macro Engine(Number_Blades, B_Length, R_Angle, Activate_B)
union{  // --------------------- the casing of the engine 
   torus{1.0,0.175 rotate<90,0,0> 
         scale <1,1,5>*0.35 
         texture{Engine_Texture}
         translate<0,0,-0.3>  
        }  // end of torus  
   difference {
         sphere { <0,0,0>,1 scale <0.35,0.35,1.3>
                  translate<0,0,0.5>}
         box    { <-1,-1,-1.2>,<1,1,-0.48>}
         texture{Engine_Texture}
      }
   union{  // propeller
     cylinder{ <0,0,-0.01>,<0,0,1.00>,0.10}// propeller axis
     difference{ sphere{<0,0,0>, 1}        // propeller nose  
                 box {<-1,-1,-0.1>,<1,1,1>}
                 scale <1,1,2.5>*0.3 
                 translate<0,0,0.2>
                 texture{Blades_Texture}
               }
     union{  // --------------------------------- the blades
       #declare Nr = 0;
       #declare End = Number_Blades; 
       #while ( Nr < End) 
       sphere { <0,0,0>,0.5  
                scale <1,0.15,0.04>
                translate <0.5,0,0> 
                rotate <10,0,0>
                scale B_Length // = Blade_Radius
                texture {Blades_Texture}
              rotate< 0,0, 360/End * Nr > 
            } 
       #declare Nr = Nr + 1; 
       #end // end of #while ------------------------------
       
       #if (Activate_B = 1) // --------------------------- blur
       cylinder { <0,0,0>,<0,0,0.001>, B_Length 
                  texture{ Radial_Rotor_TextureX(Number_Blades)} 
                  rotate <0, 0,0> 
                  translate <0,0, 0.025>
                } 
       #end // end of #if (Activate_B = 1) ---------------------
     }                             // end of union of the blades

     translate<0,0,-0.7>
     rotate<0,0,R_Angle>
   } // --------------------------------- end of union "Propeller"

} // --------------------------------------- end of union engine
#end // -------------------------- end of macro "Engine ( ... )"



 
//--------------------------------------------------------------------
#macro Body(Radius, Radius_Nose_TopY, Length_Nose, Length_Forehead, 
            Length_Tail)
union{
intersection{                                 //  nose lower part (1)
 sphere { <0,0,0>,1  scale <Length_Nose, Radius, Radius>}
 box    { <0,-1,-1>,<1,0,1> scale <Length_Nose, Radius, Radius>} 
 }// -------------- end of intersection    

intersection{                             // nose - forehead part (2)
 sphere { <0,0,0>,1  scale < Length_Forehead, Radius, Radius>}
 box    { <0,0,-1>,<1,1,1>  scale < Length_Forehead, Radius, Radius>} 

 }// -------------- end of intersection    
intersection{                            // nose front upper part (3)
 sphere { <0,0,0>,1  scale <Length_Nose, Radius_Nose_TopY, Radius>}
 box    { <0,0,-1>,<1,1,1> scale <Length_Nose, Radius, Radius>} 
 }// -------------- end of intersection    

intersection {                        // the tail of the airplane (4)
 sphere { <0,0,0>,1    scale < Length_Tail, Radius, Radius> }
 box    { <-1,-1,-1>,<0,1,1> scale < Length_Tail, Radius, Radius>} 
 }// -------------- end of intersection    
}// end of union
#end // ---------------------------------- end of macro "Body( ... )"

//-----------------------------------------------------------------
#declare Windows_Cut_Cockpit = //prisms for cutting out the windows
union{
prism { -R1-G, R1-2*G, 5 //side window 1
       < 0.50, 0.50>,< 1.30, 0.70>,< 1.00, 1.33>,
       < 0.40, 1.30>,< 0.50, 0.50>
       rotate<-90,0,0>scale<1,1,-1> }//turns prism in z direction! 

prism { -R1-G, R1-2*G, 6  //side window 2
       < 1.35, 0.72>,< 1.95, 0.99>,< 1.76, 1.17>,
       < 1.52, 1.37>,< 1.05, 1.33>,< 1.35, 0.72>
       rotate<-90,0,0>scale<1,1,-1> }//turns prism in z direction! 

prism {  -R1-0.1 ,R1+0.1 , 5 // right side font glass
       <-0.65, 1.02>,<-0.04, 1.10>,<-0.04, 1.40>,
       <-0.70, 1.39>,<-0.65, 1.02>
       rotate<-90,-90,0>} //turns prism in x direction! 

prism {  -R1-0.1 ,R1+0.1 , 5 // left side font glass
       <-0.65, 1.02>,<-0.04, 1.10>,<-0.04, 1.40>,
       <-0.70, 1.39>,<-0.65, 1.02>
       rotate<-90,-90,0> //turns prism in x-direction! 
       scale<1,1,-1>}    // mirrored at the xy plane 

 } // end of union
//-------------------------------------------------------------------
#declare Windows_Cut_Passenger = // cylinders for cutting out the 
 union{                                   // passenger windows
   cylinder{ <0,0,-1.1*R1>,<0,0,1.1*R1>, R_W  
            }
   cylinder{ <0,0,-1.1*R1>,<0,0,1.1*R1>, R_W
             translate<-1.50, 0, 0>}
   cylinder{ <0,0,-1.1*R1>,<0,0,1.1*R1>, R_W
             translate<-3.00, 0, 0>}
 } // end of union
//-------------------------------------------------------------------

//-----------------------------------------------------------------
#declare Tail_Wing_Y = 
union{
 cone  { <0,0,0>, 1.50, <0, 3.50,0>, 0.80}
 sphere{ <0,0,0>, 0.80  scale<1,0.15,1> translate<0,3.50,0>}
 scale <1,1,0.15>
 matrix<     1, 0, 0, // shearing in x direction
         -0.30, 1, 0,
             0, 0, 1,
             0, 0, 0>
  }//----------- end of union -------------------------------------
#declare Wing = 
union{
 cone  { <0,0,0>, 2.40,<0,9.50,0>, 1.00}
 sphere{ <0,0,0>, 1.00 scale<1,0.15,1> translate<0,9.50,0>}
 scale <1,1,0.15>
 matrix<     1, 0, 0, //Shearing in X direction
          0.10, 1, 0,
             0, 0, 1,
             0, 0, 0>
  }//-----------  end of union ------------------------------------


//--------------------------------------------------------- tail unit
#declare Tail_Unit = 
union{ object{ Tail_Wing_Y }
       object{ Tail_Wing_Y rotate< 80,0,0> }
       object{ Tail_Wing_Y rotate<-80,0,0> }
       translate<1.50, 0,0>
     } // end of union
//------------------------------------------------------------- wings
#declare Wings = 
union{ object{ Wing  rotate< 83,0,0>}
       object{ Wing  rotate<-83,0,0>}
     } // end of union
//-------------------------------------------------------------------
 


//---------------------------------------------------------- textures
#declare A_Tex = texture { pigment{ color Silver}
                           finish { phong 1}
                         }                   // airplane body texture

#declare A_Glass =  texture{NBbeerbottle}    // airplane window glass
        
//-------------------------------------------------------------------
union{           // ----- the body of the airplane with windows

  difference {   // body caved out and with holes for the windows      
    object { Body(R1, R2, R3, R4, R5) }
    object { Body(R1-Skin, R2-Skin, R3-Skin, R4-Skin,R5-Skin)}
    object { Windows_Cut_Cockpit }
    object { Windows_Cut_Passenger
             rotate<0,0,3>  translate< -1-0.00, 0.25*R1, 0>}
    texture{A_Tex}
  }// end of difference 

  difference {   // the glass layer 
    object { Body(R1-G, R2-G, R3-G, R4-G, R5-G)}
    object { Body(R1-2*G, R2-2*G, R3-2*G, R4-2*G,  R5-2*G)} 
    texture{A_Glass}
  }// end of difference 
 
rotate<0,0,0>
translate<0,0,0>
}
//------------------------------------------------------------------- 


//-------------------------------------------------------------------
  object { Tail_Unit
           translate< -R5,0,0>
           texture{A_Tex}
         }
  object{ Wings  rotate<0,0,5>
          translate<-2.50,-1.30,0>
          texture{A_Tex}
        }
//-------------------------------------------------------------------

//---------------------------------------------------------------
//#macro{ Engine(Number_of_Blades, Blade_Radius, Rotation_Angle, Rotor_On)

 object{ Engine( 5, 2.35, 10, 1)
         scale 0.85
         rotate <0,-90,0>
         translate <-0.30,-0.70,-5.00>
       }

 object{ Engine( 5, 2.35, 10, 1)
         scale 0.85 
         rotate <0,-90,0>  scale <1,1,-1>
         translate <-0.30,-0.70,-5.00>
         scale <1,1,-1>
       }
//---------------------------------------------------------------
