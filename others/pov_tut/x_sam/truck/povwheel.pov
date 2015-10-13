// POV-Ray 3.6 / 3.7 Scene File "povwheel.pov"
// author: Friedrich A. Lohmueller,2003/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
// wheel - with and without #while statement
// Rad   - mit  und ohne #while-Anweisung
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
// camera ------------------------------------------------------------
#declare Cam0 =camera {/*ultra_wide_angle*/ angle 70
                       location  <0.0 , 1.0 ,-3.0>
                       right     x*image_width/image_height
                       look_at   <0.0 , 1.3 , 0.0>}
#declare Cam1 =camera {ultra_wide_angle angle 70
                       location  <3.0 , 1.0 , 0.0>
                       right     x*image_width/image_height
                       look_at   <0.0 , 1.0 , 0.0>}
camera{Cam0}
// sun -----------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky -----------------------------------------------------------------
sphere{<0,0,0>,1 hollow
       texture{pigment{gradient <0,1,0>
		       color_map{[0 color White]
                                 [1 color Blue ]}
		       quick_color White }
	       finish {ambient 1 diffuse 0} }  scale 10000}
// ground --------------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment {color rgb <0.80,0.55,0.35>}
                normal  {bumps 0.75 scale 0.035  }
                finish  {ambient 0.1 diffuse 0.8 } 
              } // end of texture
     } // end of plane
//==============================================================================
#declare Tire_tex  = texture{pigment{color Gray15}  // texture of tires  - Reifen
                             finish {ambient 0.05 diffuse 0.75 phong 0.1}}
#declare Spoke_tex = texture{Polished_Chrome        // texture of spokes and rim -Speichen
                             finish {ambient 0.05 diffuse 0.20 phong 1.0}}                        
//------------------------------------------------------------------------------
#declare Number_of_Spokes = 16; // number of spokes - Anzahl der Speichen

union{  // wheel
torus{0.9,0.20 scale <1,1,1> rotate<90,0,0>
         texture{Spoke_tex}} // Felge  - rim
torus{1.0,0.25 scale <1,1,1> rotate<90,0,0>
         texture{Tire_tex}} // Reifen - tire
cylinder {<0,0,-0.48>,<0,0, 0.48>,0.05 
         texture{Spoke_tex}}     // Rad-Nabe - hub
       //---------- while-Schleife -------------------------<<1
       // --> spokes
#declare Nr= 0;  #declare EndNr =  Number_of_Spokes/2;
#while ( Nr < EndNr )
  cylinder {<-1,0, 0>,<1,0, 0>,0.05
            rotate<0,0,180/EndNr*Nr>
            texture{Spoke_tex}}
  #declare Nr = Nr +1;
#end // ----------------------------------------------------<<2

translate<0,1.25,0> rotate<0,40,0>} //--- end of union 

//------------------------------------------------------------- end ----
//or from  "<<1" to "<<2" without while loop: -------------
//oder von "<<1" bis "<<2" ohne While-Schleife: -------------
/* #declare W = 360/ Number_of_Spokes;
union{ // --> spokes
 cylinder {<-1,0, 0>,<1,0, 0>,0.05 rotate<0,0, 0*W>}
 cylinder {<-1,0, 0>,<1,0, 0>,0.05 rotate<0,0, 1*W>}
 cylinder {<-1,0, 0>,<1,0, 0>,0.05 rotate<0,0, 2*W>}
 cylinder {<-1,0, 0>,<1,0, 0>,0.05 rotate<0,0, 3*W>}
 cylinder {<-1,0, 0>,<1,0, 0>,0.05 rotate<0,0, 4*W>}
 cylinder {<-1,0, 0>,<1,0, 0>,0.05 rotate<0,0, 5*W>}
 cylinder {<-1,0, 0>,<1,0, 0>,0.05 rotate<0,0, 6*W>}
 cylinder {<-1,0, 0>,<1,0, 0>,0.05 rotate<0,0, 7*W>}
 texture{Spoke_tex}}
*/
//------------------------------------------------------------- end ----

