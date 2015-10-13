// POV-Ray 3.7 Scene File "povca2.pov"
// author: Friedrich A. Lohmueller, 2003/Aug-2009/Jan-2011
// email: Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }}
global_settings { noise_generator 1 }

#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
// camera -----------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle 75
                            location  <0.0 , 1.0, -12.0>
                            right x*image_width/image_height
                            look_at <0.0 , 5.0, 0.0>}
#declare Camera_1 = camera {ultra_wide_angle angle 85
                            location   <-9, 14, -15>
                            right x*image_width/image_height
                            look_at   < -2, 3.0,-4.5>}
#declare Camera_2 = camera {ultra_wide_angle angle 75
                            location  < 10, 3, -11.0>
                            right x*image_width/image_height
                            look_at  < -3, 1, 0>}
camera{Camera_1}
// sun --------------------------------------------------------
light_source{<1500,2500,-2500> color White}
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
// ground ------------------------------------------------------------------
difference{plane{<0,1,0>, 0}
           box{<-15,-5,-15>,<15,1,15>}
       texture{ pigment { color rgb <0.85,0.55,0.30>}
                normal  { bumps 0.75 scale 0.025  }
                finish  { phong 0.1 }
              } // end of texture
     } // end of difference
// water -----------------------------------------------------
 box{<-15,-5,-15>,<15,-0.80,15>
   texture{T_Green_Glass pigment{quick_color Turquoise}
                   normal{ ripples 0.5 scale 0.25}
                   finish{ phong 0.1 }
          }
   interior{I_Glass}
    }
//--------------------------------------------------------------------------
//------------------------------------------------------------
#declare Walltex =  texture{ pigment{ color White}
                             finish { phong 1}}
#declare Rooftex =  texture{ pigment{ color rgb<0.3,0,0>}
                             finish { phong 1}}
// Mauern im Burggraben - Walls in the moat ------------------
#declare G_Wall =
box {<-15.3,-6,-0.3 >,< 15.3,  0.2,0.3> rotate<-5,0,0>
     texture{Walltex}}
// zeichne 4 GrabenMauern ----------------------------
object{G_Wall rotate<0,  0,0> translate<  0,-0.25,-15>}
object{G_Wall rotate<0,180,0> translate<  0,-0.25, 15>}
object{G_Wall rotate<0, 90,0> translate<-15,-0.25,  0>}
object{G_Wall rotate<0,-90,0> translate< 15,-0.25,  0>}
//----------------------- Turm  ------------------------------
#declare TR =  2.0;   //TurmRadius tower radius
#declare TH =  5.0;   //TurmHöhe   tower height
//------------------------------------------------------------
#declare Tower =  union{
cone{<0,-TH,0>,TR+1.0,<0,0,0>,TR   texture{Walltex}}
cylinder {<0,0,0>,<0,TH,0>,TR      texture{Walltex}}
cylinder {<0,0.0,0>,<0,0.1,0>,2.05 texture{Walltex}}
cylinder {<0,2.5,0>,<0,2.6,0>,2.05 texture{Walltex}}
cone{<0,0,0>,TR+0.5,<0,TR+0.5,0>,0
                    translate<0,TH,0> texture{Rooftex}}
cone{<0,0,0>,TR -0.2,<0,2*TR+0.5,0>,0
                    translate<0,TH,0> texture{Rooftex}}
}// --- Ende Turm-Definition -- end of Tower definition ------
//----- SchlossMauern - The walls of the castle --------------
#declare Wall = union{
  box {<-4,0,-0.3>,< 4,3.5,0.3> }
  box {<-4.5,-6,-0.3 >,<4.5,0,0.3> rotate<-5,0,0>}
  texture{Walltex}}
// - Zusammenbau des Schlosses --- Building of the castle ---
object{Tower translate<-6, 0,-6>}
object{Tower translate< 6, 0,-6>}
object{Tower translate< 6, 0, 6>}
object{Tower translate<-6, 0, 6>}
// ---------------- zeichne 4 Mauern -------------------------
difference{object{Wall} // das Tor -- the door -----
           box{<-1,0,-0.4>,<1,2,0.4>       texture{Walltex}}
           cylinder{<0,2,-0.5>,<0,2,0.5>,1 texture{Walltex}}
                             translate< 0,0,-6>}
object{Wall rotate<0,  0,0> translate< 0, 0, 6>}
object{Wall rotate<0, 90,0> translate<-6, 0, 0>}
object{Wall rotate<0,-90,0> translate< 6, 0, 0>}
// ------------------- Hof-Boden - Floor inside the castle --
box {<-6,-4,-6>,< 6,0.01,6>
     texture{pigment{color Gray90}
             finish {ambient 0.1 diffuse 0.9 phong 1}}}
//--------------------------------------------------------end-