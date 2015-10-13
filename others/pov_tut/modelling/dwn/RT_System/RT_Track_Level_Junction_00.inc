// POV-Ray 3.6 include file "RT_Track_Level_Junction_00.inc"                                                                                                                                                // PoVRay 3.6 include File "wheel_000.inc"
// author: Friedrich A, Lohmueller, Aug-2007
// homepage: http://www.f-lohmueller.de/
// email: Friedrich.Lohmueller_aT_t-online.de
//------------------------------------------------------------------------
#ifndef( RT_Track_Level_Junction_00_Inc_Temp)
#declare RT_Track_Level_Junction_00_Inc_Temp = version;
#version 3.5;

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
/*
#ifndef(  Shapes_Inc_Temp)
#include "shapes.inc"                                             
#end
#ifndef(  Shapes3_Inc_Temp)
#include "shapes3.inc"                                             
#end
*/

//------------------------------------------------------------------------------ /////////  
#macro RT_Track_Level_Junction_00( Crossing_Angle_,  // diamond crossing of 2 tracks
                                   Rail___Length_Main_,   // in x+/- 
                                   Rail___Length_Cross_,  // in z+/- 
                                   Ties_Per_Meter_  // ~1.5
                                 ) //--------------------------------------------------------- 
//----------------------------------------------------------------- default textures 
#ifndef( RailToptex ) 
#declare RailToptex = texture{ Polished_Chrome pigment{quick_color White} }
#end
#ifndef( Railtex1 ) 
#declare Railtex1   = texture{ //Rust scale 0.02 pigment{quick_color Tan}
                              pigment{color Tan*0.5}}
#end
#ifndef( Railtex2 ) 
#declare Railtex2   = texture{ //Rust scale 0.02 pigment{quick_color Tan}
                               pigment{color Tan*0.4}}
#end
#ifndef( Tietex1 ) 
#declare Tietex1    = texture{ pigment{ color DarkWood*0.95 quick_color Tan}
                               normal { bumps 0.5 scale 0.005 scale<1,10,30>}
                               finish { diffuse 0.85}}
#end
#ifndef( Tietex2 ) 
#declare Tietex2    = texture{ pigment{ color DarkWood quick_color Tan}
                               normal { bumps 0.55 scale 0.005 scale<1,1,10>}
                               finish { diffuse 0.88}}
#end
#ifndef( Tietex3 ) 
#declare Tietex3    = texture{ pigment{ color DarkWood*0.9 quick_color DarkTan}
                               normal { bumps 0.75 scale 0.005 scale<1,1,10>}}
#end
//---------------------------------------------------------------------------------------
//----------------------------------------------------------------------- Gauche & Heigth
#ifndef (           RT_System_Sizes_00_Inc_Temp )
#include "RT_System/RT_System_Sizes_00.inc"
#end 
//------------------------------------------------------------------------ 
#local D = 0.00001;
//--------------------------------------------------------------------------------------- 
#ifndef ( Rail_Spikes_On )
#declare Rail_Spikes_On = 0; 
#end //----------------------------------------------------------------------------------
#if( Rail_Spikes_On = 1 ) 

#local Spike_Big  = 
union{                                                                                                     //pigment{Cyan}}
  object{ Hexagon scale <0.5,1,1> translate<0.5,0,0> rotate<0,0,90> scale<1,1,1>*0.05 translate<0,0.020,0>  texture{Railtex1}} 
  cone{<0,0.020,>,0.06,<0,0.01,0>,0.085  texture{Railtex1} }
  cylinder{<0,0.01,0>,<0,0,0.00>,0.085   texture{Railtex2} }
  cylinder{<0,0.085,0>,<0,-0.035,0>,0.02 texture{Railtex2} } 
  // pigment{Cyan}
 scale <1,1,1>*0.60  
} // end uni -----------------------------------------------
#local Spike_Small  = 
union{    // in y+ !!!
  box{<-1,0,-1>,<1,1.5,1>            scale<1,1,1>*0.030  texture{Railtex1} translate<0,0.020,0> }  
  box{<-1+D,0,-1+D>,<1-D,1.5+D,1-D>  scale<1,1,1>*0.030  texture{Railtex2} translate<0,0.020,0> }  
  cone{<0,0.020,>,0.06,<0,0.01,0>,0.085  texture{Railtex1} }
  cylinder{<0,0.01,0>,<0,0,0.00>,0.085   texture{Railtex2} }
 scale <1,1,1>*0.40 
} // end uni ----------------------------------------------- 
#local Rail_Spike = 
union{                                                                
       box{<-0.10,         0,-RBaT-0.02 >,<0.10,RBaH+0.002,-RBaT-0.15> texture{Railtex2} } 
       box{<-0.06,RBaH+0.002,-RBaT+0.05 >,<0.06,RBaH+0.022,-RBaT-0.08> texture{Railtex2} }  
       object{  Spike_Big   translate<0,RBaH+0.023,-RBaT-0.035> } 
       object{  Spike_Small rotate<0, 14,0> translate< 0.05,RBaH+0.0025,-RBaT-0.12> } 
       object{  Spike_Small rotate<0,-40,0> translate<-0.05,RBaH+0.0025,-RBaT-0.12> } 
     } // end uni 

#end // of #if( Rail_Spikes_On = 1 ) 
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------- 
//---------------------------------------------------------------------------------------
// Number and distance of the ties/sleepers - Anzahlen und Abstand der Schwellen:
#local Ties_Number_Main_ = int(Rail___Length_Main_*Ties_Per_Meter_);
#local Ties_Number_Cross_= int(Rail___Length_Cross_*Ties_Per_Meter_);
#local Ties_Number_ = int( (Ties_Number_Main_+Ties_Number_Cross_)/2);

#local Ties_Distance = 1/(Ties_Per_Meter_);  // Verteilt Schwellen gleichmäßig über Länge!!!

#local Ties_Distance =  Rail___Length_Main_ /Ties_Number_Main_;   // equidistant distribution !!! 
                                                  // Verteilt Schwellen gleichmäßig über Länge!!!
// --------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
#local Diag_X =  ( 1*RB)/sin(radians(Crossing_Angle_/2)); 
#local Diamond_Length_X = sqrt( pow(Diag_X,2) - pow (( 1*RB),2));
#local Diamond_Length_Y = (2*RB) ;
#local End_Len  = RB*0.5;
#local End_Angle = 15;

//--------------------------------------------------------------- ties / sleepers long - Schwellen lang
#local Tie_Long = union{
 box {<-SD/2+D,0  ,-3*SB+D>,< SD/2-D,SH  ,3*SB-D> texture{Tietex1}}
 box {<-SD/2  ,0+D,-3*SB+D>,< SD/2  ,SH-D,3*SB-D> texture{Tietex2}}
 box {<-SD/2+D,0+D,-3*SB  >,< SD/2-D,SH-D,3*SB  > texture{Tietex3}} }
//--------------------------------------------------------------- ties / sleepersw - Schwellen 
#local Tie = union{
 box {<-SD/2+D,0  ,-SB+D>,< SD/2-D,SH  ,SB-D> texture{Tietex1}}
 box {<-SD/2  ,0+D,-SB+D>,< SD/2  ,SH-D,SB-D> texture{Tietex2}}
 box {<-SD/2+D,0+D,-SB  >,< SD/2-D,SH-D,SB  > texture{Tietex3}}
 #if ( Rail_Spikes_On = 1 )
 object{ Rail_Spike translate<0,SH,-RB>}
 object{ Rail_Spike  scale<1,1,-1> translate<0,SH,-RB>}
 object{ Rail_Spike  translate<0,SH, RB>}
 object{ Rail_Spike  scale<1,1,-1> translate<0,SH, RB>}
 #end 
} // end of union 'Tie' 
//--------------------------------------------------------------- Linear Rails
//--------------------------------------------------------------- Schiene linear
#macro Rail_line_X(Rail_Len)   //-------------------------------- 
#local D = 0.0001;
union{ 
 cylinder {<-Rail_Len/2  ,0,0>,<Rail_Len/2  ,0,0>,RToR scale <1,RToS,1> translate<0,RBoH,0> texture{RailToptex}} //head
 cylinder {<-Rail_Len/2-D,0,0>,<Rail_Len/2+D,0,0>,RToR scale <1,RToS,1> translate<0,RBoH-D,0> texture{Railtex2}} //below head
 cylinder {<-Rail_Len/2-D,0,0>,<Rail_Len/2+D,0,0>,RToR scale <1,RToS,1> translate<0,RBoH-0.02,0> texture{Railtex2}} //below head
 box {<-Rail_Len/2,RBoH-0.02,-RToR>,<Rail_Len/2,RBoH,RToR> texture{Railtex2}} //
 box {<-Rail_Len/2,0.00,-RBoT>,<Rail_Len/2,RBoH,RBoT> texture{Railtex1}} // steg
 box {<-Rail_Len/2,0.00,-RBaT>,<Rail_Len/2,RBaH,RBaT> texture{Railtex2}} // Fuß
 }#end
//---------------------------------------------------------------
//---------------------------------------------------------------
#local Inner_Guider = 
   union{ // inner
          object{ Rail_line_X( Diamond_Length_X*2.3 )} 
          object{ Rail_line_X( End_Len ) translate< End_Len/2,0,0> rotate<0, End_Angle,0> translate< Diamond_Length_X*1.15-RToR,0,0>}
          object{ Rail_line_X( End_Len ) translate<-End_Len/2,0,0> rotate<0,-End_Angle,0> translate<-Diamond_Length_X*1.15+RToR,0,0>}
        } // --------------------------------------
//----------------------------------------------------------------------------<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<                                                                                                  
//----------------------------------------------------------------------------<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<                                                                                                  
#local Height_Top_Edge_Rail =  Height_Rail_Top;
#local Rail_H = Height_Top_Edge_Rail-SH;
#local Tween  = 2*RToR;  // Lücke dazwischen
#local Inner_Ties_Number_ = int(Ties_Number_Main_ *2*Diamond_Length_X/Rail___Length_Main_); 
#local CrossAdd =   1.45*RB* tan(  radians( (Crossing_Angle_/2) )  )  ; 



union{   //------------------------------------------------------------------------------------------------------- final union 
union{ 
    difference{ 
     union{ 
       object{ Rail_line_X( Rail___Length_Main_ ) translate<0,0,-RB>}
       object{ Rail_line_X( Rail___Length_Main_ ) translate<0,0,-RB> scale<1,1,-1>}
     } 
     union{ 
     box{<-Rail___Length_Cross_/2,RBaH+D,-RToR>,<Rail___Length_Cross_/2,Rail_H+D,-RToR-Tween> translate<0,0,RB>               texture{Railtex2}} //  pigment{ Yellow }} 
     box{<-Rail___Length_Cross_/2,RBaH+D,-RToR>,<Rail___Length_Cross_/2,Rail_H+D,-RToR-Tween> translate<0,0,RB> scale<1,1,-1> texture{Railtex2}} // pigment{ Yellow }} 
     //translate<-Rail___Length_Cross_/2,0,0> 
     rotate<0,-Crossing_Angle_,0>
     //translate< Rail___Length_Main_/2,0,0> 
     } // end uni 
   } // end diff
   difference{ 
     union{ 
       object{ Rail_line_X( Rail___Length_Cross_ ) translate<0,0,-RB>}
       object{ Rail_line_X( Rail___Length_Cross_ ) translate<0,0,-RB> scale<1,1,-1>}
  
     //translate<-Rail___Length_Cross_/2,0,0> 
     rotate<0,-Crossing_Angle_,0>
     //translate< Rail___Length_Main_/2,0,0> 
     } 
   box{<-Rail___Length_Main_/2,RBaH+D,-RToR>,<Rail___Length_Main_/2,Rail_H+D,-RToR-Tween> translate<0,0,RB>               texture{Railtex2}} // pigment{ Yellow }} 
   box{<-Rail___Length_Main_/2,RBaH+D,-RToR>,<Rail___Length_Main_/2,Rail_H+D,-RToR-Tween> translate<0,0,RB> scale<1,1,-1> texture{Railtex2}} // pigment{ Yellow }} 
   } // end diff
translate<0.00,SH,0>
} 

 
// inner guider in x
union{ 
   difference{ 
     union{ 
       object{ Inner_Guider translate< Diamond_Length_X*0.00,0, RB-2*RToR-Tween  > } 
       object{ Inner_Guider translate<-Diamond_Length_X*0.00,0, RB-2*RToR-Tween> scale< 1,1,-1> } 
     } // uni 
     union{ // cut off
      box{<-Rail___Length_Cross_/2,RBaH+D,-RToR>,<Rail___Length_Cross_/2,Rail_H+D,-RToR-Tween> translate<0,0,RB>               texture{Railtex2}} //  pigment{ Yellow }} 
      box{<-Rail___Length_Cross_/2,RBaH+D,-RToR>,<Rail___Length_Cross_/2,Rail_H+D,-RToR-Tween> translate<0,0,RB> scale<1,1,-1> texture{Railtex2}} // pigment{ Yellow }} 
      rotate<0,-Crossing_Angle_,0>
     } // uni 
  } // end difference

 

   difference{ 
     union{ 
       object{ Inner_Guider translate<-Diamond_Length_X*0.00,0, RB-2*RToR-Tween  > } 
       object{ Inner_Guider translate< Diamond_Length_X*0.00,0, RB-2*RToR-Tween> scale< 1,1,-1> } 
      rotate<0,-Crossing_Angle_,0>
     } // uni 
     union{ 
      box{<-Rail___Length_Main_/2,RBaH+D,-RToR>,<Rail___Length_Main_/2,Rail_H+D,-RToR-Tween> translate<0,0,RB>               texture{Railtex2}} //  pigment{ Yellow }} 
      box{<-Rail___Length_Main_/2,RBaH+D,-RToR>,<Rail___Length_Main_/2,Rail_H+D,-RToR-Tween> translate<0,0,RB> scale<1,1,-1> texture{Railtex2}} // pigment{ Yellow }} 
      //translate<-Rail___Length_Cross_/2,0,0> 
     } // uni 
  } // end difference
 
translate<0.00,SH,0>
} 


 
// ties or sleepers 
// a) bended center ties
intersection{ 
     union{ // cross 
       #local Nr = -Inner_Ties_Number_/2-1;     // start
       #local EndNr = Inner_Ties_Number_/2+1; // end value
       #while (Nr<=  EndNr) 
        object{ Tie_Long   translate< (Nr+0.5)*Ties_Distance ,0,0>}
           #if ( Rail_Spikes_On = 1 )
              //  object{ Rail_Spike  scale<1,1,-1> translate<0, SH,-RB+RBaT+Tween> rotate<0,-1*Crossing_Angle_/2,0> translate< (Nr+0.5)*Ties_Distance, 0,0>}
              //  object{ Rail_Spike                translate< 0,SH, RB-RBaT-Tween> rotate<0,-1*Crossing_Angle_/2,0> translate< (Nr+0.5)*Ties_Distance, 0,0>}
           #end
       #local Nr = Nr + 1; 
       #end // end of loop 
       rotate<0,-Crossing_Angle_/2,0>
     } // end uni 
   union{  
     box{ <-Rail___Length_Main_/2 -SD,-D,-SB-D>,<Rail___Length_Main_/2 +SD ,SH+D,SB+D>  texture{Tietex3}}  
     box{ <-Rail___Length_Cross_/2-SD,-D,-SB-D>,<Rail___Length_Cross_/2+SD ,SH+D,SB+D>  texture{Tietex3}   
           rotate<0,-Crossing_Angle_,0>} 
   } // end uni 
} // end intersection
 

// b) end ties horizontal in main direction 
     union{ // cross 
       #local Nr = -Ties_Number_Main_/2;     // start
       #local EndNr = Ties_Number_Main_/2; // end value
       #while (Nr<  EndNr) 
         #if ( (Nr < -Inner_Ties_Number_/2-1 ) | (Nr > Inner_Ties_Number_/2+1 ) )
         object{ Tie   translate< (Nr+0.5)*Ties_Distance ,0,0>}
         #else  #if ( Rail_Spikes_On = 1 )

             #if (Nr < 1 |  Nr > 2 ) 
             object{ Rail_Spike  scale<1,1,-1>  translate<0, SH,-RB+RBaT+Tween>  translate< (Nr+0.5)*Ties_Distance+CrossAdd/4,0,0> }
             object{ Rail_Spike  scale<1,1,-1>  translate<0, SH, RB>             translate< (Nr+0.5)*Ties_Distance-CrossAdd*1.25  ,0,0> }
             #end 
             #if (Nr < -3 |  Nr > -2 ) 
             object{ Rail_Spike                 translate<0, SH,-RB >            translate< (Nr+0.5)*Ties_Distance+CrossAdd*1.25 ,0,0> }
             object{ Rail_Spike                 translate<0, SH, RB-RBaT-Tween>  translate< (Nr+0.5)*Ties_Distance-CrossAdd/4,0,0> }
             #end 
          #end  // spikes on 
         #end // of #if
       #local Nr = Nr + 1; 
       #end // end of loop 
      // rotate<0,-Crossing_Angle_/2,0>
     } // end uni 
// c) end ties horizontal bended to crossing direction  
     union{ // cross 
       #local Nr = -Ties_Number_Cross_/2;     // start
       #local EndNr = Ties_Number_Cross_/2; // end value
       #while (Nr<  EndNr) 
         #if ( (Nr < -Inner_Ties_Number_/2-1) | (Nr > Inner_Ties_Number_/2+1 ) )
         object{ Tie   translate< (Nr+0.5)*Ties_Distance ,0,0>}
         #else  #if ( Rail_Spikes_On = 1   ) 
                        
             #if (Nr < -2|  Nr > -1) 
             object{ Rail_Spike  scale<1,1,-1>  translate<0, SH,-RB+RBaT+Tween>  translate< (Nr+0.5)*Ties_Distance-CrossAdd/4,0,0> }
             object{ Rail_Spike  scale<1,1,-1>  translate<0, SH, RB>             translate< (Nr+0.5)*Ties_Distance+CrossAdd*1.25  ,0,0> }
             #end 
           
             #if (Nr < -1 |  Nr > 1) 
               object{ Rail_Spike                 translate<0, SH,-RB >            translate< (Nr+0.5)*Ties_Distance-CrossAdd*1.25  ,0,0> }
               object{ Rail_Spike                 translate<0, SH, RB-RBaT-Tween>  translate< (Nr+0.5)*Ties_Distance+CrossAdd/4,0,0> }
             #end 
 
                #end // spikes on  
          
           #end // of #if
       #local Nr = Nr + 1; 
       #end // end of loop 
       rotate<0,-Crossing_Angle_ ,0>
     } // end uni 


// translate<-Rail___Length_Main_/2,0,0>
// rotate<0,Crossing_Angle_/2,0>
// --------------------------------------------------------------------------------------
} // end of union
#end// of macro ------------------------------------------------------// end of macro
//---------------------------------------------------------------------------------------





//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
//---------------------------------------------------------------------------------------
// sample: 
/*
//-------------------------------------------------------------------------------------//
#include "RT_System/RT_Track_Level_Junction_00.inc" // diamond crossing
//-------------------------------------------------------------------------------------// 
//#declare Rail_Spikes_On = 1;
object{ RT_Track_Level_Junction_00( 15, // Crossing_Angle,        // degrees 
                                     24.00, // Rail_Length_Main,   // in x+/-, meter 
                                     24.00, // Rail_Length_Cross,  // in z+/-, meter  
                                     1.5, // Ties_Per_Meter_  // ~1.5
                                   ) //------------------------------------------------//
        scale <1,1,1>*1
        rotate<0,0,0> 
        translate<0.00,0.00, 0.00>}
//-------------------------------------------------------------------------------------//
//---------------------------------------------------------------------------------------
*/


#version RT_Track_Level_Junction_00_Inc_Temp;
#end
//------------------------------------- end of include file

