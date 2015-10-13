// POV-Ray 3.7 include file "Wheel_L02.inc"
// author: Friedrich A, Lohmueller, Nov-2013
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Wheel_L02_Inc_Temp)
#declare Wheel_L02_Inc_Temp = version;
#version 3.7;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"
#end
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"
#end

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#macro Wheel_L02 ( Wheel_Rotation_Z ) // in degrees
//--------------------------------------------------------------------------
//------------------------------------------------- default textures
#ifndef (Rim_Texture)
#declare Rim_Texture = 
 texture{ //pigment{color White*1.2} 
          Polished_Chrome
          finish { phong 1}
        } // end of texture
#end
#ifndef (Tire_Texture)
#declare Tire_Texture = 
 texture { pigment{color rgb<1,1,1>*0.1}
          // normal {bumps 0.5 scale 0.05}
           finish { phong 0.1}
         } // end of texture
 texture { pigment{agate  scale 0.005
                   color_map{ 
                               [0.0 color Clear]
                               [0.1 color Clear]
                               [0.3 color rgbt<0.11,0.10,0.07,0.7> ]
                               [0.8 color Clear]
                               [1.0 color Clear]
                            }
                  }
           finish { phong 0.1 }
         } // end of texture
#end 
#ifndef (Tread_Texture)
#declare Tread_Texture = 
  texture{ pigment{color rgb<1,1,1>*0.1}
           normal { bumps 0.5 scale 0.01}
           finish { phong 0.1}
         } // end of texture
#end 
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#local Wheel_R_ = 0.40;
#local Tire_R_ = 0.10;
//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
#local Wheel_with_Rim = 
union{ //0
 intersection{
  // tire
  union{ //1
   torus{ Wheel_R_-Tire_R_*3/4-0.02 , Tire_R_  
          rotate<90,0,0> translate<0,0, Tire_R_/2>
        } // end of torus  -------------------------------
   torus{ Wheel_R_-Tire_R_*3/4-0.02 , Tire_R_  
           rotate<90,0,0> translate<0,0,-Tire_R_/2>
        } // end of torus  -------------------------------
   difference{ // cylindrical ring:
   cylinder{<0,0,-Tire_R_*0.9-Tire_R_/2>,<0,0,Tire_R_*0.9+Tire_R_/2>,Wheel_R_ }
   cylinder{<0,0,-Tire_R_*1.0-Tire_R_/2>,<0,0,Tire_R_*1.0+Tire_R_/2>,Wheel_R_-Tire_R_ }
   }// end of difference 
  }// end of union 1

 // tread: sphere streched in z direction: 
 sphere{ <0,0,0>, Wheel_R_ scale <1,1,2> 
         texture{ Tread_Texture }
       } // end of sphere -------------------------------              

 // minus grooves in wheel direction:
 torus { Wheel_R_-0.0100, 0.02 inverse rotate<90,0,0> scale <1,1,0.3> translate<0,0,-3*0.035>} //
 torus { Wheel_R_+0.0001, 0.02 inverse rotate<90,0,0> scale <1,1,0.3> translate<0,0,-2*0.035>} //
 torus { Wheel_R_+0.0001, 0.02 inverse rotate<90,0,0> scale <1,1,0.3> translate<0,0,-1*0.035>} //

 torus { Wheel_R_+0.0001, 0.01 inverse rotate<90,0,0> scale <1,1,0.3> translate<0,0,-0*0.035>} //

 torus { Wheel_R_+0.0001, 0.02 inverse rotate<90,0,0> scale <1,1,0.3> translate<0,0, 1*0.035>} //
 torus { Wheel_R_+0.0001, 0.02 inverse rotate<90,0,0> scale <1,1,0.3> translate<0,0, 2*0.035>} //
 torus { Wheel_R_-0.0100, 0.02 inverse rotate<90,0,0> scale <1,1,0.3> translate<0,0, 3*0.035>} //

 //  minus grooves across the tire
 #local Nr = 0; #local End = 36; 
 #while (Nr<End) 
 union{ //2
 cylinder{<0,0,-2*Tire_R_>,<0,0,   -0.02>,0.02 scale <0.4,2,1> rotate<0,+0,0> translate<0.05,Wheel_R_,0> }
 cylinder{<0,0,     0.02>,<0,0,2*Tire_R_>,0.02 scale <0.4,2,1> rotate<0,-0,0> translate<0.05,Wheel_R_,0> } // rotate<0,0,0.5*360/End>  }
    rotate<0,0,Nr*360/End>  
    inverse
 } // end union 2 
 #local Nr = Nr + 1; #end

 texture {Tire_Texture } 
 }// end of intersection
 // end of tire --------------------------------

 

//----------------------------------------------
 union{ // rim 
 torus { Wheel_R_-Tire_R_*1.5, Tire_R_-0.02 rotate<90,0,0> scale <1,1,1.5> } 
 torus { Wheel_R_-Tire_R_*1.85, 0.005 rotate<90,0,0> scale <1,1,1.5> translate<0,0,-Tire_R_-0.01> } 
 torus { Wheel_R_-Tire_R_*1.85, 0.005 rotate<90,0,0> scale <1,1,1.5> translate<0,0,+Tire_R_+0.01> } 
 texture { Rim_Texture } 
 }// end of union
 

}// end of union //---------------------------------------- end of Wheel_K
//---------------------------------------------------------------------- 



#declare Wheel__ = 
union{
 object{ Wheel_with_Rim }  
 // axis
 cylinder{<0,0,-Tire_R_>,<0,0,Tire_R_>,0.06}
 torus  { 0.04, 0.03  rotate<90,0,0> scale<1.5,1.5,1> translate<0,0,-Tire_R_ +0.04>}
 sphere {<0,0,0>,0.05 scale<1,1,0.5>translate<0,0,-Tire_R_>}
 // spokes
  #local Nr = 0; #local End = 18; #while (Nr<End) 
 union{
 cone{<0,0,0>,0.01,<Wheel_R_-Tire_R_,0,-0.01>,0.06 scale <1,1,0.3> rotate<30,0,0> translate<0,0,-Tire_R_+0.03> }
 rotate<0,0,Nr*360/End>   inverse} 
 #local Nr = Nr + 1; #end
 cylinder{<0,0,-Tire_R_/3>,<0,0,Tire_R_/3>,Wheel_R_-2*Tire_R_  } //texture {Rust}

 texture {  Rim_Texture } 
}// end of union //---------------------------------------- end of Wheel
 



object{  Wheel__ rotate<0,0,Wheel_Rotation_Z> translate<0,Wheel_R_,0>  }
#end // ---------------------------------------------------- end of macro
//---------------------------------------------------------------------- 
//---------------------------------------------------------------------- 




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// example: 
/*
//----------------------------------------------------------------------
//----------------------------------------------------------------------
// ---------------------------------------- optional textures:
#declare Rim_Texture = 
 texture{ //pigment{color White*1.2} 
          Polished_Chrome
          finish { phong 1}
        } // end of texture

#declare Tire_Texture = 
 texture { pigment{color rgb<1,1,1>*0.1}
          // normal {bumps 0.5 scale 0.05}
           finish { phong 0.1}
         } // end of texture
 texture { pigment{agate  scale 0.005
                   color_map{ 
                               [0.0 color Clear]
                               [0.1 color Clear]
                               [0.3 color rgbt<0.11,0.10,0.07,0.7> ]
                               [0.8 color Clear]
                               [1.0 color Clear]
                            }
                  }
           finish { phong 0.1 }
         } // end of texture

#declare Tread_Texture = 
  texture{ pigment{color rgb<1,1,1>*0.1}
           normal { bumps 0.5 scale 0.01}
           finish { phong 0.1}
         } // end of texture
//----------------------------------------------------------------------
#include "Wheel_L02.inc"
//----------------------------------------------------------------------
object{ Wheel_L02 ( -clock*360/18 ) // in degrees; 
        // wheel radius = 0.40; scale it by i.e.: scale MyRadius/0.40 
        scale 1     // scale MyRadius/0.40
        translate<0,0,0>
      } //--------------------------------------------------------------
//----------------------------------------------------------------------
*/
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------


#version Wheel_L02_Inc_Temp;
#end
//------------------------------------- end of include file

