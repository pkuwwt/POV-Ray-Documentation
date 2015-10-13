// POV-Ray 3.6/3.7 Scene File/ 3.7 Scene File "con_rod1.pov"
// created by Friedrich A. Lohmueller, 2003, update 2010/Jan-2011.
// Demonstrates an animated connecting rod.
//--------------------------------------------------------------------------
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 conserve_energy}}
//--------------------------------------------------------------------------
#include "colors.inc"
#include "textures.inc"
#include "metals.inc"
//--------------------------------------------------------------------------
// camera ------------------------------------------------------------------
#declare Camera_0 = camera {/*ultra_wide_angle*/ angle 30
                            location  <0.0 , 0.5 ,-5.3>
                            right     x*image_width/image_height
                            look_at   <0.0 , 0.5 , 0.0>}
camera{Camera_0}
// sun ---------------------------------------------------------------------
light_source{< 500, 1000,-2500> color White}
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
    distance   50
    color      White
    fog_offset 0.1
    fog_alt    2.0
    turbulence 0.8}
// ground ------------------------------------------------------------------
plane{ <0,1,0>, 0
       texture{ pigment {color rgb <0.85,0.6,0.4>}
              } // end of texture
     } // end of plane
//--------------------------------------------------------------------------
//---------------------------- objects in scene ----------------------------
//--------------------------------------------------------------------------

//------------------------------------------------------------------------
#declare D = 0.001;   // just a little bit
//------------------------------------------------------------------------

// --------------------------------------------------------------- textures
#declare Wheel_Metal =
        texture{ pigment{color rgb<1,1,1>*0.5 }
                 finish { phong 1 reflection 0.2}}
#declare Wheel_Metal_2 =
        texture{Polished_Chrome pigment{quick_color White}
                finish { phong 1}}
#declare Wheel_Texture =
        texture{ pigment{color Red }
                 finish { phong 1}}
//-------------------------------------------------------------------


//-------------------------------------------------------------- dimensions
#declare Wheel_angle = 360*(clock+0.15);// angle of rotation -  Drehwinkel des Rades

#declare Wheel_Radius    = 0.550; // wheel radius     - Radradius
#declare Wheel_HalfWidth = 0.050; // half Wheel_width - halbe Radbreite
#declare Flange_Overhang = 0.065; // flange overhang  - Spurkanz Ueberhang
#declare Flange_Width    = 0.020; // flange width     - Spurkanz Weite

#declare Wheel_Ring   = 0.080;
#declare Hub_Radius   = 0.140; // Hub          - Radnabe
#declare Spoke_Radius = 0.035; // Spoke radius - Speichenradius



//------------------------------------------------------------------- Wheel
#declare Wheel =
union{
 difference{
 union{
        cone{ <0,0,Wheel_HalfWidth>, Wheel_Radius,
              <0,0,Wheel_HalfWidth+ Flange_Width >, Wheel_Radius+Flange_Overhang}
        cylinder{ <0,0,-Wheel_HalfWidth>,<0,0,Wheel_HalfWidth>,Wheel_Radius }
        texture{ Wheel_Metal }
      }// end of inner union

 cylinder{ <0,0,-Wheel_Radius-D>,<0,0,Wheel_Radius+Flange_Width+D>,  Wheel_Radius-Wheel_Ring
           texture{ Wheel_Texture } }
 } // end of difference

 cylinder{ <0,0,-Wheel_HalfWidth>,<0,0,Wheel_HalfWidth>,Hub_Radius   // kernel
          texture{ Wheel_Texture } }

 cylinder{ <0,0,-Wheel_HalfWidth-0.01>,<0,0,Wheel_HalfWidth+0.01>,Hub_Radius*0.75  // kernel
          texture{ Wheel_Metal } }
 cylinder{ <0,0,-Wheel_HalfWidth-0.02>,<0,0,Wheel_HalfWidth+0.02>,Hub_Radius*0.5   // kernel
          texture{ Wheel_Metal } }

 #local Nr = 0;     // start
 #local EndNr = 8; // end
 #while (Nr< EndNr)
   cylinder {<-Wheel_Radius+D,0,0>,<Wheel_Radius-D,0,0>,Spoke_Radius
             texture{ Wheel_Texture }
             rotate<0,0,Nr * 360/EndNr>}
 #declare Nr = Nr + 1;    // next Nr
 #end // ---------------  end of loop

} // end of union ------------------


//-------------------------------------------------------------------  connecting rod

#declare Connecting_radius = 0.4;//Connecting_radius-  Pleuelansatzradius = Radius, an dem die Connecting_Rod ansetzt
#declare Connecting_Rod_Len = 1.3;
#declare Connecting_x =  Connecting_radius * cos(radians(Wheel_angle));
#declare Connecting_y =  Connecting_radius * sin(radians(Wheel_angle));
#declare Connecting_Rod_y = Connecting_y;
#declare Connecting_Rod_x = sqrt(Connecting_Rod_Len*Connecting_Rod_Len-Connecting_Rod_y*Connecting_Rod_y);
#declare Connecting_Rod_Angle = degrees(atan2(Connecting_Rod_y,Connecting_Rod_x));

//----------------------------------------------------------------------------------------
#declare Connecting_Rod_Link = // reicht nur in -z-Bereich       //  Verbindungsgelenk zur Pleuelstange
union{
 cylinder {<0,0,-0.03>,<0,0,0.00>,0.075  }
 cylinder {<0,0,-0.05>,<0,0,0.04>,0.042  texture{Wheel_Metal}}
}//---------------------------------------------------------------------------------------
#declare Connecting_Rod =    // reicht nur in -z-Bereich            // Connecting_Rod - Pleuelstange
union{
  difference{
    box {<0,-1,-1>,< 1,1,0> scale <Connecting_Rod_Len,0.05,0.025> texture{Wheel_Metal}}
    cylinder{<0,0,0>,<Connecting_Rod_Len,0,0>,0.03 scale<1,1,0.5> translate<0,0,-0.025> texture{Wheel_Metal}}
    }// end of difference
  object{Connecting_Rod_Link texture{Wheel_Metal}}
  object{Connecting_Rod_Link translate<Connecting_Rod_Len,0,0> texture{Wheel_Metal}}

}//---------------------------------------------------------------------------------------
#declare KolbenStange =                                        // Kolben Stange
union{
  cylinder {<0,0,0>,<1,0,0>,0.04  texture{Wheel_Metal_2}}
  object{Connecting_Rod_Link scale<1,1,-1> texture{Wheel_Metal_2}}
}//---------------------------------------------------------------------------------------

//---------------------------------------------------------------------------------------  all together

union{
 union{ object{ Wheel  }
        cylinder{ <0,0,-Wheel_HalfWidth>,<0,0,Wheel_HalfWidth >,Hub_Radius*0.75
                  translate<Connecting_radius,0,0> texture{Wheel_Texture}}
        difference{ cylinder{ <0,0,-Spoke_Radius>,<0,0,Spoke_Radius>,Wheel_Radius-Wheel_Ring texture{Wheel_Texture}}
                    cylinder{ <0,0,-Spoke_Radius-D>,<0,0,Spoke_Radius+D >,Wheel_Radius*1.35
                              translate<Wheel_Radius*2/3,0,0> texture{Wheel_Texture}}
                   }// end of difference
        rotate<0,0,           Wheel_angle> }
 object{ Connecting_Rod rotate<0,0,-Connecting_Rod_Angle> translate<Connecting_x                 ,Connecting_y,-0.085>}
 object{ KolbenStange   rotate<0,0,0>                     translate<Connecting_x+Connecting_Rod_x,0           ,-0.075>}


rotate<0,0,0>
translate<-0.55,0.6,0>}
//---------------------------------------------------------------------------------------- end