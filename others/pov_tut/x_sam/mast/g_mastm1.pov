// POV-Ray 3.6 / 3.7 Scene File "g_mastm1.pov"
// author: Friedrich A. Lohm�ller, 2005/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"
// camera -----------------------------------------------------------
#declare Cam0 = camera {ultra_wide_angle angle 70 
                        location  <0.50 , 1.00 ,-7.00>
                        right     x*image_width/image_height
                        look_at   <0.00 , 1.00 , 0.00>}
#declare Cam1 = camera {//ultra_wide_angle angle 180 
                        angle 84
                        location  <5.0 , 15.5 ,-4.0> *1.2
                        right     x*image_width/image_height
                        look_at   <1.0 , 11.5 , 0.75>}
camera{Cam1}
// sun ---------------------------------------------------------------
light_source{<500,2500,-2500> color White}
// sky ---------------------------------------------------------------
sphere{<0,0,0>,1 hollow 
              texture{pigment{gradient <0,1,0>
                              color_map{[0 color White]
                                        [1 color Blue ]}
                              quick_color White }
                      finish {ambient 1 diffuse 0}
                     } 
           scale 10000}
fog{fog_type   2
    distance   40
    color      White
    fog_offset 0.1
    fog_alt    0.5
    turbulence 0.8}


// ground ------------------------------------------------------------
plane{<0,1,0>, 0 
       texture{ pigment{ color rgb <0.825,0.57,0.35> quick_color Tan}
                normal { bumps 0.5 scale 0.05}
                finish { phong 0.1}
              }
     }
//--------------------------------------------------------------------
//--------------------------------------------------------------------
#declare R1 = 0.050; // main radius
#declare R2 = 0.025; // diagonals radius 
#declare W = 1.00-R1;// half width (outline!)
#declare H = 2.00;   // height

//--------------------------------------------------------------------
#declare Texture1 =
 texture{pigment{ color White}
         finish { phong 1}}
#declare Texture2 =
 texture{pigment{ color White*0.7}
         finish { phong 1}}

//--------------------------------------------------------------------
//--------------------------------------------------------------------
#macro Square_Quart (R1_, W_ ) 
union{ 
    cylinder {<-W_,0,0>,<W_,0,0>,R1_ translate<0,0,-W_>}
    sphere   {<0,0,0>,R1_   translate<W,0,-W_>} 
      }
#end //-----------------

#macro Square (R10, W0) 
union{  
   object{ Square_Quart(R10, W0) rotate<0,0*90,0>}
   object{ Square_Quart(R10, W0) rotate<0,1*90,0>}
   object{ Square_Quart(R10, W0) rotate<0,2*90,0>}
   object{ Square_Quart(R10, W0) rotate<0,3*90,0>}
     }
#end //-----------------

#macro Vertical_Element (R10, R20, W0, H0) 
union{ 
   cylinder {<0,0,0>,<0,H0,0>,R10 translate<-W0,0,-W0>}
   // diagonal:
   cylinder{<-W0,0,0>,<W0,H0,0>,R20 translate<0,0,-W0+R20> }
   cylinder{<W0,0,0>,<-W0,H0,0>,R20 translate<0,0,-W0-R20> }
   }
#end //-----------------

#macro Element_4 (R11, R21, W1, H1)
union{ 
   object{ Square (R11, W1)}
   //vertical:
   object{ Vertical_Element(R11,R21,W1,H1) rotate<0,0*90,0>}
   object{ Vertical_Element(R11,R21,W1,H1) rotate<0,1*90,0>}
   object{ Vertical_Element(R11,R21,W1,H1) rotate<0,2*90,0>}
   object{ Vertical_Element(R11,R21,W1,H1) rotate<0,3*90,0>}
   translate<0,R1,0>}
#end //-------------------

//--------------------------------------------------------------------
//--------------------------------------------------------------------
// base:   
box {<-1,0,-1>,< 1,0.05,1> scale <W+0.1,1,W+0.1> texture{Texture2}}

// tower:

#declare Nr = 0;     // start
#declare EndNr = 8; // end

union{
#while (Nr< EndNr) 
   object{ Element_4(R1, R2, W, H)  texture{Texture1}
           translate<0,Nr*H,0>} 

 #declare Nr = Nr + 1;  // next Nr
  
#end // --------------- end of loop 
object{ Square (R1, W)   texture{Texture1}
        translate<0,Nr*H+R1,0>} 
translate<0,0.05,0> }


//---------------------------------------------------------------- end



