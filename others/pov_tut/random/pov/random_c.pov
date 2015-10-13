// POV-Ray 3.7 Scene File "random_c.pov"
// author: Friedrich A. Lohmueller, 2004/Aug-2011/Jan-2013
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_Position_1 = <0.0 , 12.0 , -10>;
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 72     // for a quadratic aspect ratio!!!
                            location  Camera_Position_1
                            right     x*image_width/image_height
                            look_at   <-1.1  ,2.0  , 2 >}
camera{Camera_1}
// sun ---------------------------------------------------------------------
light_source{Camera_Position_1 color rgb<0.9,0.9,1.0>*0.2}

light_source{<800,2500,-1500> color White*0.8}
// sky ---------------------------------------------------------------------
plane{<0,1,0>,1 hollow
       texture{ pigment{ bozo turbulence 0.76
                         color_map { [0.5 rgb <0.20, 0.30, 0.8>*0.3]
                                     [0.6 rgb <1,1,1>]
                                     [1.0 rgb <0.5,0.5,0.5>]}
                       }
                finish {ambient 1 diffuse 0} }
       scale 10000}
// fog ---------------------------------------------------------------------
/*
fog{fog_type   2
    distance   100
    color      White
    fog_offset 0.1
    fog_alt    4.0
    turbulence 0.8}
*/
// ground ------------------------------------------------------------------
plane { <0,1,0>, 0
         texture { pigment{ color rgb< 1, 1, 1>*0.25 } //  color Gray50
                // normal { bumps 0.5 scale 0.05 }
                 } // end of texture

      } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------


// Choosing random series:
#declare Random_1 = seed(113);
#declare Random_2 = seed(5780);
#declare Random_3 = seed(12);

union{
 #declare NrX = -5;   // start x
 #declare EndNrX = 5; // end   x
 #while (NrX< EndNrX+1)
    // more inner loop
    #declare NrY = -2.5;  // start y
    #declare EndNrY = 2.5;// end   y
    #while (NrY< EndNrY+1)
       // innerst loop
       #declare NrZ = -3;   // start z
       #declare EndNrZ = 3; // end   z
       #while (NrZ< EndNrZ+1)

       sphere{ <0,0,0>,0.45
               scale < 1, 0.1+ (rand(Random_1)*2),1 >


               translate<  NrX*1.2+(0.5-rand(Random_2)),
                           NrY*1+(0.5-rand(Random_2))/2,
                           NrY*0.6+NrZ*1.5+(0.5-rand(Random_2))/2 >

               texture{ pigment{color rgb< 1 ,
                                           (0.5+rand(Random_2)/2) ,
                                           (rand(Random_3)/5)
                                         > } // end of pigment
                                 finish { phong 1}}

               }// end of sphere
       #declare NrZ = NrZ + 1;  // next Nr z
       #end // --------------- end of loop z
       // end innerst loop
    #declare NrY = NrY + 1;  // next Nr y
    #end // --------------- end of loop y
    // end more inner loop
 #declare NrX = NrX + 1;  // next Nr x
 #end // --------------- end of loop x
 // end of outer loop
rotate<0,-45,0>
translate<0,5,2>} // end of union

//-------------------------------------------------------end