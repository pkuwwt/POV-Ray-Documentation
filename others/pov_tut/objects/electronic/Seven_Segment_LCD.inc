// POV-Ray 3.6/3.7 include file "Seven_Segment_LCD.inc.inc"
// author: Friedrich A, Lohmueller, May-2009, May-2014
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Seven_Segment_LCD_Inc_Temp)
#declare Seven_Segment_LCD_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#macro S7_Element( SS_Color__  ) //------------------------------ 
#local SS_Width = 1.2; 
#local SS_Length = 6.0;
#local SS_Diag = sqrt(SS_Width*SS_Width)/2;

// polygon { number of points, list of <x,y> points -  closed series! }
polygon {  7,  
  <-SS_Length/2, 0>, 
  <-SS_Length/2+SS_Diag, -SS_Width/2>, 
  < SS_Length/2-SS_Diag, -SS_Width/2>, 
  < SS_Length/2, 0>, 
  < SS_Length/2-SS_Diag,  SS_Width/2>, 
  <-SS_Length/2+SS_Diag,  SS_Width/2>, 
  <-SS_Length/2, 0> 

  texture {SS_Color__} 
  rotate<90,0,0>
} // end of polygon ----------------------------------------------------------
#end //--------------------------------------------------------- end of macro

//---------------------------------------------
#macro Seven_Segment_LCD(  SS_Number, 
                           SS_Angle, 
                           SS_Background_Scale,
                           SS_Light_Color, 
                           SS_Shade_Color,
                           SS_Background_Color,
                           SS_Point_On, 
                           SS_Point_Active, 
                        ) //-------------------
//---------------------------------------------
#local SS_Len = 6.2;
#local SS_Width = 1.2; 
#local D = 0.0001;  // just a little bit !!
#local Sheer_Factor =  tan(radians(SS_Angle));
//---------------------------------------------
// The sequence of the elements:
//      -       1
//    /  /   6    2
//     -        7
//  /  /     5    3
//   -          4
//
#switch (SS_Number)
#case(-1)
 #local Lights_On = array [7] {0,0,0,0,0,0,1} 
#break
#case(0)
 #local Lights_On = array [7] {1,1,1,1,1,1,0} 
#break
#case(1)
 #local Lights_On = array [7] {0,1,1,0,0,0,0} 
#break
#case(2)
 #local Lights_On = array [7] {1,1,0,1,1,0,1} 
#break
#case(3)
 #local Lights_On = array [7] {1,1,1,1,0,0,1} 
#break
#case(4)
 #local Lights_On = array [7] {0,1,1,0,0,1,1} 
#break
#case(5)
 #local Lights_On = array [7] {1,0,1,1,0,1,1} 
#break
#case(6)
 #local Lights_On = array [7] {1,0,1,1,1,1,1} 
#break
#case(7)
 #local Lights_On = array [7] {1,1,1,0,0,0,0} 
#break
#case(8)
 #local Lights_On = array [7] {1,1,1,1,1,1,1} 
#break
#case(9)
 #local Lights_On = array [7] {1,1,1,1,0,1,1} 
#break
#case(10)// "L"
 #local Lights_On = array [7] {0,0,0,1,1,1,0} 
#break
#case(11)// "o"
 #local Lights_On = array [7] {0,0,1,1,1,0,1} 
#break
#case(12)// "P"
 #local Lights_On = array [7] {1,1,0,0,1,1,1} 
#break
#case(13)// "U"
 #local Lights_On = array [7] {0,1,1,1,1,1,0} 
#break
#case(14)// "R" "A"
 #local Lights_On = array [7] {1,1,1,0,1,1,1} 
#break
#case(15)// "Y"
 #local Lights_On = array [7] {0,1,1,0,0,1,1} 
#break
#case(16)// "-"
 #local Lights_On = array [7] {0,0,0,0,0,0,1} 
#break

#else // nothing - all off!!!
 #local Lights_On = array [7] {0,0,0,0,0,0,0} 
#break 
#end 
  // end arrays
//---------------------------------------
#macro Light_Color(Num) 
#if(Lights_On[Num] = 1)  SS_Light_Color 
#else                    SS_Shade_Color
#end
#end //--------------------- end of macro 
union{ 

 union{ 
 object{ S7_Element( Light_Color(1-1)) translate<0,0, SS_Len> }
 object{ S7_Element( Light_Color(7-1)) translate<0,0, 0> }
 object{ S7_Element( Light_Color(4-1)) translate<0,0,-SS_Len> }

 object{ S7_Element( Light_Color(2-1)) rotate<0,90,0> translate< SS_Len/2,0, SS_Len/2> }
 object{ S7_Element( Light_Color(3-1)) rotate<0,90,0> translate< SS_Len/2,0,-SS_Len/2> }
 object{ S7_Element( Light_Color(6-1)) rotate<0,90,0> translate<-SS_Len/2,0, SS_Len/2> }
 object{ S7_Element( Light_Color(5-1)) rotate<0,90,0> translate<-SS_Len/2,0,-SS_Len/2> }
 
     matrix< 1,  0,  0, // matrix-shear_z_to_x
             0,  1,  0,
          Sheer_Factor, 0,  1,
             0,  0,  0 >    

 } // end LEDs
#if(SS_Point_On = 1)
   disc{ <SS_Len/2*1.25,0.11,-SS_Len>, y,SS_Width/2  
    #if(SS_Point_Active = 1)  texture{ SS_Light_Color}}
    #else                     texture{ SS_Shade_Color}}
    #end 
#end // #if(SS_Point_On = 1) 

box{ <-SS_Len/2,-0.01     ,-SS_Len>,
     < SS_Len/2,-0.0000001, SS_Len> 
     scale SS_Background_Scale  texture {SS_Background_Color}}

translate<0,D,0>
} // end of union                                                             
// -----------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------- textures
#declare Active_Texture = 
   texture { pigment{ color rgb<1,0,0>*1.3 } //  color Red
//  texture { pigment{ color rgb< 0.25, 0.5, 0>*1.7  } //  color Green
//  texture { pigment{ color rgb< 1, 1, 1>*1.1  } //  color White
                   finish { ambient 0.9 diffuse 0.1 phong 1 reflection 0.05}
              } // end of texture 
#declare Inactive_Texture = 
    texture { pigment{ color rgb< 1, 1, 1>*0.35 } //  color gray
                   finish { phong 1 reflection 0.00}
              } // end of texture 
#declare Background_Texture =
    texture { pigment{ color rgb< 1, 1, 1>*0.05 } //  color nearly black
                   finish { phong 1 reflection 0.1}
              } // end of texture 

//----------------------------------------------------------------------------
#include "Seven_Segment_LCD.inc"
//----------------------------------------------------------------------------
object{ Seven_Segment_LCD( 3, // 0~9, integer !!! SS_Number, 
                           10, // 0~10, SS_Angle, 
                           //< 1.5, 10, 1.40>, // SS_Background_Scale, SS_Angle=0  
                           < 1.75, 5 , 1.40>,// for SS_Angle=10
                           Active_Texture, // SS_Light_Color, 
                           Inactive_Texture, //SS_Shade_Color,
                           Background_Texture, //SS_Background_Color,
                           1, // SS_Point_On, 
                           1, // SS_Point_Active, 
                         ) //---------------------------------------
        scale 0.09
        rotate<-90,0,0>
        translate< 0.50,0.75,0>
      }   
//----------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
*/


#version Seven_Segment_LCD_Inc_Temp;
#end
//------------------------------------- end of include file

