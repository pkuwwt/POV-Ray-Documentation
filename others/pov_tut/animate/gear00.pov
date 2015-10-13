// POV-Ray 3.6 Scene File " ... .pov"
// created by   ...  
// Date:   ...
//--------------------------------------------------------------------------
#version 3.6;
global_settings {  assumed_gamma 1.3 }
global_settings { max_trace_level 10 }//(1...20) [default = 5]

//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "golds.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle 37          // front view
                            location  <0.0 , 1.0 ,-5.0>
                            right     x*image_width/image_height
                            look_at   <0.0 , 1.0 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{< 1500,2500,- 3500> color White}
// sky ---------------------------------------------------------------------
sky_sphere { pigment {  
                       color  rgb <1.0,1.0,1.0>       
                     } // end of pigment
           } //end of skysphere
/*
// fog ---------------------------------------------------------------------
fog{fog_type   2
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
*/
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------












//#local Zahn_Zahl = 36;
//#local Zahnrad_Dicke = 0.05;
//#local Zahn_Abstand = 0.15;


#macro Gear (Cog_Number, Cog_Distance, Gear_Z) // around the y axis 
//#macro Zahnrad (Zahn_Anzahl, Zahn_Distanz, Zahnrad_Z) // um die y-Achse  
#local D = 0.0001;
//#local Zahnrad_Umfang = Zahn_Abstand*Zahn_Anzahl;
//#local Zahnrad_Radius = Zahnrad_Umfang/(2*pi); 
#local Gear_Circumference = Cog_Distance*Cog_Number;
#local Gear_Radius_ = Gear_Circumference/(2*pi); 
 
union{
 // kernel of the gear minus notches
difference{
 cylinder { <0,0,0>,<0,Gear_Z,0>,Gear_Radius_ 
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         } // end of cylinder
 torus { Gear_Radius_/2,Gear_Radius_/4  
         scale <1,0.1,1> translate<0,0,0>
       } // end of torus  -------------------------------              
 torus { Gear_Radius_/2,Gear_Radius_/4  
         scale <1,0.1,1> translate<0,Gear_Z,0>
       } // end of torus  -------------------------------              
 #local Nr = 0;     // start
 #local EndNr = Cog_Number; // end
 #while (Nr< EndNr) 
    cylinder { <0,0-D,0>,<0,Gear_Z+D,0>,Cog_Distance/4
               scale<1.5,1,1>
               translate<Gear_Radius_,0,0> 
               rotate<0,(Nr+0.5) * 360/EndNr,0>  
               } // end of cylinder -----------------------------------
 #local Nr = Nr + 1;    // next Nr
 #end // ---------------  end of loop 
          } // end of difference ---------------
 // adding the cogs
 #local Nr = 0;     // start
 #local EndNr = Cog_Number; // end
 #while (Nr< EndNr) 
    cylinder { <0,0,0>,<0,Gear_Z,0>,Cog_Distance/4
               scale<1.3,1,1>
               translate<Gear_Radius_,0,0> 
               rotate<0,Nr * 360/EndNr,0>  
               } // end of cylinder -----------------------------------
 #local Nr = Nr + 1;    // next Nr
 #end // ---------------  end of loop 
 cylinder { <0,-0.05,0>,<0,Gear_Z+0.05,0>,Gear_Radius_/4 
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
         } // end of cylinder

 cylinder { <0,-0.10,0>,<0,Gear_Z+0.10,0>,Gear_Radius_/10 
           scale <1,1,1> rotate<0,0,0> translate<0,0,0>
          } // end of cylinder



} #end // end of union and end of macro -------------------------------

#macro Gear_Radius (Cog_Number, Cog_Distance)  //----------------------
  Cog_Distance*Cog_Number/(2*pi)
#end //----------------------------------------------------------------


union{
object{ Gear ( 36, 0.15, 0.5) 
        texture { T_Gold_2E
                  finish { ambient 0.15 diffuse 0.85 phong 0.5 reflection 0.40}
                } // end of texture
        rotate<90,0,0>
        rotate<0,0,-clock*360/18>
        translate<0,1,0>} // end of union

object{ Gear ( 18, 0.15, 0.45) 
        texture { T_Gold_2E 
                   finish { ambient 0.15 diffuse 0.85 phong 0.5 reflection 0.40}
                } // end of texture
        rotate<90,0,180/18>
        rotate<0,0,2*clock*360/18>
        translate<-Gear_Radius(18,0.15)-Gear_Radius(36,0.15),1,0.025>} // end of union
 rotate<0,0,20>
 rotate<0,-45,0> 
 translate<1,0.1,0>
 }
