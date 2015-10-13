//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
// PoVRay 3.7 Scene File "planet_00ani.pov"
// for use with animation ini file "planet_00ani.ini"
//
// A example of animated planets.
// author: Friedrich A. Lohmueller, June-2006/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//--------------------------------------------------------------------------
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

//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 55   // front view
                            location  <0.0 , 1.0 ,-50.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.0 , 0.0>}
#declare Camera_1 = camera {/*ultra_wide_angle*/ angle 45   //  
                            location  <25, 50,-35>
                            right     x*image_width/image_height
                            look_at  < 0, -4, 0> }
camera{Camera_1}

//-------------------------------------------------------------------------

 
// sun ---------------------------------------------------------------------
light_source{<1500,2500,-2500> color White*0.10}

// sky ---------------------------------------------------------------------
// the background stars -------------------------
#include "stars.inc"
sphere { <0,0,0>, 1  
         texture { // pigment{ Black} 
                   Starfield1 scale 0.25//  1, 2, ... , 6
                 } // end of texture
         scale 5000
       } //end of sphere


//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------



//------------------------------------------------------- dimensions
#declare Moon_Orbit_Radius   =  4; // real:     384 000 km
#declare Earth_Orbit_Radius  = 16; // real: 150 000 000 km
//------------------------------------------------------------------
#declare Moon_Radius   = 0.85 ;  // real:   1 738 km
#declare Earth_Radius  = 2.0;  // real:   6 378 km   flatness: 1/298
#declare Sun_Radius    = 4;    // real: 696 000 km 
//------------------------------------------------------------------


//---------------------------------------------------------- objects 

#declare Earth = 
sphere{<0,0,0>, Earth_Radius 
        texture{ Bright_Blue_Sky scale 0.25  
                normal {bumps 0.5 scale 0.05}
                }
      }
//-------------------------------------------
#declare Moon =
sphere{<0,0,0>, Moon_Radius
        pigment{color rgb<1,0.9,0.8>*1.1} 
        normal { granite 0.5  scale 0.5} 
      } 
//-------------------------------------------
#declare Sun =
 light_source{ <0,0,0> 
              color White
              looks_like{ 
                   sphere{ <0,0,0>,Sun_Radius
                           texture{ 
                            pigment{ gradient y turbulence 2.75
                                     color_map{ 
                                     [0.0 color rgb <1,0.7,0.5>]
                                     [0.3 color rgb <1,1,0.3>]
                                     [0.7 color rgb <1,0.8,0.2>]
                                     [1.0 color rgb <1,0.3,0.5>] } 
                                     scale 1.5
                                    } // end pigment
                            normal { agate 2.00 // bump depth
                                     scale 0.5 }
                            finish { ambient 0.9   
                                     diffuse 0.1
                                     phong 1     }
                         } // end of texture
                        } // end of sphere
                       } //end of looks_like
            } //end of light_source
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
#declare Time =  clock - 0.00 ;   // Time = 0 ~ 1 in 1 year !!!

//-----------------------------------------------------------------------------
// Rotations in the according orbits:
#declare Earth_around_Sun_Rotation  = 360*Time;      // 1 turn per year
#declare Moon_around_Earth_Rotation = 360*Time*12  ; // ~ 12 months 

// Rotations around their own axes: 
#declare Earth_Rotation = 360*Time*30;  //  ~360 days per year                  


//-----------------------------------------------------------------------------
//---------------------------------------------- the system:   
 


union{ // Earth + Moon 
       object{ Earth 
               rotate <0,Earth_Rotation,0>
             } // end Earth
       object{ Moon 
               translate<Moon_Orbit_Radius,0,0>
               rotate <0,Moon_around_Earth_Rotation,0>
             } // end Moon

   //(en) then both  (as union) moveded by Earth_Orbit_Radius away (in +x)
   //(de) dann beide (als union) um Erdbahnradius wegschieben

      translate<Earth_Orbit_Radius,0,0>
   //(en) and let them rotate around the sun
   //(de)  und um Sonne rotieren lassen
      rotate<0,Earth_around_Sun_Rotation,0>

     } // end of "union"  Earth + Moon       

object { Sun }

//----------------------------------------------------------------------------- end 
