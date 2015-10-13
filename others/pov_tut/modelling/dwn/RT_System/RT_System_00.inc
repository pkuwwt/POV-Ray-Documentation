// POV-Ray 3.6 / 3.7 include file "RT_System_00.inc"                                  // author: Friedrich A, Lohmueller, Feb_2011, 19-May-2013
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_System_00_Inc_Temp)
#declare RT_System_00_Inc_Temp = version;
#version 3.7;

//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"                                             
#end

#ifndef (           RT_System_Sizes_00_Inc_Temp )
#include "RT_System/RT_System_Sizes_00.inc"
#end  // declares Gauge, Rails_Height

#ifndef (           RT_Track_Straight_00_Inc_Temp )
#include "RT_System/RT_Track_Straight_00.inc"
#end  //  

#ifndef (           RT_Track_Curve_00_Inc_Temp )
#include "RT_System/RT_Track_Curve_00.inc"
#end  //  

#ifndef (           RT_Track_Level_Junction_00_Inc_Temp )
#include "RT_System/RT_Track_Level_Junction_00.inc"
#end  //  

#ifndef (           RT_Track_Switch_A_00_Inc_Temp )
#include "RT_System/RT_Track_Switch_A_00.inc"
#end  //  
#ifndef (           RT_Track_Switch_B_00_Inc_Temp )
#include "RT_System/RT_Track_Switch_B_00.inc"
#end  //  


#ifndef (           RT_Track_Switch_3Ways_A_00_Inc_Temp )
#include "RT_System/RT_Track_Switch_3Ways_A_00.inc"  // returns: "Switch_Radius_", "Rail_Distance_"  
#end  //  
#ifndef (           RT_Track_Switch_3Ways_B_00_Inc_Temp )
#include "RT_System/RT_Track_Switch_3Ways_B_00.inc"  // returns: "Switch_Radius_", "Rail_Distance_"  
#end  //  
#ifndef (           RT_Track_Switch_Y_00_Inc_Temp )
#include "RT_System/RT_Track_Switch_Y_00.inc"  // returns: "Switch_Length", "Rail_Distance_" 
#end  //  

//------------------------------------------------------------------------ 
//------------------------------------------------------------------------ 
#ifndef (Rails_Height) #declare Rails_Height 
 = Height_Rail_Top; #end 
//------------------------------------------------------------------------------------------------
#declare HG = Gauge*0.60; 
// sim = -1 -> with base1 
#ifndef( Base_D ) #declare Base_D = 0.20; #end
#ifndef( Base_W ) #declare Base_W = Gauge*1.25; #end
//---------------------------------------------------------------
#declare End_Mark = //sphere{<0,0,0>,GH/2.5 
 cylinder{<0,0,-HG-0.10>,<0,0, HG+0.1>,HG/6
 translate<0,Rails_Height,0>} 
//------------------------------------------------------------------------------ /////////
// track simulation:  Simulate_On___ 
//  -1, // real with flat base
//   0, // real with ties/sleepers
//   1, // double rails - no ties
//   2, // blocks
//   3, // blocks with end markers
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ ///////// 
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////  
//------------------------------------------------------------------------------ ///////// 
#macro RT_Track_Straight_0(  Simulate_On___, 
                             Rail_Lenght___, 
                             Ties_Per_Meter___,
                          ) //-----------------
//------------------------------------------------------------------------------- 
#ifndef( Rails_Quick_Texture )        
#declare Rails_Quick_Texture = texture{ pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_Lines_Texture )        
#declare Rails_Lines_Texture = texture{ pigment{color rgb< 1, 1, 1>*0.15 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_End_Texture )
#declare Rails_End_Texture = texture{pigment{color rgb< 0.75, 0, 0.00>*1 }}// red 
#end//---------------------------------------------------------------
#ifndef( Track_Base_Texture )
#declare Track_Base_Texture = texture{pigment{color rgb<1,1,1>*1.1 }}// superwhite
#end//---------------------------------------------------------------
#ifndef( Gravel_Texture )
#declare Gravel_Texture = texture{ pigment{ color rgb <0.65, 0.50, 0.33>*1.2} 
                                   normal { bumps 2 scale 0.025 }
                                   finish { phong 0.1 } } // rusty brown
#end//---------------------------------------------------------------
#macro Gravel_Linear ( G_Len )
// linear prism in x-direction: from ... to ..., number of points (first = last)
prism { 0.00 , G_Len , 5
        <-Base_W*1.2,-Base_D>, // first point
        < Base_W*1.2,-Base_D>, 
        < Base_W*0.8, 0.05>,
        <-Base_W*0.8, 0.05>,
        <-Base_W*1.2,-Base_D>  // last point = first point!!!
   rotate<-90,-90,0> //turns prism in x direction! Don't change this line!  
   texture{Gravel_Texture}  
 } // end prism
#end 
#macro Gravel_Round ( G_Radius, G_Angel )
intersection{ 
 cone{ <0,-Base_D       ,0>, G_Radius+Base_W*1.2, <0,0     ,0>, G_Radius+Base_W*0.8 }  
 cone{ <0,-Base_D-0.0001,0>, G_Radius-Base_W*1.2, <0,0.0001,0>, G_Radius-Base_W*0.8 inverse }  
 box{<0,-Base_D-0.0002,-G_Radius-Base_W*1.5>,<G_Radius+Base_W*1.5,0.0002,G_Radius+Base_W*1.5>   }   
 box{<-G_Radius-Base_W*1.5,-Base_D-0.0003,-G_Radius-Base_W*1.5>,<0,0.0003,G_Radius+Base_W*1.5> rotate<0,G_Angel,0> }   

 // from <0,0,0> in x+
 translate<0,0,-G_Radius> 
 texture{Gravel_Texture}  
} // end intersection 
#end 

//------------------------------------------------------------------------------- 
#switch (Simulate_On___) 
#case (-2)  // gravel base 1
union{
 object{ RT_Track_Straight_00( Rail_Lenght___,     // Rail_Length,    // in x+ 
                               Ties_Per_Meter___   // Ties_Per_Meter  // ~1.5
                             ) } //---------------------------------------------- 
 object{ Gravel_Linear(Rail_Lenght___) } 
}// end uni 
#break //------------------------------------------------------------------------ 
#case (-1)  // real with base 1
union{
 object{ RT_Track_Straight_00( Rail_Lenght___,     // Rail_Length,    // in x+ 
                               Ties_Per_Meter___   // Ties_Per_Meter  // ~1.5
                             ) } //---------------------------------------------- 
 box{ <0,-Base_D,-Base_W>,<Rail_Lenght___,0, Base_W> texture{Track_Base_Texture}} 
}// end uni 
#break //------------------------------------------------------------------------ 
#case (0)  // real 
object{ RT_Track_Straight_00( Rail_Lenght___,     // Rail_Length,    // in x+ 
                              Ties_Per_Meter___   // Ties_Per_Meter  // ~1.5
                            ) } //----------------------------------------------- 
#break //------------------------------------------------------------------------ 
#case (1) // lines 
union{
 box{ <0,0,-HG-0.10>,<Rail_Lenght___,Rails_Height,-HG> }   
 box{ <0,0, HG>,<Rail_Lenght___,Rails_Height,HG+0.1>  }   
 texture{Rails_Lines_Texture} 
} // end uni 
#break //------------------------------------------------------------------------ 
#case (2)
  box{ <0,0,-HG>,<Rail_Lenght___,Rails_Height, HG> texture{Rails_Quick_Texture}} 
#break //------------------------------------------------------------------------ 
#else // #case (>= 3)
union{ 
  box{ <0,0,-HG>,<Rail_Lenght___,Rails_Height, HG> texture{Rails_Quick_Texture}} 
  object{ End_Mark translate<0,0,0>  texture{Rails_End_Texture }} 
  object{ End_Mark translate<Rail_Lenght___,0,0> texture{Rails_End_Texture }} 
 }   
#break //------------------------------------------------------------------------ 
#end // of (Simulate_On___ = 1)
#end //--------------------------------------------- end of macro
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
#macro RT_Track_Curve_0 (  Simulate_On___,  
                           Curve_Radius___, 
                           Curve_Angle___,
                           Ties_Per_Meter___,
                        ) //----------------- 
//------------------------------------------------------------------------------ 
#ifndef( Rails_Quick_Texture )
#declare Rails_Quick_Texture = texture{pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_Lines_Texture )        
#declare Rails_Lines_Texture = texture{ pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_End_Texture )
#declare Rails_End_Texture = texture{pigment{color rgb< 0.75, 0, 0.00>*1 }}// red 
#end//---------------------------------------------------------------------------
#ifndef( Track_Base_Texture )
#declare Track_Base_Texture = texture{ pigment{color rgb< 1, 0.85, 0.65>*1.0}}// superwhite
#end//---------------------------------------------------------------------------
#ifndef( Gravel_Texture )
#declare Gravel_Texture = texture{ pigment{ color rgb <0.65, 0.50, 0.33>*1.2} 
                                   normal { bumps 2 scale 0.025 }
                                   finish { phong 0.1 } } // rusty brown
#end//---------------------------------------------------------------

#switch (Simulate_On___) 
#case (-2) // gravel base 
union{ 
 object{ RT_Track_Curve_00( Curve_Radius___, // Rail_Radius_,  // in  
                            Curve_Angle___ , // Bow_Angle_,    // in degrees lefthanded  
                            Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                          ) } //------------------------------------------------------- 
 object{  Gravel_Round ( Curve_Radius___, Curve_Angle___ )}  // 
}// end uni 
#break //------------------------------------------------------------------------------
#case (-1)  // real with base 1
union{
 object{ RT_Track_Curve_00( Curve_Radius___, // Rail_Radius_,  // in  
                            Curve_Angle___ , // Bow_Angle_,    // in degrees lefthanded  
                            Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                          ) } //------------------------------------------------------- 
 object{  Segment_of_CylinderRing ( Curve_Radius___+Base_W, Curve_Radius___-Base_W,Base_D, Curve_Angle___) scale<1,-1,1>  
          texture{Track_Base_Texture}    rotate<0,-90,0> translate<0,0,-Curve_Radius___>} 
}// end uni 
#break //------------------------------------------------------------------------ 
#case (0) //--------------------------------------------------------------------- 
object{ RT_Track_Curve_00( Curve_Radius___, // Rail_Radius_,  // in  
                           Curve_Angle___ , // Bow_Angle_,    // in degrees lefthanded  
                           Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                         ) } //-------------------------------------------- 
#break //------------------------------------------------------------------------ 
#case (1)  
union{ //#macro Segment_of_CylinderRing ( R_out, R_in, Height, Segment_Angle)
 object{  Segment_of_CylinderRing ( Curve_Radius___-HG, Curve_Radius___-HG-0.10 ,Rails_Height, Curve_Angle___) }  
 object{  Segment_of_CylinderRing ( Curve_Radius___+HG+0.1, Curve_Radius___+HG ,Rails_Height, Curve_Angle___) }  
 texture{Rails_Lines_Texture} 
 rotate<0,-90,0>  translate<0,0,-Curve_Radius___> 
} // end uni 
#break //------------------------------------------------------------------------ 
#case(2)// case (2)
  object{  Segment_of_CylinderRing ( Curve_Radius___-HG, Curve_Radius___+HG,Rails_Height, Curve_Angle___)   
           texture{Rails_Quick_Texture}  rotate<0,-90,0>  translate<0,0,-Curve_Radius___> } 
#break //------------------------------------------------------------------------ 
#else // case (>=3 )
 union{ 
  object{  Segment_of_CylinderRing ( Curve_Radius___-HG, Curve_Radius___+HG,Rails_Height, Curve_Angle___)   
           texture{Rails_Quick_Texture}  translate<0,0,0> rotate<0,-90,0>} 
  object{ End_Mark translate<0,0, Curve_Radius___> rotate<0,0,0>  texture{Rails_End_Texture }} 
  object{ End_Mark translate<0,0, Curve_Radius___> rotate<0,0+Curve_Angle___,0>  texture{Rails_End_Texture }} 
  translate<0,0,-Curve_Radius___> 
} // end uni 

#break //------------------------------------------------------------------------ 
#end // of (Simulate_On___ = 1)
#end //--------------------------------------------- end of macro
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
#macro RT_Track_Level_Junction_0 ( Simulate_On___, 
                                   Cross_Ang___, 
                                   Main_Len___,
                                   Cross_Len___, 
                                   Ties_Per_Meter___
                                 ) //-------------------------
//------------------------------------------------------------------------ 
#ifndef( Rails_Quick_Texture )
#declare Rails_Quick_Texture = texture{pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_Lines_Texture )        
#declare Rails_Lines_Texture = texture{ pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_End_Texture )
#declare Rails_End_Texture = texture{pigment{color rgb< 0.75, 0, 0.00>*1 }}// red 
#end//---------------------------------------------------------------
#ifndef( Track_Base_Texture )
#declare Track_Base_Texture = texture{ pigment{color rgb< 1, 0.98, 0.95>*1.0}} 
#end//---------------------------------------------------------------
#ifndef( Gravel_Texture )
#declare Gravel_Texture = texture{ pigment{ color rgb <0.65, 0.50, 0.33>*1.2} 
                                   normal { bumps 2 scale 0.025 }
                                   finish { phong 0.1 } } // rusty brown
#end//---------------------------------------------------------------
#switch (Simulate_On___) 
#case (-2) // gravel base 
union{ 
 object{ RT_Track_Level_Junction_00( Cross_Ang___, // Crossing_Angle_, 
                                    Main_Len___, // Rail___Length_Main_,   // in x+/- 
                                    Cross_Len___, // Rail___Length_Cross_,  // in z+/- 
                                    Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                                  ) } //-------------------------------------------- 
 object{ Gravel_Linear(Main_Len___ ) translate<-Main_Len___/2,0,0> } 
 object{ Gravel_Linear(Cross_Len___ ) translate<-Cross_Len___/2,0,0> rotate<0,-Cross_Ang___,0> } 
 translate<Main_Len___/2,0,0>
}// end uni 
#break //------------------------------------------------------------------------------
#case (-1)  // real with base 1
union{
 object{ RT_Track_Level_Junction_00( Cross_Ang___, // Crossing_Angle_, 
                                    Main_Len___, // Rail___Length_Main_,   // in x+/- 
                                    Cross_Len___, // Rail___Length_Cross_,  // in z+/- 
                                    Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                                  ) } //-------------------------------------------- 
 box{ < -Main_Len___/2,-Base_D,-Base_W>,< Main_Len___/2,0, Base_W> texture{Track_Base_Texture}} 
 box{ <-Cross_Len___/2,-Base_D,-Base_W>,<Cross_Len___/2,0, Base_W> texture{Track_Base_Texture} 
      rotate<0,-Cross_Ang___,0> } 
 translate<Main_Len___/2,0,0>
}// end uni 
#break //------------------------------------------------------------------------ 
#case (0) //--------------------------------------------------------------------------
object{ RT_Track_Level_Junction_00( Cross_Ang___, // Crossing_Angle_, 
                                    Main_Len___, // Rail___Length_Main_,   // in x+/- 
                                    Cross_Len___, // Rail___Length_Cross_,  // in z+/- 
                                    Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                                  ) translate<Main_Len___/2,0,0>} //-------------------------------------------- 
#break //------------------------------------------------------------------------ 
#case (1)  
union{ 
 union{
  box{ <-Main_Len___/2,0,-HG-0.10>,<Main_Len___/2,Rails_Height,-HG>}   
  box{ <-Main_Len___/2,0, HG     >,<Main_Len___/2,Rails_Height,HG+0.1> }   
 } // end uni 
 union{
  box{ <-Cross_Len___/2,0,-HG-0.10>,<Cross_Len___/2,Rails_Height,-HG>}   
  box{ <-Cross_Len___/2,0, HG     >,<Cross_Len___/2,Rails_Height,HG+0.1> }   
  rotate<0,-Cross_Ang___,0>
 } // end uni 

texture{Rails_Lines_Texture} 
translate<Main_Len___/2,0,0>
} // end uni 
#break //------------------------------------------------------------------------ 
#else // real 
union{ 
  box{ <-Main_Len___/2,0,-HG>,<Main_Len___/2,Rails_Height, HG> texture{Rails_Quick_Texture}}   
  box{ <-Cross_Len___/2,0,-HG>,<Cross_Len___/2,Rails_Height, HG>   
       rotate<0,-Cross_Ang___,0> texture{Rails_Quick_Texture}}  

  #if (Simulate_On___ =3)
  object{ End_Mark translate<-Main_Len___/2,0,0>  texture{Rails_End_Texture }} 
  object{ End_Mark translate< Main_Len___/2,0,0>  texture{Rails_End_Texture }} 
  object{ End_Mark translate<-Cross_Len___/2,0,0> rotate<0,-Cross_Ang___,0> texture{Rails_End_Texture }} 
  object{ End_Mark translate< Cross_Len___/2,0,0> rotate<0,-Cross_Ang___,0> texture{Rails_End_Texture }} 
  #end
  translate<Main_Len___/2,0,0>
} // end uni 
#break //------------------------------------------------------------------------ 
#end // of (Simulate_On___ = 1)
#end //--------------------------------------------- end of macro
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
#macro RT_Track_Switch_A_0( Simulate_On___, 
                            Switch_Direction___,
                            
                            Switch_Length__in_, 
                            Switch_Angle__in_, 
                            Ties_Per_Meter___
                        )//-------------------------
//------------------------------------------------------------------------ 
#ifndef( Rails_Quick_Texture )
#declare Rails_Quick_Texture = texture{pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_Lines_Texture )        
#declare Rails_Lines_Texture = texture{ pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_End_Texture )
#declare Rails_End_Texture = texture{pigment{color rgb< 0.75, 0, 0.00>*1 }}// red 
#end//---------------------------------------------------------------
#ifndef( Track_Base_Texture )
#declare Track_Base_Texture = texture{ pigment{color rgb< 1, 0.85, 0.65>*1.0}}// superwhite
#end//---------------------------------------------------------------
#ifndef( Gravel_Texture )
#declare Gravel_Texture = texture{ pigment{ color rgb <0.65, 0.50, 0.33>*1.2} 
                                   normal { bumps 2 scale 0.025 }
                                   finish { phong 0.1 } } // rusty brown
#end//---------------------------------------------------------------
#declare Switch_Length___ = Switch_Length__in_;
#declare Switch_Angle___ = Switch_Angle__in_;
#declare Switch_Radius_ = Switch_Length___/ (sin(radians( Switch_Angle___)) ); // declared for extern applications !!! 
#declare Rail_Distance_ = 2*Switch_Radius_*(1-cos(radians( Switch_Angle___) )); // declared for extern applications !!! 
//------------------------------------------------------------------------------------ 
#switch (Simulate_On___) 
#case (-2) // gravel base 
union{ 
 object{ RT_Track_Switch_A_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                              Switch_Length___, // Rail___Length_,
                              Switch_Angle___, // 4.00
                              Ties_Per_Meter___// Ties_Per_Meter_  // ~1.5
                            ) } //---------------------------------------------------- 
 object{ Gravel_Linear(Switch_Length___) } 
 object{ Gravel_Round (Switch_Radius_, Switch_Angle___ )}  // 
}// end uni 
#break //------------------------------------------------------------------------------

#case (-1) // real with base 1
union{
object{ RT_Track_Switch_A_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                              Switch_Length___, // Rail___Length_,
                              Switch_Angle___, // 4.00
                              Ties_Per_Meter___// Ties_Per_Meter_  // ~1.5
                            ) } //---------------------------------------------------- 
 box{ <0,-Base_D,-Base_W>,<Switch_Length___,0, Base_W> texture{Track_Base_Texture}} 
 object{  Segment_of_CylinderRing (Switch_Radius_+Base_W, Switch_Radius_-Base_W,Base_D, Switch_Angle___) scale<1,-1,1>  
         texture{Track_Base_Texture}  translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius_>} 
}// end uni 
#break //----------------------------------------------------------------------------- 
#case (0) // real --------------------------------------------------------------------
object{ RT_Track_Switch_A_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                              Switch_Length___, // Rail___Length_,
                              Switch_Angle___, // 4.00
                              Ties_Per_Meter___// Ties_Per_Meter_  // ~1.5
                            ) //------------------------------------------------------  
    } //------------------------------------------------------------------------------  
#break //-----------------------------------------------------------------------------
#case (1) //--------------------------------------------------------------------------
union{
 object{ RT_Track_Curve_0( Simulate_On___, 
                           Switch_Radius_, // Rail_Radius_,  // in  
                           Switch_Angle___ , // Bow_Angle_,    // in degrees lefthanded  
                           Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                         ) //------------------------------------------------------- 
 } //-------------------------------------------------------------------------------
 object{ RT_Track_Straight_0( Simulate_On___, 
                            Switch_Length___, 
                            Ties_Per_Meter___
                          ) //-------------------------       
 } // 
//---------------------------------------------------------------------------------- 
} // end uni 
#break //--------------------------------------------------------------------------- 
#else //  
union{ 
 box{ <0,0,-HG>,< Switch_Length___,Rails_Height, HG> translate<0,0, 0>  }   
 object{  Segment_of_CylinderRing (Switch_Radius_-HG, Switch_Radius_+HG,Rails_Height, Switch_Angle___)   
         translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius_>} 
 #if (Simulate_On___ =3)
 object{ End_Mark translate<0,0,0>  texture{Rails_End_Texture }} 
 object{ End_Mark translate<Switch_Length___,0,0>  texture{Rails_End_Texture }} 
 object{ End_Mark translate<0,0, Switch_Radius_> rotate<0, Switch_Angle___,0>  translate<0,0,-Switch_Radius_> texture{Rails_End_Texture }} 
 #end
 texture{Rails_Quick_Texture} 

} 
#break //------------------------------------------------------------------------ 
#end // of (Simulate_On___ = 1)
#end //--------------------------------------------- end of macro
//------------------------------------------------------------------------------ /////////

//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
#macro RT_Track_Switch_B_0( Simulate_On___, 
                            Switch_Direction___,
                            
                            Switch_Length__in_, 
                            Switch_Angle__in_, 
                            Ties_Per_Meter___
                        )//-------------------------
//------------------------------------------------------------------------ 
#ifndef( Rails_Quick_Texture )
#declare Rails_Quick_Texture = texture{pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_Lines_Texture )        
#declare Rails_Lines_Texture = texture{ pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_End_Texture )
#declare Rails_End_Texture = texture{pigment{color rgb< 0.75, 0, 0.00>*1 }}// red 
#end//---------------------------------------------------------------
#ifndef( Track_Base_Texture )
#declare Track_Base_Texture = texture{ pigment{color rgb< 1, 0.85, 0.65>*1.0}}// superwhite
#end//---------------------------------------------------------------
#ifndef( Gravel_Texture )
#declare Gravel_Texture = texture{ pigment{ color rgb <0.65, 0.50, 0.33>*1.2} 
                                   normal { bumps 2 scale 0.025 }
                                   finish { phong 0.1 } } // rusty brown
#end//---------------------------------------------------------------
#declare Switch_Length___ = Switch_Length__in_;
#declare Switch_Angle___  = Switch_Angle__in_;

//#declare Switch_Radius_ = Switch_Length___/ (sin(radians( Switch_Angle___)) ); // declared for extern applications !!! 
//#declare Rail_Distance_ = 2*Switch_Radius_*(1-cos(radians( Switch_Angle___) )); // declared for extern applications !!! 
//------------------------------------------------------------------------------------ 
#switch (Simulate_On___) 
#case (-2) // gravel base 
union{ 
 object{ RT_Track_Switch_B_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                              Switch_Length___, // Rail___Length_,
                              Switch_Angle___, // 4.00
                              Ties_Per_Meter___// Ties_Per_Meter_  // ~1.5
                            ) } //---------------------------------------------------- 
 object{ Gravel_Linear(Switch_Length___) } 
 object{ Gravel_Round (Switch_Radius_, Switch_Angle___ )}  // 
}// end uni 
#break //------------------------------------------------------------------------------
#case (-1) // real with base 1
union{
 object{ RT_Track_Switch_B_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                              Switch_Length___, // Rail___Length_,
                              Switch_Angle___, // 4.00
                              Ties_Per_Meter___// Ties_Per_Meter_  // ~1.5
                            ) } //---------------------------------------------------- 
 box{ <0,-Base_D,-Base_W>,<Switch_Length___,0, Base_W> texture{Track_Base_Texture}} 
 object{  Segment_of_CylinderRing (Switch_Radius_+Base_W, Switch_Radius_-Base_W,Base_D, Switch_Angle___) scale<1,-1,1>  
         texture{Track_Base_Texture}  translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius_>} 
}// end uni 
#break //----------------------------------------------------------------------------- 
#case (0) // real --------------------------------------------------------------------
object{ RT_Track_Switch_B_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                              Switch_Length___, // Rail___Length_,
                              Switch_Angle___, // 4.00
                              Ties_Per_Meter___// Ties_Per_Meter_  // ~1.5
                            ) //------------------------------------------------------  
    } //------------------------------------------------------------------------------  
#break //-----------------------------------------------------------------------------
#case (1) //--------------------------------------------------------------------------
union{
 #declare Switch_Radius_n = Switch_Length___/ ( 2* tan(radians( Switch_Angle___/2)) ); // B 
 #declare Rail_Distance_ = 2*Switch_Radius_n*(1-cos(radians( Switch_Angle___) )); // B 
 object{ RT_Track_Curve_0( Simulate_On___, 
                           Switch_Radius_n, // Rail_Radius_,  // in  
                           Switch_Angle___ , // Bow_Angle_,    // in degrees lefthanded  
                           Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                         ) //------------------------------------------------------- 
 } //-------------------------------------------------------------------------------
 object{ RT_Track_Straight_0( Simulate_On___, 
                            Switch_Length___, 
                            Ties_Per_Meter___
                          ) //-------------------------       
 } // 
//---------------------------------------------------------------------------------- 
} // end uni 
#break //--------------------------------------------------------------------------- 
#else //  
 #declare Switch_Radius_n = Switch_Length___/ ( 2* tan(radians( Switch_Angle___/2)) ); // B 
 #declare Rail_Distance_ = 2*Switch_Radius_n*(1-cos(radians( Switch_Angle___) )); // B 
union{ 
 box{ <0,0,-HG>,< Switch_Length___,Rails_Height, HG> translate<0,0, 0>  }   
 object{  Segment_of_CylinderRing (Switch_Radius_n-HG, Switch_Radius_n+HG,Rails_Height, Switch_Angle___)   
         translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius_n>} 
 #if (Simulate_On___ =3)
 object{ End_Mark translate<0,0,0>  texture{Rails_End_Texture }} 
 object{ End_Mark translate<Switch_Length___,0,0>  texture{Rails_End_Texture }} 
 object{ End_Mark translate<0,0, Switch_Radius_n> rotate<0, Switch_Angle___,0>  translate<0,0,-Switch_Radius_n> texture{Rails_End_Texture }} 
 #end
 texture{Rails_Quick_Texture} 

} 
#break //------------------------------------------------------------------------ 
#end // of (Simulate_On___ = 1)
#end //--------------------------------------------- end of macro
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
#macro RT_Track_Switch_Y_0 (     Simulate_On___, 
                                 Switch_Direction___,
                                 Switch_Radius_in,   // in x+ 
                                 Switch_Angle_in, 
                                 Ties_Per_Meter___,
                               ) //-------------------------
//------------------------------------------------------------------------ 
#ifndef( Rails_Quick_Texture )
#declare Rails_Quick_Texture = texture{pigment{color rgb<  1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_Lines_Texture )        
#declare Rails_Lines_Texture = texture{ pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_End_Texture )
#declare Rails_End_Texture = texture{pigment{color rgb< 0.75, 0, 0.00>*1 }}// red 
#end//---------------------------------------------------------------
#ifndef( Track_Base_Texture )
#declare Track_Base_Texture = texture{ pigment{color rgb< 1, 0.85, 0.65>*1.0}}// superwhite
#end//---------------------------------------------------------------
#ifndef( Gravel_Texture )
#declare Gravel_Texture = texture{ pigment{ color rgb <0.65, 0.50, 0.33>*1.2} 
                                   normal { bumps 2 scale 0.025 }
                                   finish { phong 0.1 } } // rusty brown
#end//---------------------------------------------------------------
#declare Switch_Radius___ = Switch_Radius_in; 
#declare Switch_Angle___  = Switch_Angle_in; 
#declare Switch_Length_ = Switch_Radius___ * sin( radians( Switch_Angle___) ) ;
#declare Rail_Distance_ =2*Switch_Radius___ *(1-cos( radians( Switch_Angle___) ) ); 
//------------------------------------------------------------------------ 
//#local Rail_Diag_Add = Rail_Distance___*sin(radians(Switch_Angle___));
//------------------------------------------------------------------------ 
#switch (Simulate_On___) 
#case (-2) // gravel base 
union{ 
 object{ RT_Track_Switch_Y_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                              Switch_Radius_,// Rail___Length_,
                              Switch_Angle___,  // 4.00
                              Ties_Per_Meter___,// Ties_Per_Meter_  // ~1.5
                          ) } //------------------------------------------------------- 
 object{ Gravel_Round (Switch_Radius_, Switch_Angle___ ) scale<1,1,-1>} 
 object{ Gravel_Round (Switch_Radius_, Switch_Angle___ )}  // 
}// end uni 
#break //----------------------------------------------------------------------------- 
#case (-1)  // real with base 1
union{
object{ RT_Track_Switch_Y_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                              Switch_Radius___,// Rail___Length_,
                              Switch_Angle___,  // 4.00
                              Ties_Per_Meter___,// Ties_Per_Meter_  // ~1.5
                          ) } //------------------------------------------------------- 
// box{ <0,-Base_D,-Base_W>,<Switch_Length___,0, Base_W> texture{Track_Base_Texture}} 
 object{ Segment_of_CylinderRing (Switch_Radius___+Base_W, Switch_Radius___-Base_W,Base_D, Switch_Angle___) scale<1,-1,1>  
         texture{Track_Base_Texture}  translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius___>} 
 object{ Segment_of_CylinderRing (Switch_Radius___+Base_W, Switch_Radius___-Base_W,Base_D, Switch_Angle___) scale<1,-1,1>  
         texture{Track_Base_Texture}  translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius___> scale<1,1,-1>} 

}// end uni 
#break //------------------------------------------------------------------------------ 
#case (0) // real----------------------------------------------------------------------
object{ RT_Track_Switch_Y_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                              Switch_Radius___,// Rail___Length_,
                              Switch_Angle___,  // 4.00
                              Ties_Per_Meter___,// Ties_Per_Meter_  // ~1.5
                            ) //------------------------------------------------------- 
   } //--------------------------------------------------------------------------------  
#break 
#case (1) //---------------------------------------------------------------------------
union{
 object{ RT_Track_Curve_0( Simulate_On___, 
                           Switch_Radius___, // Rail_Radius_,  // in  
                           Switch_Angle___, // Bow_Angle_,    // in degrees lefthanded  
                           Ties_Per_Meter___, // Ties_Per_Meter_  // ~1.5
                         ) //-------------------------------------------------- 
 } //--------------------------------------------------------------------------
 object{ RT_Track_Curve_0( Simulate_On___, 
                           Switch_Radius___, // Rail_Radius_,  // in  
                           Switch_Angle___, // Bow_Angle_,    // in degrees lefthanded  
                           Ties_Per_Meter___, // Ties_Per_Meter_  // ~1.5
                         ) scale<1,1,-1>  //----------------------------------- 
 } //--------------------------------------------------------------------------
translate<0,0,0> rotate<0,0,0>
} // end uni 
#break //----------------------------------------------------------------------------- 
#else //  
union{ 
 object{ Segment_of_CylinderRing ( Switch_Radius___-HG, Switch_Radius___+HG,Rails_Height, Switch_Angle___)   
         translate<0,0,0> rotate<0,-90,0>   translate<0,0,-Switch_Radius___> } 
 object{ Segment_of_CylinderRing ( Switch_Radius___-HG, Switch_Radius___+HG,Rails_Height, Switch_Angle___)   
         translate<0,0,0> rotate<0,-90,0>   translate<0,0,-Switch_Radius___> scale<1,1,-1> } 
 #if (Simulate_On___ =3)
 object{ End_Mark translate<0,0,0> texture{Rails_End_Texture } } 
 object{ End_Mark translate<0,0, Switch_Radius___> rotate<0, Switch_Angle___,0>  translate<0,0,-Switch_Radius___> texture{Rails_End_Texture }} 
 object{ End_Mark translate<0,0,-Switch_Radius___> rotate<0,-Switch_Angle___,0>  translate<0,0, Switch_Radius___> texture{Rails_End_Texture }} 
 #end 
 texture{Rails_Quick_Texture} 
 // 
} 
#break //------------------------------------------------------------------------ 
#end // of (Simulate_On___ = 1)

#end //--------------------------------------------- end of macro
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
#macro RT_Track_Switch_3Ways_A_0( Simulate_On___, 
                                  Switch_Direction___,
                                 
                                  Switch_Length__in_, 
                                  Switch_Angle__in_, 
                                  Ties_Per_Meter___
                               ) //-------------------------
//------------------------------------------------------------------------ 
#ifndef( Rails_Quick_Texture )
#declare Rails_Quick_Texture = texture{pigment{color rgb<  1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_Lines_Texture )        
#declare Rails_Lines_Texture = texture{ pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_End_Texture )
#declare Rails_End_Texture = texture{pigment{color rgb< 0.75, 0, 0.00>*1 }}// red 
#end//---------------------------------------------------------------
#ifndef( Track_Base_Texture )
#declare Track_Base_Texture = texture{ pigment{color rgb< 1, 0.85, 0.65>*1.0}}// superwhite
#end//---------------------------------------------------------------
#ifndef( Gravel_Texture )
#declare Gravel_Texture = texture{ pigment{ color rgb <0.65, 0.50, 0.33>*1.2} 
                                   normal { bumps 2 scale 0.025 }
                                   finish { phong 0.1 } } // rusty brown
#end//--------------------------------------------------------------------------------
#declare Switch_Length___ = Switch_Length__in_;
#declare Switch_Angle___  = Switch_Angle__in_ ;
//------------------------------------------------------------------------------------ 
//------------------------------------------------------------------------------------ 
#switch (Simulate_On___) 
#case (-2) // gravel base 
union{ 
 object{ RT_Track_Switch_3Ways_A_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                                     Switch_Length___, // Rail___Length_,
                                     Switch_Angle___, 
                                     Ties_Per_Meter___// Ties_Per_Meter_  // ~1.5
                                  ) } //---------------------------------------------- 
 object{ Gravel_Round (Switch_Radius_, Switch_Angle___ ) scale<1,1,-1> } 
 object{ Gravel_Linear(Switch_Length___)                               } 
 object{ Gravel_Round (Switch_Radius_, Switch_Angle___ )               }  // 
}// end uni 
#break //----------------------------------------------------------------------------- 
#case (-1)  // real with base 1
union{
object{ RT_Track_Switch_3Ways_A_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                                    Switch_Length___, // Rail___Length_,
                                    Switch_Angle___, 
                                    Ties_Per_Meter___// Ties_Per_Meter_  // ~1.5
                                  ) } //---------------------------------------------- 
 box{ <0,-Base_D,-Base_W>,<Switch_Length___,0, Base_W> texture{Track_Base_Texture}} 
 object{ Segment_of_CylinderRing (Switch_Radius_+Base_W, Switch_Radius_-Base_W,Base_D, Switch_Angle___) scale<1,-1,1>  
         texture{Track_Base_Texture}  translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius_>} 
 object{ Segment_of_CylinderRing (Switch_Radius_+Base_W, Switch_Radius_-Base_W,Base_D, Switch_Angle___) scale<1,-1,1>  
         texture{Track_Base_Texture}  translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius_> scale<1,1,-1>} 

}// end uni 
#break //----------------------------------------------------------------------------- 
#case (0) //--------------------------------------------------------------------------
object{ RT_Track_Switch_3Ways_A_00( Switch_Direction___, // 0 straight ~ 1 round (Save 0< x <1)
                                    Switch_Length___, // Rail___Length_,
                                    Switch_Angle___, 
                                    Ties_Per_Meter___// Ties_Per_Meter_  // ~1.5
                                  ) } //---------------------------------------------- 
#break 
#case (1) //--------------------------------------------------------------------------
#declare Switch_Radius_ =  Switch_Length___ / ( sin(radians(Switch_Angle___))); 
#declare Rail_Distance_ =2*Switch_Radius_ *(1-cos(radians(Switch_Angle___))); 
union{
 object{ RT_Track_Curve_0( Simulate_On___, 
                          Switch_Radius_, // Rail_Radius_,  // in  
                          Switch_Angle___ , // Bow_Angle_,    // in degrees lefthanded  
                          Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                        )  //--------------------------------------------------------- 
 } //---------------------------------------------------------------------------------
 object{ RT_Track_Curve_0( Simulate_On___, 
                          Switch_Radius_, // Rail_Radius_,  // in  
                          Switch_Angle___ , // Bow_Angle_,    // in degrees lefthanded  
                          Ties_Per_Meter___ // Ties_Per_Meter_  // ~1.5
                        ) scale<1,1,-1>  //------------------------------------------- 
 } //---------------------------------------------------------------------------------
 object{ RT_Track_Straight_0 ( Simulate_On___, 
                           Switch_Length___, 
                           Ties_Per_Meter___
                         ) //-------------------------       
  } // 
//------------------------------------------------------------------------ 
translate<0,0,0> rotate<0,0,0>
} // end uni 
#break //------------------------------------------------------------------------ 
#else // // case(2) 
#declare Switch_Radius_ =  Switch_Length___ / ( sin(radians(Switch_Angle___))); 
#declare Rail_Distance_ =2*Switch_Radius_ *(1-cos(radians(Switch_Angle___))); 
union{ 
 box{ <0,0,-HG>,< Switch_Length___,Rails_Height, HG> translate<0,0, 0>  }   
 object{ Segment_of_CylinderRing ( Switch_Radius_-HG, Switch_Radius_+HG,Rails_Height, Switch_Angle___)   
         translate<0,0,0> rotate<0,-90,0>   translate<0,0,-Switch_Radius_> } 
 object{ Segment_of_CylinderRing ( Switch_Radius_-HG, Switch_Radius_+HG,Rails_Height, Switch_Angle___)   
         translate<0,0,0> rotate<0,-90,0>   translate<0,0,-Switch_Radius_> scale<1,1,-1> } 
 #if (Simulate_On___ =3)
 object{ End_Mark translate<0,0,0>  texture{Rails_End_Texture }} 
 object{ End_Mark translate<Switch_Length___,0,0>  texture{Rails_End_Texture }} 
 object{ End_Mark translate<0,0, Switch_Radius_> rotate<0, Switch_Angle___,0>  translate<0,0,-Switch_Radius_> texture{Rails_End_Texture }} 
 object{ End_Mark translate<0,0,-Switch_Radius_> rotate<0,-Switch_Angle___,0>  translate<0,0, Switch_Radius_> texture{Rails_End_Texture }} 
 #end
 texture{Rails_Quick_Texture} 
 // 
} 
#break //------------------------------------------------------------------------ 
#end // of (Simulate_On___ = 1)
#end //--------------------------------------------- end of macro
 
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
#macro RT_Track_Switch_3Ways_B_0( Simulate_On___, 
                                  Switch_Direction____,
                                 
                                  Switch_Length____,//in_, 
                                  Switch_Angle____,//in_, 
                                  Ties_Per_Meter____,
                               ) //-------------------------
//------------------------------------------------------------------------ 
#ifndef( Rails_Quick_Texture )
#declare Rails_Quick_Texture = texture{pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_Lines_Texture )        
#declare Rails_Lines_Texture = texture{ pigment{color rgb< 1, 1, 1>*0.85 }} 
#end//---------------------------------------------------------------
#ifndef( Rails_End_Texture )
#declare Rails_End_Texture = texture{pigment{color rgb< 0.75, 0, 0.00>*1 }}// red 
#end//---------------------------------------------------------------
#ifndef( Track_Base_Texture )
#declare Track_Base_Texture = texture{ pigment{color rgb< 1, 0.85, 0.65>*1.0}}// superwhite
#end//---------------------------------------------------------------
#ifndef( Gravel_Texture )
#declare Gravel_Texture = texture{ pigment{ color rgb <0.65, 0.50, 0.33>*1.2} 
                                   normal { bumps 2 scale 0.025 }
                                   finish { phong 0.1 } } // rusty brown
#end//--------------------------------------------------------------------------------
//#declare Switch_Length____ = Switch_Length__in_;
//#declare Switch_Angle____  = Switch_Angle__in_ ;
#declare Switch_Radius_ =  Switch_Length____ / ( sin(radians(Switch_Angle____))); 
#declare Rail_Distance_ =2*Switch_Radius_ *(1-cos(radians(Switch_Angle____))); 
//------------------------------------------------------------------------------------ 
//------------------------------------------------------------------------------------ 
 
#switch (Simulate_On___) 
#case (-2) // gravel base 
union{ 
 object{ RT_Track_Switch_3Ways_B_00( Switch_Direction____, // 0 straight ~ 1 round (Save 0< x <1)
                                     Switch_Length____, // Rail___Length_,
                                     Switch_Angle____, 
                                     Ties_Per_Meter____,// Ties_Per_Meter_  // ~1.5
                                   ) } //----------------------------------------------  
 object{ Gravel_Round (Switch_Radius_, Switch_Angle___ ) scale<1,1,-1>} 
 object{ Gravel_Linear(Switch_Length___) } 
 object{ Gravel_Round (Switch_Radius_, Switch_Angle___ )}  // 
}// end uni 
#break //----------------------------------------------------------------------------- 
#case (-1)  // real with base 1
union{
 
object{ RT_Track_Switch_3Ways_B_00( Switch_Direction____, // 0 straight ~ 1 round (Save 0< x <1)
                                    Switch_Length____, // Rail___Length_,
                                    Switch_Angle____, 
                                    Ties_Per_Meter____,// Ties_Per_Meter_  // ~1.5
                                  ) } //---------------------------------------------- 
 
 box{ <0,-Base_D,-Base_W>,<Switch_Length____,0, Base_W> texture{Track_Base_Texture}} 
 object{ Segment_of_CylinderRing (Switch_Radius_+Base_W, Switch_Radius_-Base_W,Base_D, Switch_Angle____) scale<1,-1,1>  
         texture{Track_Base_Texture}  translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius_>} 
 object{ Segment_of_CylinderRing (Switch_Radius_+Base_W, Switch_Radius_-Base_W,Base_D, Switch_Angle____) scale<1,-1,1>  
         texture{Track_Base_Texture}  translate<0,0,0> rotate<0,-90,0>  translate<0,0,-Switch_Radius_> scale<1,1,-1>} 
 
}// end uni 
#break //----------------------------------------------------------------------------- 

#case (0) //--------------------------------------------------------------------------
object{ RT_Track_Switch_3Ways_B_00( Switch_Direction____, // 0 straight ~ 1 round (Save 0< x <1)
                                    Switch_Length____, // Rail___Length_,
                                    Switch_Angle____, 
                                    Ties_Per_Meter____,// Ties_Per_Meter_  // ~1.5
                                  ) } //---------------------------------------------- 
#break 

#case (1) //--------------------------------------------------------------------------
union{
 #declare Switch_Radius_n = Switch_Length____/ ( 2* tan(radians( Switch_Angle____/2)) ); // B 
 #declare Rail_Distance_ = 2*Switch_Radius_n*(1-cos(radians( Switch_Angle____) )); // B 
 object{ RT_Track_Curve_0( Simulate_On___, 
                          Switch_Radius_n, // Rail_Radius_,  // in  
                          Switch_Angle____, // Bow_Angle_,    // in degrees lefthanded  
                          Ties_Per_Meter____, // Ties_Per_Meter_  // ~1.5
                        )  //--------------------------------------------------------- 
 } //---------------------------------------------------------------------------------
 #declare Switch_Radius_n = Switch_Length____/ ( 2* tan(radians( Switch_Angle____/2)) ); // B 
 #declare Rail_Distance_ = 2*Switch_Radius_n*(1-cos(radians( Switch_Angle____) )); // B 
 object{ RT_Track_Curve_0( Simulate_On___, 
                          Switch_Radius_n, // Rail_Radius_,  // in  
                          Switch_Angle____, // Bow_Angle_,    // in degrees lefthanded  
                          Ties_Per_Meter____, // Ties_Per_Meter_  // ~1.5
                        ) scale<1,1,-1>  //------------------------------------------- 
 } //---------------------------------------------------------------------------------
 object{ RT_Track_Straight_0 ( Simulate_On___, 
                           Switch_Length____, 
                           Ties_Per_Meter____,
                         ) //-------------------------       
  } // 
//------------------------------------------------------------------------ 
translate<0,0,0> rotate<0,0,0>
} // end uni 
#break //------------------------------------------------------------------------ 

#else //  
union{ 
 #declare Switch_Radius_n = Switch_Length____/ ( 2* tan(radians( Switch_Angle____/2)) ); // B 
 #declare Rail_Distance_ = 2*Switch_Radius_n*(1-cos(radians( Switch_Angle____) )); // B 
 box{ <0,0,-HG>,< Switch_Length____,Rails_Height, HG> translate<0,0, 0>  }   
 object{ Segment_of_CylinderRing ( Switch_Radius_-HG, Switch_Radius_+HG,Rails_Height, Switch_Angle____)   
         translate<0,0,0> rotate<0,-90,0>   translate<0,0,-Switch_Radius_> } 
 object{ Segment_of_CylinderRing ( Switch_Radius_n-HG, Switch_Radius_n+HG,Rails_Height, Switch_Angle____)   
         translate<0,0,0> rotate<0,-90,0>   translate<0,0,-Switch_Radius_n> scale<1,1,-1> } 
 #if (Simulate_On___ =3)
 object{ End_Mark translate<0,0,0>  texture{Rails_End_Texture }} 
 object{ End_Mark translate<Switch_Length____,0,0>  texture{Rails_End_Texture }} 
 object{ End_Mark translate<0,0, Switch_Radius_n> rotate<0, Switch_Angle____,0>  translate<0,0,-Switch_Radius_n> texture{Rails_End_Texture }} 
 object{ End_Mark translate<0,0,-Switch_Radius_n> rotate<0,-Switch_Angle____,0>  translate<0,0, Switch_Radius_n> texture{Rails_End_Texture }} 
 #end
 texture{Rails_Quick_Texture} 
 // 
} 
#break //------------------------------------------------------------------------ 
#end // of (Simulate_On___ = 1)
 
#end //--------------------------------------------- end of macro
 // --------------------------------------------------------------------------------------
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////
//------------------------------------------------------------------------------ /////////




//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------


#version RT_System_00_Inc_Temp;
#end
//------------------------------------- end of include file

