// POV-Ray 3.6 / 3.7 Scene File "ladder.pov"
// author: Friedrich A. Lohmueller, 2001; updated Sept-2005/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage; ww.f-lohmueller.de 
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }

#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"

//--------------------------------------------------------------------------
// camera -----------------------------------------------------------
#declare Cam0 = camera {ultra_wide_angle angle 44 
                        location  <0.50 , 1.50 ,-6.00>
                        right     x*image_width/image_height
                        look_at   <0.00 , 1.60 , 0.00>}
camera{Cam0}
// sun ---------------------------------------------------------------
light_source{<500,2500,-2500> color White}
// sky ---------------------------------------------------------------
sphere{<0,0,0>,1 hollow 
              texture{pigment{gradient <0,1,0>
                              color_map{[0.0 color White]
                                        [0.5 color Navy ]
                                        [1.0 color Blue ]
                                        }
                              quick_color White }
                      finish {ambient 1 diffuse 0}
                     } 
       scale 10000}
//--------------------------------------------------------------------
fog{fog_type   2
    distance   40
    color      White
    fog_offset 0.1
    fog_alt    0.5
    turbulence 0.8}
// ground ------------------------------------------------------------
plane{<0,1,0>, 0 
       texture{Cork pigment{ quick_color Tan}
                    normal { bumps 0.5 scale 0.05}
                    finish { phong 0.1}}}
//--------------------------------------------------------------------
//------------------------------------------- dimensions of the ladder
#declare LR1 = 0.025;   // main radius
#declare LR2 = 0.010;   // diagonals radius 
#declare LW = 0.23-LR1; // half width (outline!)
#declare LH = 3.20;     // height
#declare Step_Distance = 0.25; 
//--------------------------------------------------------------------
#declare Texture_L =
 texture{pigment{ color White*1.1}
         finish { phong 1}}

//--------------------------------------------------------------------
//------------------------------------------------------- macro Ladder
#macro Ladder (R1_L,R2_L,W_L,H_L,Step_Dist, L_Texture) 
#local Step_Totals = int(H_L / Step_Dist);

#local Step = cylinder {<-W_L,0,0>,<W_L,0,0>,R2_L }
#local Nr = 0;              // start
#local EndNr = Step_Totals; // end

union{
 #while (Nr< EndNr) 
   object{ Step  translate<0,(Nr+0.5)*Step_Dist,0>} 

   #declare Nr = Nr + 1;  // next Nr
  
 #end // --------------- end of loop 

 cylinder {<0,0,0>,<0,H_L,0>,R1_L  
          translate<W_L,0,0>} 
 cylinder {<0,0,0>,<0,H_L,0>,R1_L  
          translate<-W_L,0,0>} 
texture{L_Texture}
}// end of union
#end // --------------- end of macro
//--------------------------------------------------------------------
//--------------------------------------------------------------------

object{ Ladder  (LR1,LR2,LW,LH,Step_Distance,texture{Texture_L}) } 
//---------------------------------------------------------------- end

