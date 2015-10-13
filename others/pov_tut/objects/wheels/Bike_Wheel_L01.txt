// POV-Ray 3.6 / 3.7 include file "Bike_Wheel_000.inc 
// author: Friedrich A, Lohmueller, Nov-2013
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Bike_Wheel_L01_Inc_Temp)
#declare Bike_Wheel_L01_Inc_Temp = version;
#version 3.7;


//---------------------------------------------------------------------------------- default textures
//---------------------------------------------------------------------------------------
#ifndef(Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(Textures_Inc_Temp)
#include "textures.inc"                                             
#end
//---------------------------------------------------------------------------------------


#macro Bike_Wheel_L01(Wheel__R, Wheel__Rotation) //-----------------------
//----------------------------------------------------------------------------------
#ifndef (Tire_Texture_Base)
#declare Tire_Texture_Base  =  // Grund_Reifen-Textur
 texture { pigment{color rgb<1,1,1>*0.1}
           normal {bumps 0.5 scale 0.05}
           finish {ambient 0.15 diffuse 0.85 phong 0.1}
         } // end of texture
#end
#ifndef (Rim_Texture)
#declare Rim_Texture = //       Felgen-Textur
 texture { // pigment{color rgb<1,1,1>*0.25}
           Polished_Chrome
           finish { phong 1}
         } // end of texture
#end
//----------------------------------------------------------------------------------
//-------------------------------------------------------------------
#local RH = 1  ;  //1.45; // Radhöhe 
#local RR = 0.07; // RohrRadius
#local RW = 0.40; // Radgabel-Weite
//------------------------------------------------------------------



// Wheels defined with axes at zero: 
// #declare Bike_Wheel_000 =  //------------------------------------------------------------------------
union{ // das Rad
  torus{0.9,0.22 scale <1,1,1> rotate<90,0,0> texture{Rim_Texture}}
  torus{1.0,0.25 scale <1,1,1> rotate<90,0,0> texture{Tire_Texture_Base}}

  torus{1.08,0.010 scale <1,1,1> rotate<90,0,0> translate<0,0,-0.240> texture{Tire_Texture_Base}}
  torus{0.95,0.005 scale <1,1,1> rotate<90,0,0> translate<0,0,-0.245> texture{Tire_Texture_Base}}
  torus{1.08,0.010 scale <1,1,1> rotate<90,0,0> translate<0,0, 0.240> texture{Tire_Texture_Base}}
  torus{0.95,0.005 scale <1,1,1> rotate<90,0,0> translate<0,0, 0.245> texture{Tire_Texture_Base}}

  difference{ // Felge
    cylinder {<0,0,-0.20>,<0,0,0.20>,1.00 }
    cylinder {<0,0,-0.26>,<0,0,0.26>,0.78}
    texture{Rim_Texture}
   }

 // Speichen
  #declare Nr= 0;  #declare EndNr = 20; //---------------------------------------------------------
  #while ( Nr < EndNr ) 
       cylinder {<-1,0.1, 0.15>,<1,0.1, 0.15>,0.01 rotate<0,0,360/EndNr*Nr> texture{Rim_Texture}}
       cylinder {<-1,0.1,-0.15>,<1,0.1,-0.15>,0.01 rotate<0,0,360/EndNr*Nr> texture{Rim_Texture}}
       #declare Nr = Nr +1;
  #end // ----------------------------------------------------------------------------------------

  // Profil auf Reifen
  #declare Nr= 0;  #declare EndNr = 60; //---------------------------------------------------
  #while ( Nr < EndNr ) 
       union{
       box {<-0.1,-0.1,-0.1>,<0.1,0.1,0.1> scale 0.45 translate<0.25,0,0> rotate <0,-50,0>}
       box {<-0.1,-0.1,-0.1>,<0.1,0.1,0.1> scale 0.45 translate<0.25,0,0> rotate <0,-25,0>}
       box {<-0.1,-0.1,-0.1>,<0.1,0.1,0.1> scale 0.45 translate<0.25,0,0> rotate <0,  0,0>}
       box {<-0.1,-0.1,-0.1>,<0.1,0.1,0.1> scale 0.45 translate<0.25,0,0> rotate <0, 25,0>}
       box {<-0.1,-0.1,-0.1>,<0.1,0.1,0.1> scale 0.45 translate<0.25,0,0> rotate <0, 50,0>}
            translate<1.00,0,0>  rotate<0,0,360/EndNr*Nr>
       texture{Tire_Texture_Base}}
       #declare Nr = Nr +1;
  #end // ----------------------------------------------------------------

 difference{ //------------------------------------------------------
 //------ hub  -----
 cylinder {<0,0,-0.18>,<0,0, 0.18>,0.16}
 cylinder {<0,0,-0.19>,<0,0,+0.19>,0.10}
 texture{Rim_Texture}
 }


scale 1/(1+0.25)

rotate<0,0,Wheel__Rotation>
translate<0,RH,0>  // lifted on the street 
scale Wheel__R
}//  end of union ---------------------------------------- 
 #end //----------------------------- end of macro Bike_Wheel_L01(Wheel__R, Wheel__Rotation)

//-------------------------------------------------- Demo

//--------------


// example for usage: 
/*
//-------------------------------------------------------------------------
#declare Tire_Texture_Base  =  // Grund_Reifen-Textur
 texture { pigment{color rgb<1,1,1>*0.1}
           normal {bumps 0.5 scale 0.05}
           finish {ambient 0.15 diffuse 0.85 phong 0.1}
         } // end of texture
#declare Rim_Texture = //       Felgen-Textur
 texture { // pigment{color rgb<1,1,1>*0.25}
           Polished_Chrome
           finish { phong 1}
         } // end of texture
//-------------------------------------------------------------------------
#include "Bike_Wheel_L01.inc"
//-------------------------------------------------------------------------
//#macro Bike_Wheel_L01(Wheel__R, Wheel__Rotation)
object{ Bike_Wheel_L01(0.30, 0)  
        scale 1  rotate<0,0,0>  translate<0,0,0>  }
//-------------------------------------------------------------------------
*/
//------------------------------------------------------------------ end





#version Bike_Wheel_L01_Inc_Temp;
#end
//------------------------------------- end of include file

 
 
 
 