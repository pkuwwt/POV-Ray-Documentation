// POV-Ray 3.6 / 3.7 include file "Bike_Chain_Link_1.inc"
// author: Friedrich A, Lohmueller, Feb-2010 / April-2013
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( Bike_Chain_Link_1_Inc_Temp)
#declare Bike_Chain_Link_1_Inc_Temp = version;
#version 3.6;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Colors_Inc_Temp)
#include "colors.inc"                                             
#end
#ifndef(  Textures_Inc_Temp)
#include "textures.inc"                                             
#end
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"                                             
#end


//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ /////////  
#macro Bike_Chain_Link_1 ( // moving in x+; link axes in z, links vertical !!
                         // in= narrow links, thick axis    out = farer distant linksm, thin axis  
                         
                          Link_Type_, // 0 = inner link, 1 = outer link
                          Pitch_,           //  = 0.0127, //   , // pitch or link distance 
                          R_end_,           // ~ 0.012/2, // half height, end radius  
                          Fillet_R_ ,       // ~ 0.015, //  

                          Roller_R_,        // ~0.0036,  // roller radius

                          Total_Width_,     // ~0.015,  // in z direction  
                          Plate_Thickness_, // ~0.0015, // steel thickness of plates
                          Side_Tween_D_,    // ~0.001,  // ring between in/out
                          Border_R_, // 
                         
                       ) // -----------------------
//-------------------------------------------------------------------------

//-------------------------------------------------------------------------
//-------------------------------------------------------- default textures
#ifndef( Chain_Link_Outer_Texture )
#declare Chain_Link_Outer_Texture = 
         texture { Chrome_Metal 
                   pigment{ color rgb< 1, 0.99, 0.95>*0.3 }  
                   normal { bumps 0.05 scale 0.00005}
                   finish { phong 1 reflection 0.15 metallic }
                 } // end of texture 
#end 
#ifndef( Chain_Link_Inner_Texture )
#declare Chain_Link_Inner_Texture = 
         texture { pigment{ color rgb< 1, 1, 1>*0.25 }  
                   finish { phong 0.6 reflection 0.02 metallic }
                 } // end of texture 
#end 
#ifndef( Chain_Axis_Texture )
#declare Chain_Axis_Texture = 
         texture { pigment{ color rgb< 1, 0.95, 0.9>*0.15 }  
                   normal { bumps 0.05 scale 0.00005}
                   finish { phong 1 reflection 0.15 metallic  }
                 } // end of texture 
#end 
#ifndef( Chain_Roller_Texture )
#declare Chain_Roller_Texture = 
         texture { pigment{ color rgb< 1, 1, 1>*0.15 } 
                   finish { phong 0.7 reflection 0.15 metallic  }
                 } // end of texture 
#end 
//-------------------------------------------------------------- dimensions
#local D = 0.00001; 
//-------------------------------------------------------------------------
#local SD = Plate_Thickness_; 
#local HL = Pitch_/2; 
#local BR = Border_R_; 
#local Pin_R_=  Roller_R_ *0.60 ; // inner connection axis
#local Center_Width_ = Total_Width_ - 4*SD -2*Side_Tween_D_ ; 

// in= narrow links, thick axis (roller)
#if ( Link_Type_ = 0 ) //------------in= narrow links, thick axis
#local Connect_Axis_R = Roller_R_; #local Connect_Axis_L = Center_Width_/2+0.5*SD+D;
#local Connector_Z =  Center_Width_/2   + 0.5*SD-2.1*Side_Tween_D_;  //link position 

// out = farer distant links, thin axis  
#else // #if ( Link_Type_ = 1 ) out = farer distant linksm, thin axis  
#local Connect_Axis_R = Pin_R_; #local Connect_Axis_L = Total_Width_; 
#local Connector_Z = Total_Width_ /2-0.5*SD-1.1*Side_Tween_D_; //link position 
#end //------------------------------

//-------------------------
#local Cut_Angle_Radians =  asin( (HL)/( R_end_ +  Fillet_R_) )  ; 
#local Cut_Angle = degrees(Cut_Angle_Radians);
#local Cut_Out_R = sqrt( pow( Fillet_R_+R_end_,2) - pow(HL,2));                              

#local Cut_Out_X =  Fillet_R_/(R_end_ +  Fillet_R_)*HL;// proportional 
#local Cut_Out_Y = R_end_*cos( Cut_Angle_Radians ) ;       
//-----------------------------------------------------------------------------------
#macro Chain_Link_Connector ( Axis_R )  //---------------------------------- submacro

union{ //2
difference{ //2 
 union{ // 1
  // right and left round slice
  object{ Round_Cylinder(<0,0,-SD/2>,<0,0,SD/2>,R_end_,BR,0) translate< HL,0,0> } 
  object{ Round_Cylinder(<0,0,-SD/2>,<0,0,SD/2>,R_end_,BR,0) translate<-HL,0,0> } 
  difference{  // 1 
    box{<-Cut_Out_X,-Cut_Out_Y,-SD/2-D/2>,<Cut_Out_X,Cut_Out_Y,SD/2> }
    // side cut out
    cylinder{ <0,0,-SD/2-D>, <0,0,SD/2+D>,  Fillet_R_ translate<0, Cut_Out_R,0>} 
    cylinder{ <0,0,-SD/2-D>, <0,0,SD/2+D>,  Fillet_R_ translate<0,-Cut_Out_R,0>} 
    // border cut: 
    cylinder{ <0,0,-SD/2-D>, <0,0,-SD/2+BR>,  Fillet_R_+BR translate<0, Cut_Out_R,0>} 
    cylinder{ <0,0, SD/2+D>, <0,0, SD/2-BR>,  Fillet_R_+BR translate<0, Cut_Out_R,0>} 
    cylinder{ <0,0,-SD/2-D>, <0,0,-SD/2+BR>,  Fillet_R_+BR translate<0,-Cut_Out_R,0>} 
    cylinder{ <0,0, SD/2+D>, <0,0, SD/2-BR>,  Fillet_R_+BR translate<0,-Cut_Out_R,0>} 
   } // diff 1
 }// end uni 1 
 
  // holes for axes
  cylinder{ <0,0,-SD/2-D>, <0,0,SD/2+D>,  Axis_R translate< HL,0,0>} 
  cylinder{ <0,0,-SD/2-D>, <0,0,SD/2+D>,  Axis_R translate<-HL,0,0>} 
 }// end difference 2
 
 // rounded side cuts
 object{ Segment_of_Torus(  Fillet_R_+BR,BR,  2*Cut_Angle)  rotate<-90,0,-90+Cut_Angle>
         translate<0, Cut_Out_R,-SD/2+BR  > } 
 object{ Segment_of_Torus(  Fillet_R_+BR,BR,  2*Cut_Angle)  rotate<-90,0,-90+Cut_Angle>
         translate<0, Cut_Out_R, SD/2-BR  > } 
 object{ Segment_of_Torus(  Fillet_R_+BR,BR,  2*Cut_Angle)  rotate<-90,0,-90+Cut_Angle>
         translate<0, Cut_Out_R,-SD/2+BR  > scale<1,-1,1>} 
 object{ Segment_of_Torus(  Fillet_R_+BR,BR,  2*Cut_Angle)  rotate<-90,0,-90+Cut_Angle>
         translate<0, Cut_Out_R, SD/2-BR  > scale<1,-1,1>} 
 
}// end uni 2 
#end //------------------------------------------------------------------------- end submacro
//-------------------------------------------------------------------------------------------
#local Connetion_Axis = 
#if(Link_Type_ = 0)// in = narrow links, thick axis
union{
  difference{ 
    cylinder{<0,0,-Connector_Z-SD/2       >,<0,0,Connector_Z+SD/2  >, Connect_Axis_R }  
    cylinder{<0,0,-Connector_Z-SD/2-D-0.05>,<0,0,Connector_Z+SD/2+D+0.05>, Connect_Axis_R-SD  texture{ Chain_Axis_Texture } }  
    texture{ Chain_Roller_Texture }
  } // end difference
 torus{ Connect_Axis_R-SD+Side_Tween_D_, Side_Tween_D_ rotate<90,0,0> translate<0,0, (Connector_Z+SD/2)> 
        texture{ Chain_Roller_Texture }}
 torus{ Connect_Axis_R-SD+Side_Tween_D_, Side_Tween_D_ rotate<90,0,0> translate<0,0,-(Connector_Z+SD/2)> 
        texture{ Chain_Roller_Texture }}
        
}// end of union
#else //outer link axis     // out = farer distant linksm, thin axis     
union{ 
 cylinder{<0,0,-Total_Width_/2>,<0,0,Total_Width_/2>, Connect_Axis_R  texture{ Chain_Axis_Texture } } 
 sphere{<0,0,0>, Connect_Axis_R scale<1,1,0.1> translate<0,0,-(Connector_Z+SD/2+Side_Tween_D_ )> texture{ Chain_Axis_Texture } } 
 sphere{<0,0,0>, Connect_Axis_R scale<1,1,0.1> translate<0,0,-(Connector_Z+SD/2+Side_Tween_D_ )> texture{ Chain_Axis_Texture } scale<1,1,-1>} 
 torus{ Connect_Axis_R, Side_Tween_D_ rotate<90,0,0> scale<1,1,0.67> translate<0,0,-(Connector_Z+SD/2)> 
         texture{ Chain_Axis_Texture }}
 torus{ Connect_Axis_R, Side_Tween_D_ rotate<90,0,0> scale<1,1,0.67> translate<0,0,-(Connector_Z+SD/2)> 
         texture{ Chain_Axis_Texture }  scale<1,1,-1>}
}// end of union
#end 


//---------------------------------------------------------------------------------
//---------------------------------------------------------------------------------
union{ 
 union{
  object{ Chain_Link_Connector (Connect_Axis_R) translate<0,0, Connector_Z>} 
  object{ Chain_Link_Connector (Connect_Axis_R) translate<0,0,-Connector_Z>} 
 #if(Link_Type_ = 0) 
  texture{ Chain_Link_Inner_Texture }} 
 #else
  texture{ Chain_Link_Outer_Texture }}
 #end 
 
 object{ Connetion_Axis translate< HL,0,0>} 
 object{ Connetion_Axis translate<-HL,0,0>} 
}// end of union 
// --------------------------------------------------------------------------------------
#end// of macro ------------------------------------------------------// end of macro




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//----------------------------------------------------------------------------------------------------//
//----------------------------------------------------------------------------------------------------// 
//------------------------------------------------------------------ optionals textures 
#declare Chain_Link_Outer_Texture = 
         texture { Chrome_Metal 
                   pigment{ color rgb< 1, 0.99, 0.95>*0.3 }  
                   normal { bumps 0.05 scale 0.00005}
                   finish { phong 1 reflection 0.15 metallic }
                 } // end of texture 
#declare Chain_Link_Inner_Texture = 
         texture { pigment{ color rgb< 1, 1, 1>*0.25 }  
                   finish { phong 0.6 reflection 0.02 metallic }
                 } // end of texture 
#declare Chain_Axis_Texture = 
         texture { pigment{ color rgb< 1, 0.95, 0.9>*0.15 }  
                   normal { bumps 0.05 scale 0.00005}
                   finish { phong 1 reflection 0.15 metallic  }
                 } // end of texture 
#declare Chain_Roller_Texture = 
         texture { pigment{ color rgb< 1, 1, 1>*0.15 } 
                   finish { phong 0.7 reflection 0.15 metallic  }
                 } // end of texture 
//----------------------------------------------------------------------------------------------------// 
#include "Bike_Chain_Link_1.inc" 
//----------------------------------------------------------------------------------------------------// 
union{ 
object{ Bike_Chain_Link_1( // moving in x+; link axes in z, links vertical !!
                          // in= narrow links, thick axis(roller)  out = farer distant linksm, thin axis  
                          0, // Link_Type_, // 0 = inner link, 1 = outer link
                          0.0127,  // Pitch_,           //  = 0.0127, //   , // pitch or link distance 
                          0.012/2, // R_end_,           // ~ 0.012/2, // half height, end radius  
                          0.0125,  // Fillet_R_ ,       // ~ 0.075, //  
                          0.0039,  // Roller_R_,        // 0.0077,  // roller radius
                          0.015,   // Total_Width_,     // ~0.015  // in z direction  
                          0.0015,  // Plate_Thickness_, // ~0.0015 // steel thickness of plates
                          0.0005,  // Side_Tween_R_,    // ~0.001  // ring between in/out
                          0.0005,  //Border_R_,  
                       ) // ---------------------------------------------------------------------------
        scale<1,1,1>  rotate<0,0,0>  translate<0,0,0>  
      } // end of object ------------------------------------------------------------------------------ 
//-----------------------------------------------------------------------------------------------------// 
object{ Bike_Chain_Link_1( // moving in x+; link axes in z, links vertical !!
                          // in= narrow links, thick axis(roller)  out = farer distant linksm, thin axis  
                          1, // Link_Type_, // 0 = inner link, 1 = outer link
                          0.0127,  // Pitch_,           //  = 0.0127, //   , // pitch or link distance 
                          0.012/2, // R_end_,           // ~ 0.012/2, // half height, end radius  
                          0.0125,  // Fillet_R_ ,       // ~ 0.075, //  
                          0.0039,  // Roller_R_,        // 0.0077,  // roller radius
                          0.015,   // Total_Width_,     // ~0.015  // in z direction  
                          0.0015,  // Plate_Thickness_, // ~0.0015 // steel thickness of plates
                          0.0005,  // Side_Tween_D_,    // ~0.001  // ring between in/out
                          0.0005,  //Border_R_,  
                       ) // --------------------------------------------------------------------------- 
        scale<1,1,1>  rotate<0,0,0>  translate<-0.0127,0,0>  
      } // end of object ------------------------------------------------------------------------------ 

rotate< 55,0,0>  
translate<0.00,-0.00,-0.01>
} // end uni 
//---------------------------------------------------------------------------------------------------// 
//---------------------------------------------------------------------------------------------------// 
*/


#version Bike_Chain_Link_1_Inc_Temp;
#end
//------------------------------------- end of include file

