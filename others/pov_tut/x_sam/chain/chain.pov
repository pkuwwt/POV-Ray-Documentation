// POV-Ray 3.6 / 3.7 Scene File "chain.pov"
// author:  Friedrich A. Lohmueller, 2005/Aug-2009/Jan-2011  
// email: Friedrich.Lohmueller_at_t-online.de
// http://www.f-lohmueller.de
//------------------------------------------------------------------------
#version 3.6; // 3.7 
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 
//------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
//------------------------------------------------------------------------
#declare Camera_1 = camera { ultra_wide_angle  
                             angle     48 
                             location  <7.7,8,-5.0>
                             right     x*image_width/image_height
                             look_at   <4.40, 0.00, 0.0>
                           }
camera{Camera_1}

//------------------------------------------------------------------------
// sun -------------------------------------------------------------------
light_source{<1500,2500,-2500> color White}
// sky -------------------------------------------------------------------
sky_sphere{ pigment{  color rgb<1,1,1> }} 
//------------------------------------------------------------------------
//---------------------------   scenery objects  -------------------------
//------------------------------------------------------------------------

#declare Metal_Texture =
         texture { pigment{ color rgb<1,1,1>*0.2}
                   normal { bumps 0.125 scale 0.015}
                   finish { phong 0.5 reflection 0.2}
                 } // end of texture
//------------------------------------------------------------------------

#declare R_minor = 0.25;
#declare R_major = 0.75;
#declare Half_L = 0.25; // Half length of the linear part!
#declare Link_Length =  2*(R_major);

#declare Left_Half =  
union{

 difference{
 torus { R_major, R_minor 
           rotate<90,0,0>  
       } // end of torus                

 box { <0,-R_major-R_minor,-R_minor>,< R_major+R_minor,R_major+R_minor,R_minor> 
     }// end of box
 
 translate<-Half_L,0,0>
 
 }// end of difference
 cylinder { <-Half_L,0,0>,<Half_L,0,0>, R_minor 
             translate<0,R_major,0>
         } // end of cylinder
}// end of union                      

# declare Chain_Link = 
union{
object{ Left_Half }
object{ Left_Half scale <-1,-1,1>}
        texture { Metal_Texture
                } // end of texture
} // end of Chain_Link 

union{
 #declare Nr = 0;     // start
 #declare EndNr = 6; // end
 #while (Nr< EndNr) 

   object{Chain_Link 
          #if ( int(Nr/2) != Nr/2 )
           rotate<90,0,0>
          #end
           translate < Nr*Link_Length ,0,0>
         } 

 #declare Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 

translate<0,0,0>} // end of union  ----------------------------------------end

 
 
