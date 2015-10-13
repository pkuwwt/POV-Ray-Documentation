// POV-Ray 3.6 / 3.7 Scene File "povwend.pov"
// author: Friedrich A. Lohmueller, Aug-2005/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
// demonstrates: - while-loop,
// - intensiv using of #declare for all variable values, 
// - intersection with planes and bounding,
// - shadow-differenciated colors. 
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
 
#include "colors.inc"
#include "textures.inc"
// camera -----------------------------------------------------------
#declare Cam0 =camera {/*ultra_wide_angle*/ angle 60
                       location  <0.0 , 1.6 ,-6.5>
                       right     x*image_width/image_height
                       look_at   <0.0 , 2.0 , 0.0>}
camera{Cam0}
// sun --------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky --------------------------------------------------------------
sphere{<0,0,0>,1 hollow
       texture{pigment{gradient <0,1,0>
		       color_map{[0 color White]
                                 [1 color Blue ]}}
	    finish {ambient 1 diffuse 0} }             
       scale 10000}
// ground -----------------------------------------------------------
plane{ <0,1,0>, 0 
       texture{ pigment { color rgb <0.80,0.55,0.35>}
                normal  { bumps 0.75 scale 0.035  }
                finish  { phong 0.1} 
              } // end of texture
     } // end of plane
//===================================================================

//----- Stufensegment-Abmessungen -- dimensions of a step segment ------------
#declare StH = 0.10; // Stufenhöhe                  - step height 
#declare StT = 0.50; // Stufentiefe, maximal, außen - step deept max., outside
#declare StB = 1.20; // StufenBreite                - step width
#declare StI = 0.40; // StufenInnenRadius           - step inner radius
#declare St_N =  40; // Stufenanzahl                - number of steps
#declare W = 360/20; // Stufen Drehwinkel           - angle of steps
//----------------------------------------------------------------------------
#declare Stex1 = texture{pigment{ color White}
                         finish { phong 0.1}}
#declare Stex2 = texture{pigment{ color White}
                         finish { phong 0.1}}
#declare Step  = // die Stufe - the step ---------------------------------
intersection{
box  {<0,0,-StT>,< StB,StH,StT>   translate<StI,0,0> 
         texture{Stex1}}
plane{<0,0, 1>,0 rotate<0,-W/2,0> translate<0,0,0.0>
         texture{Stex2}}
plane{<0,0,-1>,0 rotate<0, W/2,0> translate<0,0,0.0>
          texture{Stex2}}
bounded_by{box  {<0,0,-StT>,< StB,StH,StT> translate<StI,0,0>}} 
}//------------- Ende Stufe - end of step --------------------------------

// ------------------ Zeichnen der Wendeltreppe --------------------------
// ------------------ Drawing the winding staircase ----------------------
union{
//------------------- While-Schleife - while loop ------------------------
#declare Nr = 0;  // Setzt den Zähler Nr auf Anfangswert
                  // start value of the counter Nr 

#while (Nr<St_N) // Prüft ob Endwert errreicht ist 
                 // checks if final value is reached   
   object{Step   // Objekt abhängig von Zählerstand 
                 // object depending on counter value Nr 
              translate<0,Nr*StH,0>
              rotate <0,-Nr*360/St_N*2,0>}
#declare Nr = Nr+1; // Erhöht den Zähler um 1 - increases the counter by 1
#end                // Ende der Schleife      -  end of loop
//------------------------------------------------------------------------
rotate<0,90,0> } 
//---------------------------------------------------------- end ---------






