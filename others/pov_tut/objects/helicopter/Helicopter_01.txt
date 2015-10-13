// POV-Ray 3.6/3.7 include file "Helicopter_01.inc"
// author: Friedrich A, Lohmueller, Jan-2006 / May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Helicopter_01_Inc_Temp)
#declare Helicopter_01_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
//------------------------------------------------------------------------------ /////////  
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#macro Helicopter_01 ( Rotor_Rotation___,          // main rotor rotation
                       Backside_Rotor_Rotation___, // backside rotor rotation

                       Body_Texture___, //
                       Inside_Texture___,   //  
                       Seat_Texture___
                     ) //--------------------------------------------------

//----------------------------------------------------------------------------
#local D = 0.00001; 
//----------------------------------------------------------------------------
#local wD = 0.005 ; // wall thickness
#local FD = 0.035 ; // half frame thickness
#local RD = 0.13;// rotor width
//----------------------------------------------------------------------------
#local Scale_X = 1.75; 
#local Scale_Y = 1.25; 
#local Rotor_Position___ = <-0.40,2*Scale_Y+0.75,0>;



//----------------------------------------------------------------------------
#local Window_Glass___ = 
       texture{ pigment{ rgbf <0.98, 0.98, 0.98, 0.9>*0.8 }
                finish { diffuse 0.1 reflection 0.2  
                         specular 0.8 roughness 0.0003 phong 1 phong_size 400}
               } // end of texture -------------------------------------------
//----------------------------------------------------------------------------
#local Rotor_Texture___ =  
         texture { pigment{ color rgb< 1, 1, 1>*0.55 } //  color Gray75
                // normal { bumps 0.5 scale 0.05 }
                   finish { phong 1}
                 } // end of texture 

//----------------------------------------------------------------------------
// Wheels
#local Wheel_Rmaj = 0.18; 
#local Wheel_Rmin = 0.09; 
#local Wheel = 
union{ 
 cylinder{ <0,0,-0.03>,<0,0,0.03>, Wheel_Rmaj 
         texture { pigment{ color rgb< 1, 1, 1>*0.75 }  
                // normal { bumps 0.5 scale 0.05 }
                   finish {  phong 1}
                 } // end of texture 
         }// end cyl 
 torus{ Wheel_Rmaj, Wheel_Rmin  rotate<90,0,0>
         texture { pigment{ color rgb< 1, 1, 1>*0.05 }  
                 normal { bumps 0.5 scale 0.005 }
                   finish { phong 1}
                 } // end of texture 
     } // end torus
translate<0,Wheel_Rmaj + Wheel_Rmin,0>
}// end of union -------------------------------------------------------------
// Main rotor
#local Main_Rotor___ =  
union{ 
object { //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
         Round_Cylinder(<0,0,0>, <7,0,0>, RD+D , RD,   0)  
         scale<1,0.2,1>  rotate<-10,0,0>  
       } // ------------------------------------------------------------
object { //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
         Round_Cylinder(<0,0,0>, <7,0,0>,  RD+D , RD,   0)  
         scale<1,0.2,1>  rotate<-10,120,0> 
       } // ------------------------------------------------------------
object { //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
         Round_Cylinder(<0,0,0>, <7,0,0>,  RD+D , RD,   0)  
         scale<1,0.2,1>  rotate<-10,240,0> 
       } // ------------------------------------------------------------
sphere{ <0,0,0>,0.30 scale<1,0.4,1>}
cylinder{ <0,-0.30,0>,<0,0,0>,0.045 } 


texture{ Rotor_Texture___}
} // --------------------------------------------------------------------------
#local Seat___ = 
union{ 
object { // Round_Box(A, B, WireRadius, UseMerge)
         Round_Box(<-0.10,0,-0.80>,<0.05,0.70,-0.15>, 0.035   , 0)  
         rotate<0, 0,15>  
       } // ---------------------------------------------------------
object { // Round_Box(A, B, WireRadius, UseMerge)
         Round_Box(<0,-0.10,-0.80>,<0.50,0.05,-0.15>, 0.035   , 0)  
         rotate<0, 0,5>  
       } // ---------------------------------------------------------

texture {Seat_Texture___ } 
} //------------------------------------------------------------------------------------------ 


//----------------------------------------------------------------------------
//----------------------------------------------------------------------------
union{ 

// body with window glass 
difference{
union{ // positive parts
object { // Round_Box(A, B, WireRadius, UseMerge)
         Round_Box(<-1.25,-0,-0.5>,<1,2,0.5>, 0.50   , 0)  
         scale<Scale_X,Scale_Y,2>   
       } // ---------------------------------------------------------
// the tail:
object{//Round_Cone2( point A, radius A, point B, radius B, merge on) 
         Round_Cone2( <-4.00,2.20,0>, 0.10, <0.40,1.60,0>, 0.40 , 0 ) 
         
         scale<Scale_X,Scale_Y,1>  translate<Scale_X*(-1.00),0.0,0>
         texture {Body_Texture___}
       } // --------------------------------------------------------------------------------
// rotor head: 
  object{//Round_Cone( point A, radius A, point B, radius B, rounding radius, merge on) 
         Round_Cone( <0,-1.00,0>, 0.70    , <0,-0.15,0>, 0.20 , 0.05, 0)  
         texture{ Body_Texture___ } 
         scale<1.35,1,0.5>  
              matrix<1  , 0, 0, //  matrix-shear_y_to_x
            0.55, 1, 0,
            0  , 0, 1,
            0  , 0, 0>
          translate Rotor_Position___  
       } // --------------------------------------------------------------------------------

} //------------------------------------------------------------------------------------------ 

// minus parts: 
// inside caved out
object { // Round_Box(A, B, WireRadius, UseMerge)
         Round_Box(<-1+wD,-0+wD,-0.5+wD>,<1-wD,2-wD,0.5-wD>, 0.50-wD   , 0)  
         scale<Scale_X,Scale_Y,2>  rotate<0, 0,0> translate<0,0,0>
         texture{ Inside_Texture___}
       } // ---------------------------------------------------------
box{ <Scale_X*0.5+FD,             -D,-1-D>,<Scale_X*1+D,Scale_Y*0.50-FD,-FD> }  
box{ <Scale_X*0.5+FD,Scale_Y*0.50+FD,-1-D>,<Scale_X*1+D,Scale_Y*1.00-FD,-FD> }  
box{ <Scale_X*0.5+FD,Scale_Y*1.00+FD,-1-D>,<Scale_X*1+D,Scale_Y*1.50-FD,-FD> }  
box{ <Scale_X*0.5+FD,Scale_Y*1.50+FD,-1-D>,<Scale_X*1+D,Scale_Y*2.00+D,-FD>  }  

box{ <Scale_X*0.0+FD,Scale_Y*1.00+FD,-1-D>,<Scale_X*0.5-FD,Scale_Y*1.50-FD,-FD> }  
box{ <Scale_X*0.0+FD,Scale_Y*1.50+FD,-1-D>,<Scale_X*0.5-FD,Scale_Y*2.00+D,-FD>  }  

box{ <Scale_X*0.5+FD,             -D,-1-D>,<Scale_X*1+D,Scale_Y*0.50-FD,-FD>  scale<1,1,-1> }  
box{ <Scale_X*0.5+FD,Scale_Y*0.50+FD,-1-D>,<Scale_X*1+D,Scale_Y*1.00-FD,-FD>  scale<1,1,-1> }  
box{ <Scale_X*0.5+FD,Scale_Y*1.00+FD,-1-D>,<Scale_X*1+D,Scale_Y*1.50-FD,-FD>  scale<1,1,-1> }  
box{ <Scale_X*0.5+FD,Scale_Y*1.50+FD,-1-D>,<Scale_X*1+D,Scale_Y*2.00+D,-FD>   scale<1,1,-1> }  

box{ <Scale_X*0.0+FD,Scale_Y*1.00+FD,-1-D>,<Scale_X*0.5-FD,Scale_Y*1.50-FD,-FD> scale<1,1,-1> }  
box{ <Scale_X*0.0+FD,Scale_Y*1.50+FD,-1-D>,<Scale_X*0.5-FD,Scale_Y*2.00+D,-FD>  scale<1,1,-1> }  

 texture {Body_Texture___}
}// end of difference 
// the windows 
object { // Round_Box(A, B, WireRadius, UseMerge)
         Round_Box(<-1+wD/2,-0+wD/2,-0.5+wD/2>,<1-wD/2,2-wD/2,0.5-wD/2>, 0.50-wD/2   , 1)  
         scale<Scale_X,Scale_Y,2>   
         texture {Window_Glass___}
       } // ---------------------------------------------------------
//-------------------------------------------------------------------
//------------------------------------------------------------------------------------------
object{ Main_Rotor___  rotate<0,Rotor_Rotation___,0> translate Rotor_Position___  }

union{ // Backside Rotor  
 object { //Round_Cylinder(point A, point B, Radius, EdgeRadius, UseMerge)
         Round_Cylinder(<-1.5,0,0>, <1.5,0,0>, 0.071 , 0.07,   0)  
         scale<1,1,0.2>  
       } // ------------------------------------------------------------
 sphere{ <0,0,0>,0.15 scale<1,1,0.5>}
 cylinder{ <0,0,0>,<0,0,0.30>,0.05 } 

 texture{ Rotor_Texture___}
 rotate<0,0,Backside_Rotor_Rotation___> rotate<0,4,0>
 translate  <Scale_X*(-1.00-4.00),Scale_Y*2.20,-0.18>
} //
//------------------------------------------------------------------------------------------
// feet 

#local Foot_Front_Position___ = <Scale_X*0.5,-0.55*Scale_Y,0>; 
#local Foot_Back_Position___ = <Scale_X*-0.85,-0.55*Scale_Y,0>; 
#local Back_Wheel_Distance = 2.20; 


union{ // Front Wheel 
 cylinder{ <0, 0.20,0> ,<0,0.70,0>, 0.06  scale<1,1,2> texture {Body_Texture___} } 
 object{ Wheel }
 translate Foot_Front_Position___                         
 } //--------------------------------------------------------------
union{ // Back Wheel 

 cylinder{ <0, 0.80, 0.00>,<0,0.20,-Back_Wheel_Distance+0.03>, 0.06  translate Foot_Back_Position___
            texture {Body_Texture___} } 
 cylinder{ <0, 1.80,-0.95>,<0,0.20,-Back_Wheel_Distance+0.03>, 0.06  translate Foot_Back_Position___
            texture {Body_Texture___} } 
 cylinder{ <0, 0.80, 0.00>,<0,0.20, Back_Wheel_Distance-0.03>, 0.06  translate Foot_Back_Position___
            texture {Body_Texture___} } 
 cylinder{ <0, 1.80, 0.95>,<0,0.20, Back_Wheel_Distance-0.03>, 0.06  translate Foot_Back_Position___
            texture {Body_Texture___} } 
 object{ Wheel  translate Foot_Back_Position___ +<0,0, Back_Wheel_Distance>}
 object{ Wheel  translate Foot_Back_Position___ +<0,0,-Back_Wheel_Distance>}

 } //--------------------------------------------------------------

//------------------------------------------------------------------------------------------

object{ Seat___ translate<0.5,0.75,0> } 
object{ Seat___ translate<0.5,0.75,0> scale<1,1,-1>} 



translate<0.50,0.70,0>
} // end of union
// -----------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
#declare Xxx_Texture = 
   texture { //Chrome_Metal}  
             pigment{ color rgb<1,1,1> } 
             finish { phong 0.1} 
           } // end of texture
//---------------------------------------------------------------------------------------
#include "Xxx_000.inc" 
//-------------------------------------------------------------------------------------// 
object{ Xxx_000(     , // sample of VAL
 
                   ) //----------------------------------------------------------------//
        texture { Xyz_Texture }
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Helicopter_01_Inc_Temp;
#end
//------------------------------------- end of include file

