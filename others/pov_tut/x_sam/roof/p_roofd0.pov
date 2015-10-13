// POV-Ray 3.6 / 3.7 Scene File "p_roofd0.pov"
// author: Friedrich A. Lohmueller, 2003/Aug-2009/Jan-2011
// email:  Friedrich.Lohmueller_at_t-online.de
// homepage: http://www.f-lohmueller.de
//
#version 3.6; // 3.7;
global_settings{ assumed_gamma 1.0 }
#default{ finish{ ambient 0.1 diffuse 0.9 }} 

#include "colors.inc"
#include "textures.inc"

// camera -----------------------------------------------------
#declare Camera_0 = camera {ultra_wide_angle angle 32       
                            location  <0.0, 17.0, -17.0>
                            right x*image_width/image_height
                            look_at <0.5 , 6.5, 0.0>}
camera{Camera_0} 

// sun ---------------------------------------------------------------
light_source{<500,2500,-1500> color White}
// sky ---------------------------------------------------------------
sphere{<0,0,0>,1 hollow 
              texture{pigment{gradient <0,1,0>
                              color_map{[0 color White]
                                        [1 color Blue ]}
                              quick_color White }               

                      finish {ambient 1 diffuse 0}
                     } 
           scale 10000}
// ground ------------------------------------------------------------
plane{<0,1,0>, 0 
      texture{pigment{ color rgb<0.15,0.35,0.00>}
              normal { bumps 0.5 scale 0.025}
              finish { phong 0.1}}}
//--------------------------------------------------------------------

//--------------------------------------------------------------------- roof textures <<<<<<<<<<<<<
#declare RoofTrans = <-1.25,0,0>;// to regulate the start of the roof brics
#declare Roof1 = texture{
   pigment{gradient x 
           color_map{[0.00 color rgb<1,1,1>*0.3 ]
                     [0.90 color rgb<1,1,1>*0.3 ]
                     [0.95 color rgb<1,1,1>*0.0 ]
                     [1.00 color rgb<1,1,1>*0.3 ]
                    }
           scale < 1, 1, 1>*0.38  quick_color  Scarlet*1.25}
   normal { bumps 0.3 scale 0.015} 
   finish { phong 1}
   translate RoofTrans}

#declare Roof2 = texture{
   Roof1  
   finish { ambient 0.15 diffuse 0.85 phong 1}}
//-------------------------------------------------------------------------------------<<<<<<<<<<<<


// -------------------------------------------------------------------------------- these macros were used in macro roof(...)
#macro Roof_quarter (RoofAngle, RoofLen, RoofWide, ROver, RRoofCyl, RoofCylDistance)
 #local RoofSteep = sqrt( pow(RoofLen,2)+ pow(RoofLen*tan(radians(RoofAngle)),2) );
 intersection{
 // a box with cylinders 
 union{
  box {<-ROver,0,-ROver>,< RoofSteep,0.01,RoofWide+ROver> texture{Roof2}}
   #declare Nr = 0;     // Startwert
   #declare EndNr = (RoofWide+2*ROver)/RoofCylDistance; // Endwert
   #while (Nr< EndNr) 
   cylinder {<-RoofOver-0.01,0,0>,<RoofSteep,0,0>, RRoofCyl texture{Roof1}
             translate<0,0,-RoofOver+Nr*RoofCylDistance>} 
   #declare Nr = Nr + 1;    // weiterz�hlen
   #end // --------------- Schleifen-Ende 
  rotate<0,0,RoofAngle>}//---------- end of union ......
 //cut off by diagonal planes:
/*
 plane{<1,0,0>, 0  rotate<0, 45,0>  texture{Roof1}}
 plane{<1,0,0>, 0  rotate<0,-45,0> translate<0,0,RoofWide> texture{Roof1}}
*/ 
 bounded_by{box {<-RoofOver         ,-RRoofCyl ,-RoofOver>,
                 < RoofLen+RoofSteep, RRoofCyl ,RoofWide+2*RoofOver>}
                 rotate<0,0,RoofAngle> }
 }//--------- end of intersection
#end // end of macro

// ------------------------------------------------------------------------------------
#macro RoofHeight(Len,Angle)  
 Len*tan(radians(Angle)) 
#end
// ------------------------------------------------------------------------------------
#macro RoofDiag (ROver, RoofLen, RoofAngle, RoofCyl_R)          
 #local RoofXOver =  ROver*cos(radians(RoofAngle));
 #local RoofYOver =  ROver*sin(radians(RoofAngle));
  cylinder{<-RoofXOver,-RoofYOver,-RoofXOver>,
            <RoofLen,RoofHeight(RoofLen,RoofAngle),RoofLen>,1.2*RoofCyl_R 
           texture{Roof1 rotate<0,-45,RoofAngle>}}
#end // end of macro

// ---------------------------------------------------------------------------------------------------------- macro roof(...) --
#macro Roof (Roof_Angle1,Roof_Len_X11,Roof_Len_X12,Roof_WideZ11,Roof_WideZ12,Roof_Over,R_Cyl,Cyl_D)
 union{
 object{ Roof_quarter(Roof_Angle1,Roof_Len_X11,Roof_WideZ11,Roof_Over,R_Cyl,Cyl_D)                translate<        0.00,0,0.00>}
// object{ Roof_quarter(Roof_Angle1,Roof_Len_X11,Roof_WideZ11,Roof_Over,R_Cyl,Cyl_D) scale<-1,1,1>  translate<Roof_WideZ12,0,0.00>}
// object{ Roof_quarter(Roof_Angle1,Roof_Len_X12,Roof_WideZ12,Roof_Over,R_Cyl,Cyl_D) rotate<0, 90,0>translate<0.00,0,Roof_WideZ11>}
// object{ Roof_quarter(Roof_Angle1,Roof_Len_X12,Roof_WideZ12,Roof_Over,R_Cyl,Cyl_D) rotate<0,-90,0>translate<Roof_WideZ12,0,0.00>}
/*
 union{
  object{ RoofDiag (Roof_Over, Roof_Len_X11, Roof_Angle1, R_Cyl)                 translate<           0,0,0>} 
  object{ RoofDiag (Roof_Over, Roof_Len_X11, Roof_Angle1, R_Cyl) rotate<0,-90,0> translate<Roof_WideZ12,0,0>} 
  object{ RoofDiag (Roof_Over, Roof_Len_X11, Roof_Angle1, R_Cyl) rotate<0,180,0> translate<Roof_WideZ12,0,Roof_WideZ11>} 
  object{ RoofDiag (Roof_Over, Roof_Len_X11, Roof_Angle1, R_Cyl) rotate<0, 90,0> translate<           0,0,Roof_WideZ11>} 

  cylinder{<0,0,0>,<0,0,Roof_WideZ11-Roof_WideZ12 >,1.2*R_Cyl 
           translate <Roof_Len_X11,RoofHeight(Roof_Len_X11,Roof_Angle1), Roof_Len_X12> texture{Roof1}}
 translate<0,0.05,0>}
*/
} #end // of macro    ---------------------------------------------------------------------------------------- end of Roof(...)




// --------------------------------------------------------------------------------------------
#declare RoofAngle1  = 35; // main
// --------------------------------------------------------------------------------------------
#declare RoofOver = 0.50;
// --------------------------------------------------------------------------------------------
// dimensions of the roof quarters:
// the long quarter:
#declare RoofLen_X11 = 4.00;// base length of the roof in x-direction  
#declare RoofWideZ11 =10.00;// base length of the roof in z-direction
// the triangular quarter:
#declare RoofLen_X12 = 4.00;// base length of the roof in x-direction
#declare RoofWideZ12 = 8.00;// base length of the roof in z-direction
// --------------------------------------------------------------------------------------------
#declare RCyl = 0.075;
#declare CylD = 0.20;
// --------------------------------------------------------------------------------------------
#declare Walls_Height = 4.00;

union{
box {<0,0,0>,< RoofWideZ12, Walls_Height, RoofWideZ11> 
     texture{pigment{color White*1.2}
             finish {ambient 0.45 diffuse 0.55 phong 0.5}}}

object{ Roof (RoofAngle1,RoofLen_X11,RoofLen_X12, RoofWideZ11,RoofWideZ12, RoofOver,RCyl,CylD) 
        translate<0,Walls_Height,0>}

translate<0,0,0>
rotate<0,-35,0> }
// --------------------------------------------------------------------------------------------
