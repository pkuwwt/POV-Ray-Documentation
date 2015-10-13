// POV-Ray 3.6 / 3.7 include file "Bulldozer_01.inc"
// author: Friedrich A, Lohmueller, Nov-2006 / May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Bulldozer_01_Inc_Temp)
#declare Bulldozer_01_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Shapes_Lo_Inc_Temp)
#include "shapes_lo.inc"                                             
#end
#ifndef(  Track_Chain_0_Inc_Temp)
#include "Track_Chain_0.inc"                                             
#end
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
//-----------------------------------------------------------------------------
#macro Bulldozer_01 (  Scoop_Angle_,  // 0~30  winkel der Baggerschaufel !!!
                       Scoop_ON_, //  1=on, 0= off
                       Body_Texture_,  // 
                       Chassis_Texture_,  // 
                       Scoop_Texture_,  // 
                       Chain_Color_,  // base color of the chains  
                       Wheel_Texture_ //  texture of the wheels  
                    )  //------------------------------------------
//----------------------------------------------
#local D = 0.0001;
//----------------------------------------------
#local Chain_Length =  2.20; // > 4*Chain_Radius; total legth in x
#local Chain_Radius =  0.30; // half total height in y 
#local Chain_Depth  =  0.45; // depth in z 

#local Track_Width_Z = 0.75; // half width of the tracks  (middle distance to <0,0,0>}                     
#local Bulldozer_Z   = 0.55; // half width of the Bulldozer                      
#local Bulldozer_X   =Chain_Length/2-Chain_Radius+0.20; // half width of the Bulldozer                      
#local Chassis_Y = 0.15; 
#local Body_Y = 0.70; 
#local Body_Z= Bulldozer_Z  - 0.10;
//----------------------------------------------
#local Exhaust =
union{ //#macro Segment_of_Torus( R_major, R_minor, Segment_Angle)

 object{ Segment_of_Torus( 0.10, 0.03, 90)  scale <1,1,1>
         rotate<-90,0,0> translate<0,0.10,0>
       } // end of Torus_Segment(...) -----------------------              
 cylinder{ <0,0,0>,<0,0.70,0>,0.03 open translate<0.10,0.10,0>} 
 texture { Scoop_Texture }  
} // end of exhaust


//----------------------------------------------
union{

object{ Track_Chain_0( 2.20, // Chain_Length > 4*Chain_Radius; total legth in x
                       0.30, // Chain_Radius,  // half total height in y 
                       0.45, // Chain_Depth__,   // depth in z 
                       Chain_Color,   // base color of the chains  
                       Wheel_Texture   //  texture of the wheels  
                     ) //----------------------------------------- 
        scale <1,1,1> 
        rotate<0,0,0> 
        translate<0,0,-Track_Width_Z> }//---------------------------------------------------
object{ Track_Chain_0( 2.20, // Chain_Length > 4*Chain_Radius; total legth in x
                       0.30, // Chain_Radius,  // half total height in y 
                       0.45, // Chain_Depth__,   // depth in z 
                       Chain_Color,   // base color of the chains  
                       Wheel_Texture   //  texture of the wheels  
                     ) //----------------------------------------- 
        scale <1,1,1> 
        rotate<0,0,0> 
        translate<0,0, Track_Width_Z> }//---------------------------------------------------

//-----------------------------------------------------------------------------
object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<-Bulldozer_X ,-Chassis_Y,-Bulldozer_Z>,<Bulldozer_X ,Chassis_Y,Bulldozer_Z>, 0.05   , 0)  
         
        texture{ Chassis_Texture_} 
        scale<1,1,1>  rotate<0, 0,0> translate<0,Chain_Radius,0>
      } // ---------------------------------------------------------
//------------------------------------------------------------------------------
// Front 
difference{ 
object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<-Bulldozer_X/2           ,-Chassis_Y/2     ,-0.10>,
                  < Bulldozer_X+Chain_Radius, Chassis_Y+Body_Y, 0.10>, 0.10   , 0)  
         
        scale<1,1,1/0.10*Body_Z-0.10>  rotate<0, 0,0> translate<0,Chain_Radius,0>
      } // ---------------------------------------------------------
// Grill
 #local Nr = 0;     // start
 #while (Nr< 7) 
   box{<0,0,-Bulldozer_Z>,<0.20,0.045,Bulldozer_Z> translate<Bulldozer_X+0.20 ,Chain_Radius+Chassis_Y/2+Nr*0.08,0>} 
   #if (Nr > 2)
   box{<0,0,-Bulldozer_Z  >,<0.30,0.04,-Bulldozer_Z/2> translate<-0.05+Bulldozer_X/3 ,Chain_Radius+Chassis_Y+Nr*0.08,0>} 
   box{<0,0,-Bulldozer_Z/2>,<0.30,0.04, Bulldozer_Z  > translate<-0.05+Bulldozer_X/3 ,Chain_Radius+Chassis_Y+Nr*0.08,0>} 


   box{<0,0,-Bulldozer_Z  >,<0.30,0.04,-Bulldozer_Z/2> translate<-0.15 ,Chain_Radius+Chassis_Y+Nr*0.08,0>} 
   box{<0,0,-Bulldozer_Z/2>,<0.30,0.04, Bulldozer_Z  > translate<-0.15 ,Chain_Radius+Chassis_Y+Nr*0.08,0>} 
   #end
 #local Nr = Nr + 1;  // next Nr
 #end // --------------- end of loop 

 texture{ Body_Texture_} 
}// end diff Grill

// plattform
box{ <-Bulldozer_X*0.9,0,-Bulldozer_Z-0.30>,<Bulldozer_X*0.7,0.02, Bulldozer_Z+0.30>  
     translate<0,2*Chain_Radius+0.05,0> 
     texture{ Chassis_Texture_} 
   } //-----------------------
// backside body
object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<-0.10 , -Chassis_Y/4        ,-Bulldozer_Z+0.10>,
                  < 0.10, Chassis_Y+Body_Y-0.10, Bulldozer_Z-0.10>, 0.05   , 0)  
       texture{ Body_Texture_} 
         
        scale<1,1,1>  rotate<0, 0,0> translate<-Bulldozer_X,Chain_Radius,0>
      } // ---------------------------------------------------------
// seat
object{ // Round_Box(A, B, WireRadius, UseMerge)
        Round_Box(<-0.05 , 0        ,-Bulldozer_Z+0.30>,
                  < 0.35, Chassis_Y+Body_Y-0.25, Bulldozer_Z-0.30>, 0.025   , 0)  
       texture{ Body_Texture_} 
         
        scale<1,1,1>  rotate<0, 0,0> translate<-Bulldozer_X,Chain_Radius,0>
      } // ---------------------------------------------------------
// ---------------- Scoop
#if ( Scoop_ON_= 1)   
  #local Scoop_R = 1.00; #local Scoop_Z = Track_Width_Z+Chain_Depth/2+0.15;  
  #local Scoop_X = 2*Bulldozer_X+1*Chain_Radius+Scoop_R +0.20 ;
union{
 intersection{ 
  cylinder{ <0,0,-Scoop_Z  >,<0,0,Scoop_Z  >, Scoop_R  } 
  cylinder{ <0,0,-Scoop_Z-D>,<0,0,Scoop_Z+D>, Scoop_R-0.01 inverse texture{ Scoop_Texture_}} 
  box{ <-Scoop_R,-Chain_Radius+0.01,-Scoop_Z>,<-Scoop_R/2,1.1*Chain_Radius, Scoop_Z>} 
  translate<Scoop_X-Chain_Radius-0.05,0,0>

 } // end of intersection
 union{ 
  cylinder{ <0,0,0>,<-(Chain_Radius+0.05)+Scoop_X-Scoop_R+0.0, 0.15,0>,0.03 scale<1,1.0,1> translate<0,0,-Scoop_Z+0.05 >}
  cylinder{ <0,0,0>,<-(Chain_Radius+0.05)+Scoop_X-Scoop_R+0.0,-0.15,0>,0.03 scale<1,1.0,1> translate<0,0,-Scoop_Z+0.05 >}
  cylinder{ <0,0,0>,<-(Chain_Radius+0.05)+Scoop_X-Scoop_R+0.0, 0.15,0>,0.03 scale<1,1.0,1>  translate<0,0,-Scoop_Z+0.05 >scale<1,1,-1>}
  cylinder{ <0,0,0>,<-(Chain_Radius+0.05)+Scoop_X-Scoop_R+0.0,-0.15,0>,0.03 scale<1,1.0,1>  translate<0,0,-Scoop_Z+0.05 >scale<1,1,-1>}
 // hintere Halterung
 cylinder{ <0,0,-Scoop_Z-0.02>,<0,0,Scoop_Z+0.02>,0.03}  
 cylinder{ <0,0,-0.045>,<0,0,0.045>,0.07 translate<0,0,-Scoop_Z+0.05> }
 cylinder{ <0,0,-0.045>,<0,0,0.045>,0.07 translate<0,0,-Scoop_Z+0.05> scale<1,1,-1> }
 // hinter Schaufel
 cylinder{ <0,0,-Scoop_Z+0.01>,<0,0,Scoop_Z-0.01>,0.03  translate<-(Chain_Radius+0.05)+Scoop_X-Scoop_R-0.03, 0.15,0>}  
 cylinder{ <0,0,-Scoop_Z+0.01>,<0,0,Scoop_Z-0.01>,0.03  translate<-(Chain_Radius+0.05)+Scoop_X-Scoop_R-0.04,-0.15,0>}  
  texture{ Body_Texture_}
  } 

 rotate<0,0, Scoop_Angle_-4> 
 translate<Chain_Radius+0.05,Chain_Radius-0.15,0>
 texture{ Chassis_Texture_}
 translate<-Bulldozer_X,Chain_Radius,0>
} // end union scoop 
#end // scoop
//--------------------------------------------------------------

object{ Exhaust rotate<0,90,0> translate<0.80,2*Chain_Radius+0.05,-Body_Z+0.05> }
object{ Exhaust rotate<0,90,0> translate<0.90,2*Chain_Radius+0.05,-Body_Z+0.05> }
object{ Exhaust rotate<0,90,0> translate<0.80,2*Chain_Radius+0.05,-Body_Z+0.05> scale<1,1,-1>}
object{ Exhaust rotate<0,90,0> translate<0.90,2*Chain_Radius+0.05,-Body_Z+0.05> scale<1,1,-1>}

// Handles
union{ cylinder{ <0,0,0>,<0,0.50,0>,0.01}  
       sphere  { <0,0,0>,0.025 translate<0,0.50,0> }
       texture{ Chassis_Texture_}
       translate<-Bulldozer_Z,2*Chain_Radius+0.05,-0.40>
     } //.---
union{ cylinder{ <0,0,0>,<0,0.50,0>,0.01}  
       sphere  { <0,0,0>,0.025 translate<0,0.50,0> }
       texture{ Chassis_Texture_}
       rotate<0,0,-2>
       translate<-Bulldozer_Z,2*Chain_Radius+0.05, 0.40>
     } //.---

} // end of union 
//-----------------------------------------------------------------------------
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-----------------------------------------------------------------------------
//----------------------------------------------------------------------------- bulldozer textures
#local Body_Texture =  
        texture { pigment{ color rgb< 1.0, 0.65, 0.0> } //  deep yellow 
               // normal { bumps 0.5 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Chassis_Texture =  
        texture { pigment{ color rgb< 1.0, 1, 1>*0.35 } //  gray
                  normal { bumps 0.15 scale 0.05 }
                  finish { phong 1 reflection 0.00}
                } // end of texture 
#local Scoop_Texture = 
        texture{ Chrome_Metal
                 finish { diffuse 0.9 phong 1 }
                 normal { bumps 0.05 scale 0.0025}
               } // end of texture ---------------------------  
 

#local Chain_Color =  color rgb< 1, 1, 1>*0.65;     // base color of the chains
#local Wheel_Texture =  texture { pigment{ color rgb< 1, 0.75, 0.50>*0.5 } // brown 
                                  normal { bumps 0.5 scale 0.01 }
                                  finish { phong 1 reflection 0.00}
                                } // end of texture 

//-----------------------------------------------------------------------------
//----------------------------------------------------------------------------
#include "Bulldozer_01.inc"
//-----------------------------------------------------------------------------
object{ Bulldozer_01(  0, // Scoop_Angle_,  // 0~15  winkel der Baggerschaufel !!!
                       1, // Scoop_ON_, // 1= on, 0 = off
                       Body_Texture,  // 
                       Chassis_Texture,  // 
                       Scoop_Texture, // 
                       Chain_Color,  // base color of the chains  
                       Wheel_Texture //  texture of the wheels  
                    )  //------------------------------------------  
        scale <1,1,1> 
        rotate<0,0,0> 
        translate<0,0,0> }//---------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
*/


#version Bulldozer_01_Inc_Temp;
#end
//------------------------------------- end of include file

