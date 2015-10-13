// POV-Ray 3.6 / 3.7 include file "Tower_Round_0.inc"                                                                                                                       
// author: Friedrich A, Lohmueller, Jan-2006 / May-2014 
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Tower_Round_0_Inc_Temp)
#declare Tower_Round_0_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Shapes3_INC_Temp)
#include "shapes3.inc"
#end
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------


//------------------------------------------------------------------------------ /////////  
#macro Tower_Round_0(    Tower__R, // tower radius in x and z                                
                         Tower__H, // tower heigth in y 
                         Tower__Balustrade_H, // tower balustrade high
                         Tower__Wall_D,       // tower wall deepth 
                         Battlements__H,      // battlements height in y
                         Battlements__Angle,  // battlements tween width angle xz around y 
                         Tower_Texture__1, // outside texture
                         Tower_Texture__2  // battlements tween texture
                      ) //------------------------------------------------------------- 
//--------------------------------------------------------------------------------------- 
#local D = 0.0001; // just a little bit 
//------------------------------------------------------------- security checks  
 
#if (Tower__R < Tower__Wall_D) #local Tower__R = Tower__Wall_D + D ; #end 


//------------------------------------------------------------- Tower_Segment 45 degrees 

#local Tower_Segment = 
difference{ 

intersection{ 
cylinder{<0,0,0>,<0,Tower__H,0>,Tower__R } 
box{<0,0,-Tower__R>,< Tower__R , Tower__H+D,0> rotate<0, 45/2,0> }  
box{<0,0,-Tower__R>,<-Tower__R , Tower__H+D,0> rotate<0,-45/2,0> }  
         texture { Tower_Texture__1  }   
} // 
cylinder{ <0,-Tower__Balustrade_H,0>,<0,D,0>,  Tower__R - Tower__Wall_D
          translate<0,Tower__H,0>
          texture { Tower_Texture__1 } 
        } 
//#macro Segment_of_CylinderRing ( R_out, R_in, Height, Segment_Angle)
object{  Segment_of_CylinderRing ( Tower__R+D, 0, Battlements__H+D , Battlements__Angle)   
         translate<0,Tower__H-Battlements__H,0>
         rotate<0, 90.5 - Battlements__Angle/2,0>
         texture { Tower_Texture__2 scale<5,1,1>}   
         scale <1,1,1> rotate<0,0,0> 
      }//----------------------------------------------------------

}// end of difference
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------

union{
object{ Tower_Segment rotate<0,0*45,0>} 
object{ Tower_Segment rotate<0,1*45,0>} 
object{ Tower_Segment rotate<0,2*45,0>} 
object{ Tower_Segment rotate<0,3*45,0>} 
object{ Tower_Segment rotate<0,4*45,0>} 
object{ Tower_Segment rotate<0,5*45,0>} 
object{ Tower_Segment rotate<0,6*45,0>} 
object{ Tower_Segment rotate<0,7*45,0>} 
// the upper floor 
cylinder{ <0,-Tower__Balustrade_H,0>,<0,-Tower__Balustrade_H+2*D,0>,  Tower__R - Tower__Wall_D
          translate<0,Tower__H,0>
          texture { Tower_Texture__1 rotate<90,0,0> } 
        } // end cylinder 
} // end of global union
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------------- textures
#declare Brick_Scale     = <0.07, 0.075, 2>; 
#declare Brick_Translate = <0.0,-0.06+0.25,-0.90>;
#declare Brick_Intensity = 0.35; 
//------------------------------------------------------------- textures
#declare Tower_Texture_1 = // sandstone
         texture { pigment{ color rgb< 0.90, 0.78, 0.60>*1.2}
                   normal { pigment_pattern{ brick 
                                             
                                             color rgb 0.2, 
                                             color rgb 0.8    //mortar 0.10
                                             scale Brick_Scale 
                                             translate Brick_Translate
                                             rotate<0,0,0>} Brick_Intensity}
                   finish { diffuse 0.9 phong 0.1}
                 } // end of texture 
#declare Tower_Texture_2 = // sandstone
         texture { pigment{ color rgb< 0.90, 0.78, 0.60>*0.95*1.2}
                            // color rgb< 0.4,1,0.0>} // test_color
                   normal { pigment_pattern{ brick 
                                             color rgb 0.2, 
                                             color rgb 0.8 
                                             scale Brick_Scale
                                             translate Brick_Translate
                                             rotate<0,0,0>} Brick_Intensity}
                   finish { diffuse 0.9 phong 0.1}
                 } // end of texture 
//---------------------------------------------------------------------------------------
// #include "Tower_Round_0.inc" 
//---------------------------------------------------------------------------------------
object{ Tower_Round_0(   2.50, // Tower_R, // tower radius in x and z                                
                         8.00, // Tower_H, // tower heigth in y 
                         1.50, // Tower_Balustrade_H, // tower balustrade high
                         0.35, // Tower_Wall_D,       // tower wall deepth 
                         0.66, // Battlements_H,           // battlements height in y
                         15.5 // Battlements_Angle,   // battlements angle in xz around y 
                         Tower_Texture_1, // outside texture
                         Tower_Texture_2  // battlements tween texture
                       ) //------------------------------------------------------------// 
        scale <1,1,1>*1
        rotate<0, -60,0> 
        translate<0.00,0.00, 0.00>}
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Tower_Round_0_Inc_Temp;
#end
//------------------------------------- end of include file

