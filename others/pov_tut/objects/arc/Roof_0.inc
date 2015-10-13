// POV-Ray 3.6/3.7 include file "Roof_0.inc"
// author: Friedrich A, Lohmueller, Jan-2006, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Roof_000_Inc_Temp)
#declare Roof_000_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////  
// ---------------------------------------------------------- macro roof(...) -----------
#macro Roof_0 ( Roof___Angle1,   // roof angle                              
                  Roof___WideX,  // roof width z parts
                  Roof___WideZ,  // roof width x parts
                  Roof___Over,     // overhang
                  R_Cyl,         // radius cylinders
                  Cyl_D,         // distance cylinders
                  Roof___Texture1, //
                  Roof___Texture2  //
                ) //------------------------------------------------------------- 
// --------------------------------------------------------------------------------------- 
#local D = 0.00001;
#if ( Roof___Over< 0) #local Roof___Over = 0; #end 
#if ( Cyl_D <=0 ) #local Cyl_D = D; #end 
// ---------------------------------------------------------------------------------------
 
#macro RoofHeight(Len,Angle)  
 Len*tan(radians(Angle)) 
#end
  
// --------------------------------------------------------------------------------------- 
#macro RoofDiag (ROver, RoofLen, RoofAngle, RoofCyl_R)          
 #local RoofXOver =  ROver*cos(radians(RoofAngle));
 #local RoofYOver =  ROver*sin(radians(RoofAngle));
 cylinder{ <-RoofXOver, -RoofYOver,-RoofXOver>,
           < RoofLen, RoofLen*tan(radians(RoofAngle)), RoofLen>, 1.2*RoofCyl_R 
           texture{Roof___Texture1 rotate<0,-45,RoofAngle>}}
#end // end of macro
// --------------------------------------------------- these macros are used in macro roof(...)
#macro Roof___quarter (RoofAngle, RoofLen, RoofWide, ROver, RRoofCyl, RoofCylDistance, Cut )
 #local RoofSteep = sqrt( pow(RoofLen,2)+ pow(RoofLen*tan(radians(RoofAngle)),2) );
 intersection{
 // a box with cylinders 
 union{
  box {<-ROver,0,-ROver>,< RoofSteep,0.01,RoofWide+ROver> texture{Roof___Texture2}}
   #declare Nr = 0;     // Startwert
   #declare EndNr = (RoofWide+2*ROver)/RoofCylDistance; // Endwert
   #while (Nr< EndNr) 
   cylinder {<-ROver-0.01,0,0>,<RoofSteep,0,0>, RRoofCyl texture{Roof___Texture1}
             translate<0,0,-ROver+Nr*RoofCylDistance>} 
   #declare Nr = Nr + 1;    // next Nr
   #end // --------------- end of the loop 
  rotate<0,0,RoofAngle>}//---------- end of union ......
 //cut off by diagonal planes:
 plane{<1,0,0>, 0  rotate<0, 45,0>  texture{Roof___Texture1}}
 plane{<1,0,0>, 0  rotate<0,-45,0> translate<0,0,RoofWide> texture{Roof___Texture1}}
 plane{<1,0,0>, 0  rotate<0,0,0> translate< Cut,0,0> texture{Roof___Texture1}}
 
 bounded_by{box {<-ROver         ,-RRoofCyl ,-ROver>,
                 < RoofLen+RoofSteep, RRoofCyl ,RoofWide+2*ROver>}
                 rotate<0,0,RoofAngle> }
 }//--------- end of intersection
#end // end of macro

// ---------------------------------------------------------------------------------------
#local Roof___Deepth = min(Roof___WideZ/2, Roof___WideX/2); 
#local Roof___Lenght = sqrt( pow(Roof___Deepth, 2)+pow(Roof___Deepth*tan(radians(Roof___Angle1)),2)) ;//  


// #macro Roof (Roof___Angle1,Roof___Len_X11,Roof___Len_X12,Roof___WideZ,Roof___WideX,Roof___Over,R_Cyl,Cyl_D)
 union{
 object{ Roof___quarter(Roof___Angle1,Roof___Lenght,Roof___WideZ,Roof___Over,R_Cyl,Cyl_D, Roof___WideX/2)                translate<        0.00,0,0.00>}
 object{ Roof___quarter(Roof___Angle1,Roof___Lenght,Roof___WideZ,Roof___Over,R_Cyl,Cyl_D, Roof___WideX/2) scale<-1,1,1>  translate<Roof___WideX,0,0.00>}
 object{ Roof___quarter(Roof___Angle1,Roof___Lenght,Roof___WideX,Roof___Over,R_Cyl,Cyl_D, Roof___WideZ/2) rotate<0, 90,0>translate<0.00,0,Roof___WideZ>}
 object{ Roof___quarter(Roof___Angle1,Roof___Lenght,Roof___WideX,Roof___Over,R_Cyl,Cyl_D, Roof___WideZ/2) rotate<0,-90,0>translate<Roof___WideX,0,0.00>}
 
 #if ( R_Cyl>0)
 union{
  object{ RoofDiag (Roof___Over, Roof___Deepth, Roof___Angle1, R_Cyl)                 translate<           0,0,0>} 
  object{ RoofDiag (Roof___Over, Roof___Deepth, Roof___Angle1, R_Cyl) rotate<0,-90,0> translate<Roof___WideX,0,0>} 
  object{ RoofDiag (Roof___Over, Roof___Deepth, Roof___Angle1, R_Cyl) rotate<0,180,0> translate<Roof___WideX,0,Roof___WideZ>} 
  object{ RoofDiag (Roof___Over, Roof___Deepth, Roof___Angle1, R_Cyl) rotate<0, 90,0> translate<           0,0,Roof___WideZ>} 
 
  #if (Roof___WideZ-Roof___WideX >0 ) 
  cylinder{<0,0,0>,<0,0,Roof___WideZ-Roof___WideX >,1.2*R_Cyl 
           translate <Roof___Deepth,RoofHeight(Roof___Deepth,Roof___Angle1),Roof___Deepth> 
           texture{Roof___Texture1 rotate<0,90,0>}
          }
  #end // Firstziegel
  #if (Roof___WideZ-Roof___WideX <0 ) 
  cylinder{<0,0,0>,<Roof___WideX-Roof___WideZ,0,0 >,1.2*R_Cyl 
           translate <Roof___Deepth,RoofHeight(Roof___Deepth,Roof___Angle1), Roof___Deepth>  
           texture{Roof___Texture1 rotate<0,90,0>}
          }
  #end // Firstziegel
 translate<0,0.05,0>}
 #end // of "#if ( R_Cyl>0)"
} // end of global union // --------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
//--------------------------------------------------------------------- roof textures <<<<<<<<<<<<<
#declare RoofTrans = <-1.25,0,0>;// to regulate the start of the roof brics
#declare Roof_Texture1 = texture{
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

#declare Roof_Texture2 = texture{
   Roof_Texture1  
   finish { ambient 0.15 diffuse 0.85 phong 1}}
//--------------------------------------------------------------------------------<<<<<<<<<<<<

#declare Wall_Height = 4.00;

// --------------------------------------------------------------------------------------------
#include "Roof_0.inc"
// --------------------------------------------------------------------------------------------
union{
box {<0,0,0>,< 8.00, Wall_Height,10.00> 
     texture{pigment{color White*1.2}
             finish {ambient 0.45 diffuse 0.55 phong 0.5}}}
//-------------------------------------------------------------------------------------------// 
object{ Roof_0 ( 35,    // Roof___Angle1,   // roof angle                              
                   6.00,  // Roof___WideX,  //   base length of the roof part in x-direction
                   8.00,  // Roof___WideZ,  //   base length of the roof part in z-direction  
                   0.50,  // Roof___Over,     // overhang
                   0.075, // R_Cyl,          // radius cylinders
                   0.20,  // Cyl_D,         // distance cylinders
                   Roof_Texture1, // Roof___Texture1, // cylinder texture
                   Roof_Texture2  // Roof___Texture2  // base box texture
                ) //--------------------------------------------------------------------------- 
       translate<0,Wall_Height,0>}
//---------------------------------------------------------------------------------------------
translate<0,0,0>
rotate<0,-35,0> }
// --------------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------------
*/


#version Roof_000_Inc_Temp;
#end
//------------------------------------- end of include file

